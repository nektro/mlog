#!/usr/bin/env bash

set -e

GO111MODULE=on go get -v github.com/gohugoio/hugo@v0.79.0

$GOPATH/bin/hugo
