---
title: "Hello Mataroa"
date: 2022-11-25T16:43:54-07:00
---

> *Originally published on https://nektro.mataroa.blog/*

This is a very nice site and pretty in line with what Ive been looking for lately. [mlog.nektro.net](https://mlog.nektro.net/) will likely still have its uses but Hugo/git based blog feels like a lot of friction that I feel stops me from writing sometimes.

I fell behind on my monthly status updates and I've sure been busy. I went to [SYCL](https://sycl.it/) and met tons of cool folks in Milan and had my birthday this month as well. I also recently had cheesecake for the first time ever (it was great :).

Code wise a TLDR of whats up is I continue to post many bugs to the kind Zig folks, and help triage ones from others where I can. See [here](https://github.com/issues?page=2&q=is%3Aissue+author%3Anektro+archived%3Afalse+created%3A%3E2022-08-18) for the full list.

[github.com/nektro/magnolia-desktop](https://github.com/nektro/magnolia-desktop) I partially started over (don't worry I saved all the old code) in order to rewrite the renderer based on learnings from [Nakst](https://gitlab.com/nakst)'s UI tutorial [here](https://nakst.gitlab.io/tutorial/ui-part-1.html) which was an excellent resource. At the same time I also added testing infrastructure that allows me to catch regressions when I update in the rendering in the future, whether that be for new features or performance.

> [Nakst](https://nakst.gitlab.io/) is an incredibly talented individual I first came into contact through the [Handmade Network](https://handmade.network/). It's a great collection of folks and you should definitely check it out if you like user-first systems programming.

[github.com/nektro/zigmod](https://github.com/nektro/zigmod) now builds using the Zig self-hosted compiler and a release was made with this improvement! Peak RAM usage while compiling dropped from 1.7GB to .6GB. The remaining usage is almost certainly coming from LLVM and the inclusion of C code in the compilation.

A semi-secret project of mine made some headway which I'll explain more about as I make tangible progress. It will likely remain closed source for some time but I plan on being open about as possible with regards to everything else including the roadmap and the business around it later on. It will be a collection of self-hostable web services written in Zig with an option for paid managed hosting by me. The first projects in the lineup will be an [OAuth2](https://oauth.net/2/)-first identity server, [IRCv3](https://ircv3.net/) chat server, and [Git](https://git-scm.com/) server with bug/issue integration so be on the lookout for those. There's options for all three of those out there but none that quite fit my feature and performance desires so making them I shall be doing. The CI features developed for Aquila/Limitless will also likely make their way reborn in this org.

[git.sr.ht/~nektro/wifilylinux](https://git.sr.ht/~nektro/wifilylinux) is making slow but steady progress this month and also recently got rebooted. Previously it was a documentation of me following along with [Linux from Scratch](https://www.linuxfromscratch.org/) but I ran into issues being on [NixOS](https://nixos.org/). So I restarted the project to make what I really wanted all along which is a system package manager. The ideas brought forward by Nix and continued by [Guix](https://guix.gnu.org/) are incredible but there are downfalls to their maintainability imo. Here I take a similar approach in trying to make reproducible functional package manager with a focus on bootstrappability but with a manifest format much more similar to [Brew](https://brew.sh/). I have a lot of local patches I haven't pushed yet and will post more about it as time goes on.

[github.com/nektro/zig-tls](https://github.com/nektro/zig-tls) got off to a great start but ran into a roadblock because RSA is not in Zig's standard library.

[github.com/nektro/s3cmd](https://github.com/nektro/s3cmd) was started and more subcommand support is coming soon.

That’s all for now, see you next month!

edit: wrote this whole thing and realized while I was proofreading that I missed both September and October (oops 😓)
