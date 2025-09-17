#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Approve PR
# @raycast.argument1 { "type": "text", "placeholder": "https://github.com/ryanmiville/rymi-utils/pull/5" }
# @raycast.mode silent

gh pr review "$1" --approve
