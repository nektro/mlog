#!/usr/bin/env bash

set -e

GOPATH=$(go env GOPATH)

$GOPATH/bin/hugo server
