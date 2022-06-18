#!/usr/bin/env bash

set -e

GOPATH=$(go env GOPATH)

$GOPATH/bin/hugo new posts/$1.md
