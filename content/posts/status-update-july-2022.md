---
title: "Status update, July 2022"
date: 2022-07-19T15:54:30-07:00
---

Hello! It's been a very warm July in Portland and I can't wait for it to continue. Last month I started on an article announcing a new project, [Magnolia Desktop](../magnolia-desktop). If it grows beyond being a personal project I see it as a challenge to the GTK stronghold to bring new life to both developer and user experience. I ended that article saying that next up on my list of things to work on was icons and more, and in the midst of working on the icon demo I ran into a number of seemingly unavoidable miscompilations. The project and my energy to work on it is still alive and well but I did not make that much progress on it this past month due to those bugs.

In its absence (and after I figured out how to enable hardware virtualization on my computer), I resumed work on [Aquila](https://github.com/nektro/aquila), the index I made for Zig packages based on the package manager I made [Zigmod](https://github.com/nektro/zigmod). [Aquila.red](https://aquila.red/) is not a complete picture of Zig's package ecosystem by any means (there's still a good chunk of folks only using [git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules), vendoring, not using packages, etc) but the site is a nice glimpse. I will be updating it to be compatible with the official package manager once it is released, but at present using Zigmod is a requirement to register packages. The bulk of my work this month was marching towards the long awaited CI feature.

How the [QEMU](https://www.qemu.org/) base images are generated was totally reworked and automated. The repo now has scripts to install Debian from `.iso`, enable SSH, git clone LLVM and Zig, and compile both from source, almost entirely headlessly. There's more work that's not pushed yet to create jobs when the update webhook is recieved from the source provider, as well as pull in jobs from the queue and start the Docker containers to launch the VMs in a distributed fashion.

The launch of this feature, which will automatically verify a successful run of a package's tests before publication, is starting with only Debian. However, QEMU was chosen over a pure-docker method as extensive cross-platform support is planned. I wanted the CI to be able to test on as many platforms as Zig supports as possible and going with a VM solution became a requirement. Check [the docs](https://github.com/nektro/aquila/blob/master/docs/ci/compatibility.md) for the full compatibility table.

To [nektro/zig-extras](https://github.com/nektro/zig-extras/commit/d1b32fbed72c5f00aee812447664948c3eec7006) I added `pub fn ensureFieldSubset(L: type, R: type) void`. This method will ensure that every field name in `L` is also present in `R`. This was added because I needed a way to ensure two enums I had were similar such that `L <= R` but could be used with other container types as well.

To [Homebrew/homebrew-core](https://github.com/Homebrew/homebrew-core/pull/104496) I updated Zig to use LLVM 13 when homebrew had updated but Zig hadn't yet as a file upstream in Zig was filed. This was rather quickly unneeded in hind-sight as Zig completed its LLVM 14 upgrade and [#105630](https://github.com/Homebrew/homebrew-core/pull/105630) was filed.

I also completed by first successful system upgrade on Linux going from `21.05` to `22.05`. Thanks to the functional and transactional nature of Nix this upgrade went through without a hitch and my system 

Be on the lookout for another article coming soon titled "A half-hour to learn Zig" inspired by [Amos' (fasterthanlime)](https://twitter.com/fasterthanlime) article by [the same name](https://fasterthanli.me/articles/a-half-hour-to-learn-rust). The public beta release of [Bun](https://github.com/oven-sh/bun) brought in a bunch of new faces to the Zig community and lack of content explaining the basics of systems programming was highlighted. This article will be an attempt to go over some of those topics as well as how Zig the language thinks about them. https://gobyexample.com/ is another fantastic style of a resource I'd love to recreate for the Zig ecosystem.

Until next time!
