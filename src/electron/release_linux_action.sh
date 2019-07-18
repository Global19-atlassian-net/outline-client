#!/bin/bash -eu
#
# Copyright 2018 The Outline Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Same as package, except:
#  - prod Sentry keys are used
#  - auto-updates are configured

yarn do src/electron/package_common

scripts/environment_json.sh -r -p linux > www/environment.json

# Set-up electron to only download new updates but never upload new ones
electron-builder \
  --linux \
  # Disable publishing from Electron
  --publish never \
  --config src/electron/electron-builder.json \
  --config.extraMetadata.version=1.0.8 \
  # Set up where to fetch updates from
  --config.publish.provider=s3 \
  --config.publish.bucket=outline-releases \
  --config.publish.path=test
