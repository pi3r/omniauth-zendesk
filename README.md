# OmniAuth Zendesk

This is an OmniAuth strategy for authenticating to Zendesk. To
use it, you'll need create an OAuth client in your admin interface
(Channels > API > OAuth Clients > add a client).

## Basic Usage

    use OmniAuth::Builder do
      provider :zendesk, ENV['ZENDESK_CLIENT_ID'], ENV['ZENDESK_CLIENT_SECRET']
    end

## Note on Patches/Pull Requests

1. Fork the project.
2. Make your feature addition or bug fix.
3. Send a pull request.

## Copyright and License

Copyright 2013 Pierre Nespo

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
