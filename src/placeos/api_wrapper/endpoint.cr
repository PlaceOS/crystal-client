require "../api_wrapper"

module PlaceOS
  # :nodoc:
  abstract class Client::APIWrapper::Endpoint
    # The base route for the endpoint
    abstract def base : String

    protected getter client : APIWrapper

    def initialize(@client : APIWrapper)
    end

    {% for method in %w(get post put head delete patch options) %}
    # Executes a {{method.id.upcase}} request on the client connection.
    #
    # The response status will be automatically checked and a
    # `PlaceOS::Client::Error` raised if unsuccessful.
    #
    # Macro expansion allows this to obtain context from a surround method and
    # use method arguments to build an appropriate request structure. Pass
    # `from_args` to to either *params* or *body* for the magic to happen.
    # Alternatively, you may specify a NamedTuple for the contents of either of
    # these.
    #
    # Us *as* to specify a JSON parse-able model that the response should be
    # piped into. If unspecified a `JSON::Any` will be returned.
    macro {{method.id}}(path, params = nil, headers = nil, body = nil, as model = nil)
      {% verbatim do %}
        # Append query params to the path
        {% if params.id.symbolize == :from_args %}
          params = HTTP::Params.build do |param|
            each_arg do |key, val, default|
              param.add \{{key}}, \{{val}}.to_s unless \{{val}}.nil?
            end
          end
          path = "#{{{path}}}?#{params}"
        {% elsif !params.nil? && !params.is_a?(NilLiteral) %}
          path = "#{{{path}}}?#{{{params}}}"
        {% else %}
          path = "#{{{path}}}"
        {% end %}

        headers = {{headers}}

        # Build a body (if required)
        {% if body.id.symbolize == :from_args || body.is_a? NamedTupleLiteral | HashLiteral %}
          headers ||= HTTP::Headers.new
          headers["Content-Type"] = "application/json"

          body = JSON.build do |json|
              {% if body.id.symbolize == :from_args %}
                json.object do
                  each_arg do |key, val, default|
                    json.field \{{key}}, \{{val}} unless \{{val}} == \{{default}}
                  end
              {% elsif body.is_a? NamedTupleLiteral | HashLiteral %}
                  {% for key, value in body %}
                    json.field {{key.stringify}}, {{value}}
                  {% end %}
              {% end %}
            end
          end
        {% elsif body.is_a? NilLiteral %}
          body = nil
        {% else %}
          headers ||= HTTP::Headers.new
          headers["Content-Type"] = "application/json"
          body = {{body}}.to_json
        {% end %}
      {% end %}

      # Exec the request
      response = client.connection.{{method.id}} path, headers, body
      raise API::Error.from_response(response) unless response.success?

      # Parse the response
      {% verbatim do %}
        {% if model %}
          {{model}}.from_json response.body
        {% else %}
          if response.body.empty?
            JSON::Any.new nil
          else
            JSON.parse response.body
          end
        {% end %}
      {% end %}
    end
  {% end %}

    # Yields a stringified key, reference and default value for arguments of
    # interest from the enclosing method.
    #
    # Handles a few common mappings / exlusions.
    private macro each_arg(&block)
    # Ignore `id` as this it used exlusively in path params.
    {% for arg in @def.args.reject(&.name.symbolize.== :id) %}
      # `module` is a reserved word, remap mod -> module
      {% key = arg.name.symbolize == :mod ? "module" : arg.name.stringify %}
      {{ yield key, arg.name, arg.default_value }}
    {% end %}
  end
  end
end
