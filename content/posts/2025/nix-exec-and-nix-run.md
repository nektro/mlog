---
title: "nix-exec and nix-run"
date: 2025-12-06T23:40:56-08:00
---

First the commands and then we will discuss the why and how.

```sh
# Usage:
# nix-exec PKG CMD [ARG]...
nix-exec() {
  local thepkg="$1"
  shift
  local thecmd="$1"
  shift

  nix-shell -p "$thepkg" --run "exit 0"
  if [ "$?" != "0" ]; then
    return
  fi

  local pkgpath=$(nix-instantiate --eval-only --expr "(import <nixpkgs> {}).$thepkg" --raw)
  "$pkgpath"/bin/"$thecmd" "$@"
}
```

```sh
# Usage:
# nix-run -- CMD [ARG]...
# nix-run PKG CMD [ARG]...
nix-run() {
  local thepkg="$1"
  shift

  if [ "$thepkg" = "--" ]; then
    thepkg="$1"
    shift
    nix-exec "$thepkg" "$thepkg" "$@"
    return
  fi

  local thecmd="$1"
  shift
  nix-exec "$thepkg" "$thecmd" "$@"
}
```

----

Many users of [NixOS](https://nixos.org/) will be familiar with the venerable `nix-shell` command. For anyone unaware, this is a utility that comes with the Nix
package manager that allows you to, among other features, create a temporary shell with any package from nixpkgs in PATH without installing it into your environment.
This is fantastic for calling one-off programs that you may not use often or for keeping your main environment slim.

`nix-shell` is primarily meant to be used interactively, eg. you call `nix-shell` (or eg `nix-shell -p sqlitebrowser`) and this calls `bash` with the right arguments
starting a new session. However I found when scripting that this was not always ideal. `nix-shell` offers a `--run` parameter to execute a command non-interactively
in the newly created session and then exit but this gave me problems which I will now demonstrate. This issue is what prevented me from publishing this earlier.
Here's an earlier version of this command:

```sh
nix-run() {
  local thecmd="$1"
  shift
  nix-shell -p "$thecmd" --run "$thecmd $@"
}
```

Now if you run this with say `nix-run-old echo a b c` then you get an error like so:

```
[meghan@nixos:~]$ nix-run-old echo a b c
error:
<snip>
       error: undefined variable 'echo'
       at «string»:1:107:
            1| {...}@args: with import <nixpkgs> args; (pkgs.runCommandCC or pkgs.runCommand) "shell" { buildInputs = [ (echo) (b) (c) ]; } ""
             |                                                                                                           ^
```

See how it's trying to evaluate `b` and `c` as packages instead of arguments to `echo`? Well now that I was writing out this blog post I realized a version I could've
been using all along but it may have one more issue I was concerned about...

```sh
nix-run() {
  local thecmd="$1"
  local allofthem="$*"
  shift
  nix-shell -p "$thecmd" --run "$allofthem"
}
```

Now, `$allofthem` captures all the arguments into a single string *before* the array is separated and we get the error we were expecting:

```
error:
<snip>
       error: undefined variable 'echo'
       at «string»:1:107:
            1| {...}@args: with import <nixpkgs> args; (pkgs.runCommandCC or pkgs.runCommand) "shell" { buildInputs = [ (echo) ]; } ""
             |                                                                                                           ^
```

This is great but as I hinted at earlier I like to use this while scripting. Consider the case where the argument we want to pass is not a literal. I use a compiled-from-source
version of Zigmod so perhaps I want to run that in GDB and run `nix-run -- gdb $(which zigmod)`. With the version we just defined this unfortunately does not work:

```
error: '--run' requires an argument
Try 'nix-shell --help' for more information.
```

So now we're in a good place to get to what I landed on.

```sh
# Usage:
# nix-run -- CMD [ARG]...
# nix-run PKG CMD [ARG]...
nix-run() {
```

This is an expanded version that also accepts a use-case where the name of the package doesn't match the name of the binary. The general idea for this command is
inspired by [`npx`](https://docs.npmjs.com/cli/v8/commands/npx), [`bunx`](https://bun.com/docs/pm/bunx), [`uvx`](https://docs.astral.sh/uv/guides/tools/), etc but
allows querying nixpkgs instead.

```sh
  local thepkg="$1"
  shift
```

This grabs the first parameter but at this point we're not sure what we are going to do with it yet.

```sh
  if [ "$thepkg" = "--" ]; then
    thepkg="$1"
    shift
    nix-exec "$thepkg" "$thepkg" "$@"
    return
  fi
```

This section allows inferring the package name from the command name and is often the happy path, so we capture that name and call `nix-exec`. That command has
the meat of the detail here but always expects the package and command name.

```sh
  local thecmd="$1"
  shift
  nix-exec "$thepkg" "$thecmd" "$@"
}
```

This section is the fallback that assumes you passed both names. Using the quoted `"$@"` ensures the arguments are passed to argv the same way the user did. Conversely,
`$@` would have bash re-evaluate them and ruining quotation and `"$*"` would capture all arguments into a single string.

```sh
# Usage:
# nix-exec PKG CMD [ARG]...
nix-exec() {
  local thepkg="$1"
  shift
  local thecmd="$1"
  shift
```

`nix-run` is now a wrapper around this so we can be cleaner about our assumptions around how the arguments are passed. For this one a package name and command name
will always be present so we can grab those now.

```sh
  nix-shell -p "$thepkg" --run "exit 0"
  if [ "$?" != "0" ]; then
    return
  fi
```

We still rely on `nix-shell` to populate the Nix Store and show any errors to the user around a package not existing etc. Make sure to bail out if Nix did.

```sh
  local pkgpath=$(nix-instantiate --eval-only --expr "(import <nixpkgs> {}).$thepkg" --raw)
  "$pkgpath"/bin/"$thecmd" "$@"
}
```

Now the magic sauce of this version of the command is that we use `nix-shell` to populate the store but call the command outside. `nix-instantiate` returns the
absolute path of the package and then we call it with the rest of the arguments from earlier.

All together it works exactly as we desired!

```
$ nix-run -- gdb `which zigmod`
GNU gdb (GDB) 16.3
Copyright (C) 2024 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-unknown-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<https://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from /home/meghan/dev/zigmod/zig-out/bin/zigmod...
(gdb)
```

----

After landing on the version above and telling some friends I was introduced to https://github.com/nix-community/comma. This is a great utility as well and I will
definitely be adding it to my arsenel.

Happy coding!
