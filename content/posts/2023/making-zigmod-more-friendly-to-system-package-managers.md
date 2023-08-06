---
title: "Making Zigmod More Friendly to System Package Managers"
date: 2023-08-05T18:41:48-07:00
---

As the developer of a source package manager (for the reference point of this article) rather than one of a system package manager (eg `apt`, `apk`, `pacman`, `nix`) it is very easy for me to prioritize the users who only build their apps from source by running `zigmod fetch` and `zig build`, either locally or in CI. Zig already makes a lot of headway in ensuring this is a just-works experience and Zigmod fits in snuggly. However, if we are to expect that projects and programs made with Zigmod are to ever make it into the package repositories managed by the systems mentioned at the start, then we have to make sure it works smoothly into their processes too.

As the developer of a system package manager (through https://git.sr.ht/~nektro/wifilylinux) I've been getting a taste of the other side and even though that project probably doesn't support your favorite program yet, I am already starting to see a few patterns emerge that make my job over there a whole lot easier. The gold standard for dependency discovery has got to be the `PATH`-esque environment variable. Gone are the days where it is safe or robust to assume that your depdendencies will always be at some system-wide path such as `/usr`. The `PATH`-esque enviroment variable neatly fills that gap by being a `:` separated list of directories to search, and should it ever be empty or missing then you can gracefully fallback to search the default path like before.

This is ideal in projects such as Wifily or [NixOS](https://nixos.org/) since we take advantage of the installation prefix to move each program to its own directory. This opens up the opportunity to have multiple versions of the same app installed at once and creates a better audit evironment for [reproducible builds](https://reproducible-builds.org/).

To this end, I am proposing Zigmod begins to support `ZIGMOD_SEARCH_PATH` which will act as the search path for `zigmod fetch` and `zigmod ci` when set, rather than a relative `.zigmod` directory. If it is empty or not set, it will behave as normal. Setting this variable will disable Zigmod from attempting to connect to the network and hard-error if a package is not found.

---

This will be a quite a non-invasive change for nearly all regular users of Zigmod and many of its other philosophies already work exceptionally well towards this goal.

- Zigmod expects to [build at HEAD](https://mlog.nektro.net/posts/2023/automating-living-at-head-with-zigmod/) and globally(per compilation) deduplicates dependencies so only one package per source dependency should be needed. This makes it easy for system maintainers to ensure that local patches to Zigmod-enabled source patches are picked up by all dependants.
- Package [IDs](https://github.com/nektro/zigmod/blob/master/docs/zig.mod.md#id) are already in place and the ability to replace packages with ones farther down the tree by matching its ID has been an intentional feature since Zigmod's inception.

One further change that will be necessary to make this all work is launching a v3 of the `zigmod.lock` format that matches source URLs to their package IDs. Presently the deduplication of packages is done as mentioned above but the ID found at a URL is not known until it is downloaded. To ensure that Zigmod is able to know what to look for when the network is disabled, the package ID must be cached locally, namely in the lock file.

## When?

This upgrade will be coming to a Zigmod-near-you in a release after from the one the imminent one that brings the initial update to Zig 0.11, and will also be compatible with Zig 0.11.

## Further Questions

Currently the only open question is how to handle Zigmod packages that link C code using the `c_source_files` family of attributes. Should the spec change to allow choosing between vendored C code or a call to `linkSystemLibrary()` in `build.zig`? Or should it be left alone since the declarative nature of `zigmod.yml` allows it to be trivially patchable to instead use `- src: system_lib foo`?

## Feedback

Thanks for reading! If you have any thoughts or questions about this change before it lands, feel free to let me know at any of the contact methods listed on [the homepage](https://mlog.nektro.net/).
