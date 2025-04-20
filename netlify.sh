#!/usr/bin/env bash

set -e

# uses go 1.14
GO111MODULE=on go get github.com/gohugoio/hugo@v0.79.0

$GOPATH/bin/hugo
