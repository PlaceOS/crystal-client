require "../api_wrapper"

module PlaceOS
  # :nodoc:
  abstract class Client::APIWrapper::Endpoint
    # The base route for the endpoint
    abstract def base : String

    protected getter client : APIWrapper

    def initialize(@client : APIWrapper)
    end

    module Fetch(T)
      # Returns a {{ T.id }}
      def fetch(id : String)
        get "#{base}/#{id}", as: T
      end
    end

    module Destroy
      # Destroys a {{ T.id }}
      def destroy(id : String)
        delete "#{base}/#{id}"
        nil
      end
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
              unless \{{val}}.nil?
                v = \{{val}}.is_a?(Array) ? \{{val}}.map(&.to_s).join(',') : \{{val}}.to_s
                param.add \{{key}}, v
              end
            end
          end
          path = params.empty? ? {{path}} : "#{{{path}}}?#{params}"
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

      if host_header = client.host_header.presence
        headers ||= HTTP::Headers.new
        headers["Host"] = host_header
      end

      # Exec the request
      response = client.connection &.{{method.id}}(path, headers, body)
      raise API::Error.from_response(response) unless response.success?

      # Parse the response
      {% verbatim do %}
        {% if model %}
          response_body = response.body
          begin
            {{model}}.from_json response_body
          rescue error : JSON::Error
            Log.warn { "failed to parse #{path}:\n#{response_body.inspect}" }
            raise error
          end
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
