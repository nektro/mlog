---
title: "mirrors.nektro.net/zig/"
date: 2025-07-28T01:38:15-07:00
---

Since June 2024 I've been operating a mirror for Zig releases at http://mirrors.nektro.net/zig/.

https://github.com/mlugg/setup-zig was testflighting what would eventually become the https://ziglang.org/download/community-mirrors/ system and I wanted a browsable directory of all past versions. At time of writing it has 0.11, 0.12, 0.13, all of 0.14-dev, 0.14, 0.14.1, all of 0.15-dev so far.

This isn't a tutorial per se since this setup isn't actually eligible for the Community Mirrors listing (as it queries for new versions on a cron job instead of on request), but it works for me and sharing is caring so here it is in the hopes it may be helpful to someone else or any potential future version of myself.

An example of using this mirror with `setup-zig` can be seen here: https://github.com/nektro/zigmod/blob/master/.github/workflows/push.yml#L19.

The first bit is an nginx rewrite rule that allows flat namespace requests that `setup-zig` makes to be compatible with the versioned folders that actually exist on disk. So a request for say
`http://mirrors.nektro.net/s3cgi/zig-aarch64-linux-0.15.0-dev.769+4d7980645.tar.xz` is actually gonna reroute to
`http://mirrors.nektro.net/zig/0.15.0-dev.769+4d7980645/zig-aarch64-linux-0.15.0-dev.769+4d7980645.tar.xz`. I'll have to update this soon since ZSF updated the pattern for tarballs starting with `>=0.15.0-dev.631+9a3540d61` for master builds and `>= 0.14.1` for tagged releases to be `zig-arch-os-version.ext`.

```nginx
[pontus ~] cat .nginx/conf.d/000-default-server.conf
    location ~ /s3cgi {
        rewrite ^\/s3cgi\/zig\-(windows|macos|linux|freebsd|netbsd)\-(x86_64|aarch64|riscv64)-(\d\.\d+\.\d(?:\-dev\.\d+\+[0-9a-f]+)?)(\.tar\.xz|\.zip)((?:\.minisig)?)$ /zig/$3/zig-$1-$2-$3$4$5 last;
    }
```

Below are the scripts I run on the aforementioned cron job to query `index.json` and download the latest tarballs and [minisign](https://jedisct1.github.io/minisign/) files.

```sh
[pontus ~] cat download_zig_release.sh
#!/bin/bash

has_exec() {
  which "$1" >/dev/null 2>&1 || return 1
}
fail() {
  has_failure=1
  printf "${C_RED}setup error${C_RESET}: %s\n" "$@"
}
test_exec() {
  has_exec "$1" || fail "'$1' is missing"
}
parallelwget() {
  printf '%s\n' $@ | xargs -L1 wget -q --show-progress --no-clobber
}

test_exec 'curl'
test_exec 'xargs'
test_exec 'wget'

if [ -n "$has_failure" ]; then
  exit 1
fi

echo 'have all prorams. good.'

original_dir=$PWD
self_file=$0
self_dir=$(dirname $self_file)

cd $self_dir
jq=$(realpath ./jq-linux-amd64)
cd www/mirrors.nektro.net/public_html/zig

zig_version=$(curl -s https://ziglang.org/download/index.json | $jq -r '.master.version')
zig_version=${1:-$zig_version}
echo "saving Zig version: ${zig_version}"

mkdir -p $zig_version
cd $zig_version

parallelwget https://ziglang.org/download/${zig_version}/zig-{x86_64,aarch64}-windows-${zig_version}.zip{,.minisig}
parallelwget https://ziglang.org/download/${zig_version}/zig-{x86_64,aarch64}-macos-${zig_version}.tar.xz{,.minisig}
parallelwget https://ziglang.org/download/${zig_version}/zig-{x86_64,aarch64,riscv64}-linux-${zig_version}.tar.xz{,.minisig}
parallelwget https://ziglang.org/download/${zig_version}/zig-{x86_64,aarch64,riscv64}-freebsd-${zig_version}.tar.xz{,.minisig}
parallelwget https://ziglang.org/download/${zig_version}/zig-{x86_64,aarch64}-netbsd-${zig_version}.tar.xz{,.minisig}
```

```sh
[pontus ~] cat download_zig_master.sh
#!/bin/bash

has_exec() {
  which "$1" >/dev/null 2>&1 || return 1
}
fail() {
  has_failure=1
  printf "${C_RED}setup error${C_RESET}: %s\n" "$@"
}
test_exec() {
  has_exec "$1" || fail "'$1' is missing"
}
parallelwget() {
  printf '%s\n' $@ | xargs -L1 wget -q --show-progress --no-clobber
}

test_exec 'curl'
test_exec 'xargs'
test_exec 'wget'

if [ -n "$has_failure" ]; then
  exit 1
fi

echo 'have all prorams. good.'

original_dir=$PWD
self_file=$0
self_dir=$(dirname $self_file)

cd $self_dir
jq=$(realpath ./jq-linux-amd64)
cd www/mirrors.nektro.net/public_html/zig

zig_version=$(curl -s https://ziglang.org/download/index.json | $jq -r '.master.version')
zig_version=${1:-$zig_version}
echo "saving Zig version: ${zig_version}"

mkdir -p $zig_version
cd $zig_version

parallelwget https://ziglang.org/builds/zig-{x86_64,aarch64}-windows-${zig_version}.zip{,.minisig}
parallelwget https://ziglang.org/builds/zig-{x86_64,aarch64}-macos-${zig_version}.tar.xz{,.minisig}
parallelwget https://ziglang.org/builds/zig-{x86_64,aarch64,riscv64}-linux-${zig_version}.tar.xz{,.minisig}
parallelwget https://ziglang.org/builds/zig-{x86_64,aarch64,riscv64}-freebsd-${zig_version}.tar.xz{,.minisig}
parallelwget https://ziglang.org/builds/zig-{x86_64,aarch64}-netbsd-${zig_version}.tar.xz{,.minisig}
```

As for why I haven't setup HTTPS yet, it is because the hosting provider I use for this particular box doesn't make it super simple to setup on custom domains and verifying the minisign signatures when I download provides the same security guarantees that HTTPS would.

At time of writing the disk usage is 232 / 1000 GB (last calculated 2025-07-28 07:06 UTC).
