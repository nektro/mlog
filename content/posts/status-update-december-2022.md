---
title: "Status update, December 2022"
date: 2022-12-20T16:44:17-07:00
---

> *Originally published on https://nektro.mataroa.blog/*

Hello all!

So far when writing these I'd wait till the 14th/15th/16th and then use github endpoints to walk-back all the history I'd made that month. eg ones for [issues](https://github.com/issues?q=is%3Aissue+author%3Anektro+archived%3Afalse+created%3A%3E2022-11-25), [pull requests](https://github.com/pulls?q=is%3Apr+author%3Anektro+archived%3Afalse+created%3A%3E2022-11-25), and [commits](https://github.com/search?q=author%3Anektro+sort%3Acommitter-date&type=Commits). However, I feel like this misses out on a lot of research and other 'soft' work as many call it. So I think going into the new year I'm going to take notes as I go along, much more similar to a journal and then edit it in the final days. With that said, let's get into it.

[zigtools/zls/issues/792](https://github.com/zigtools/zls/issues) was found and promptly fixed by LeeCannon, thanks!

[nektro/ziglint/issues/19](https://github.com/nektro/ziglint/issues/19) was filed by me "new rule: having else block where then block ends with return" to promote a style that I believe was popularized by Go but is really a great pattern. Link has an example.

[ziglang/zig/issues/13874](https://github.com/ziglang/zig/issues/13874) "const pointer to empty nul-terminated array doesn't cast to slice" is half issue/half proposal for an inconsistency I discovered while working on a PR I'll mention in a bit. Would love comments/votes.

In the spirit of [SerenityOS](https://github.com/SerenityOS/serenity)'s [FIXME Roulette](https://www.youtube.com/playlist?list=PLMOpZvQB55bdRLT1IY-QD_U4DVp8NDeHo) I also submitted a number of long-standing TODO PRs for Zig and others.

[ziglang/zig/pull/13866](https://github.com/ziglang/zig/pull/13866) std: make builtin.Type.{Int,Float}.bits a u16 instead of comptime_int

[ziglang/zig/pull/13901](https://github.com/ziglang/zig/pull/13901) std: add object format extension for dxcontainer

[ziglang/zig/pull/13904](https://github.com/ziglang/zig/pull/13904) re-enable beahvior tests for f80 and c_longdouble

[ziglang/sublime-zig-language/pull/69](https://github.com/ziglang/sublime-zig-language/pull/69) add f80 and c_longdouble as float types

[ziglang/zig/pull/13982](https://github.com/ziglang/zig/pull/13982) stage2: disable some parts of `@Type`, add `@Int`, `@Float`

The driver of much of that work was pushing forward my own projects and to get them on stage2 and beyond.

[nektro/zig-extras](https://github.com/nektro/zig-extras/commit/24fb8bc90898efa2f7c8fa094f9dab80d38ec55e) got the `trimSuffix` function

In [git.sr.ht/~nektro/wifilylinux](https://git.sr.ht/~nektro/wifilylinux) developments:
- a dependency loop in compiling awk was fixed by using dickey/mawk
- made the repo license AGPL
- added support for custom 'bin' dirs and using certain vars in env var definitions
- this got perl 5.36 successfully compiling
- which led to kitware/cmake now building successfully as well
- in a rabbit hole to get [sapling](https://sapling-scm.com/) building, the tree gained lib/gflags 2.2.2
- a full list of the current in progress packages can be found at [gist.github.com/nektro/ecf5d842229f67588b2bb47412a5546a](https://gist.github.com/nektro/ecf5d842229f67588b2bb47412a5546a)

I added [nektro/apple_pie](https://github.com/nektro/apple_pie) as a [fork](https://github.com/Luukdegram/apple_pie) to use `std.http.Method` and retain the old method of passing request handler arguments

That work was quickly supplanted however as I added [github.com/nektro/mango_pie](https://github.com/nektro/mango_pie) as a [fork](https://github.com/vrischmann/zig-io_uring-http-server) to have a Zig http server that uses io_uring instead of the language async/await since I know my web toolkit is Linux specific

[git.sr.ht/~nektro/magnolia-desktop](https://git.sr.ht/~nektro/magnolia-desktop) didn't see too much development but lots of research notes were saved and some small tests on new alignment variations were added.

One of those research notes was [kermitproject.org/utf8.html](https://kermitproject.org/utf8.html) which serves as a nice collection of sample strings in various languages and scripts.

Last but not least in secret web server project land I laid some ground work to create a project template for the monorepo which I then quickly realized wasn't going to be usable for the first one because while every other app is going to do account management through OAuth2, the first one has to be the identity provider itself and thus has an entirely different users table and initial endpoint layout. But with that out of the way its coming together as well.

That's all for now,

See you next time!
