#!/bin/sh

set -e
which carthage || brew install carthage
carthage update --platform iOS