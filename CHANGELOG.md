## Unreleased

### Feat

- add missing system fields and provide query helpers for settings

## v2.8.0 (2023-07-11)

### Feat

- **settings**: add create and update helpers

## v2.7.6 (2023-07-04)

### Fix

- **zones**: add missing fields to create and update

## v2.7.5 (2023-05-08)

### Fix

- **endpoint**: inspect the response for invalid chars

## v2.7.4 (2023-05-08)

### Feat

- **api_wrapper/endpoint**: print payload on parse error

## v2.7.3 (2022-12-01)

### Fix

- **api_wrapper/zones**: use parent id as the param

## v2.7.2 (2022-06-27)

### Feat

- **users**: add include_metadata flag

## v2.7.1 (2022-06-01)

### Feat

- **api_wrapper/users**: add include deleted param ([#31](https://github.com/PlaceOS/crystal-client/pull/31))

## v2.7.0 (2022-05-19)

### Feat

- **`Metadata`**: add `merge` ([#30](https://github.com/PlaceOS/crystal-client/pull/30))

## v2.6.1 (2022-04-08)

### Fix

- looser restriction on models

## v2.6.0 (2022-03-09)

## v2.5.1 (2022-02-04)

### Feat

- **assets**: add missing function
- **asset_instances**: init controller & spec
- **assets**: init controller & spec

## v2.4.4 (2021-09-21)

### Feat

- get_access_token_using_resource_owner_credentials insecure

## v2.4.3 (2021-07-28)

### Fix

- **client**: expose API Keys client

## v2.4.2 (2021-07-28)

### Feat

- add support for x-api-key

## v2.4.1 (2021-06-25)

### Feat

- user search
- support optionally disabling cert checks

## v2.4.0 (2021-06-02)

### Feat

- allow custom host headers to be defined

## v2.2.0 (2021-01-29)

### Feat

- add support for crystal 0.36.0

## v2.1.9 (2020-12-18)

### Fix

- **user model**: only has created at timestamp

## v2.1.8 (2020-12-18)

### Fix

- **user model**: adjusted nilable strings

## v2.1.7 (2020-12-01)

### Feat

- **models system**: add missing fields

## v2.1.6 (2020-10-20)

### Feat

- **zone model**: add additional database fields

### Fix

- **zones spec**: expects count and capacity

## v2.1.5 (2020-10-12)

### Feat

- **client**: re-authenticate on error using refresh token

## v2.1.4 (2020-08-19)

### Fix

- **root#signal**: pass channel argument
- **spec**: metadata mock
- **spec metadata**: use a hash instead of an Array

## v2.1.3 (2020-08-11)

### Fix

- **metadata#fetch**: expects Hash(String, API::Models::Metadata)

## v2.1.2 (2020-08-05)

### Fix

- **systems**: version required as a param

## v2.1.1 (2020-07-30)

### Feat

- expose users in client

## v2.1.0 (2020-07-30)

### Feat

- **users**: add support for resource_token route

## v2.0.3 (2020-07-28)

### Fix

- **metadata spec**: use put instead of post
- **metadata**: use `put` instead of `post`
- **client.cr**: authenticated? check

## v2.0.2 (2020-07-28)

### Fix

- **client**: provide a getter for metadata

## v2.0.1 (2020-07-28)

### Feat

- **metadata**: add support for array data
- **metadata**: support generic metadata

## v1.2.0 (2020-06-22)

### Fix

- **systems**: use set of features

## v1.1.1 (2020-06-17)

### Feat

- **model:trigger**: base trigger models
- **systems**: add `with_emails`

### Fix

- **zones**: add parent param to index
- **zones**: zone tags are an array
- use `placeos-models`

## v1.0.5 (2020-05-04)

### Fix

- **api:root**: correct http verb for `version` route

## v1.0.4 (2020-05-04)

### Feat

- add support for version and signal API calls
- add support for proxying jwt tokens

## v1.0.3 (2020-04-24)

### Fix

- **client**: correct authentication callback

## v1.0.2 (2020-04-24)

### Feat

- **wrapper systems**: add additional filters

## v1.0.1 (2020-04-22)

### Feat

- **authentication**: support user auth
- **auth**: implement OAuthApplications route
- **auths**: implement ldap, saml, and oauth routes
- **modules**: implement and spec modules route
- **systems**: rename methods, implement specs
- **api_wrapper**: models for websocket messages
- **api_wraper**: add delegates for connection
- **api_wrapper**: implement zones endpoint
- **api_wrapper**: implement modules endpoint
- **api_wrapper**: add module model
- **api_wrapper**: module type and count queries
- **api_wrapper**: support state and funcs queries
- **api_wrapper**: implement module interactions
- **api_wrapper**: implement systems interactions
- **api_wrapper**: system creation
- **api_wrapper**: support systems query
- **api_wrapper**: implement authority endpoint

### Fix

- pull `PLACE_URI` from environment
- **client**: generate method for OAuthApplications
- **api_wrapper**: invalid reference in auth
- **api_wrapper**: incorrect query methods
- **models**: add missing edge_id to system
- **api_wrapper**: support all serializable bodies
- **api_wrapper**: hide direct http methods

### Refactor

- initial refactor and test zones
- `ACAEngine` -> `PlaceOS`
- **models**: remove unnecessary annotations
- **api_wrapper**: change settings type
- **api_wrapper**: use nil for optional param
- **api_wrapper**: split query types
- **api_wrapper**: neaten up requests macros
- **api_wrapper**: auto map mod -> module
- **api_wrapper**: request macro
- **api_wrapper**: relocate model requires
- seperate client, api and api_wrapper
