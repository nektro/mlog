---
title: "A journey in contributing to LLVM for the first time"
date: 2023-08-02T13:33:34-07:00
---

One of the biggest factors in how intimidating something is is how little you know about it. At the time of starting this project I consider myself a bit of GitHub expert and wanted to try contributing to projects that I used all the time but whose development processes were totally unknown to me. As it happens this actually started as an article about contributing to Linux and I was inspired to do so after seeing [Andreas Kling](https://github.com/awesomekling)'s [FIXME Roulette](https://www.youtube.com/playlist?list=PLMOpZvQB55bdRLT1IY-QD_U4DVp8NDeHo) series on his YouTube channel where he deep-dives into a random TODO or FIXME in the [SerenityOS](https://github.com/SerenityOS/serenity) codebase, and that article is still in the works. However, the opportunity to contribute to LLVM offered itself up sooner so undeterred and multitasking, here we are. And with that, let's roll back to find out how we got here.

Jul 12 2022

As I've mentioned at various points, I spend a copious amount of time digging and triaging through Zig's issue tracker and on one fateful day I came across https://github.com/ziglang/zig/issues/1424. Knowing Andrew's dislike for C++ and seeing the opportunity to dip my toes into LLVM development I later filed https://github.com/llvm/llvm-project/issues/56496 to see what the folks over there thought would be the best path forward.

Nov 27

- Got a comment asking if changing the signature was the right move, which I initially thought would be yes since LLVM changes its major version quite every 3-6 months and that this change would simply not be backported

Dec 7

- Got a comment from a member saying the right path forward was to add new functions (eg `LLVMArrayType2` in this case) so that even though LLVM releases new major versions, maintaining symbol versions allows downstream languages and runtimes to have a little bit of wiggle room when it comes to forwards compatibility with regards to the deprecation period and be compatible with multiple versions of LLVM at the same time. This also largely benefits Linux distributions that package LLVM as it allows them to not block the LLVM update on every consumer package in their repository.

Night of Jan 9 2023

- Now we have made it back to the present of the intro. With an implementation path set out by the issue discussion, I took it upon me to make the small change myelf. This was much easier said than done.
- Wrote the first diff, step 1 complete.
- Now to figure out how to submit it.
- First I checked for https://github.com/llvm/llvm-project/blob/main/CONTRIBUTING.md and found it, nice.
- which led to https://llvm.org/docs/Contributing.html
- which led to https://llvm.org/docs/DeveloperPolicy.html
- which led to https://llvm.org/docs/Phabricator.html
- which led to https://reviews.llvm.org/
- made an account, check.
- create the patch: https://reviews.llvm.org/differential/diff/create/
- patch secured: https://reviews.llvm.org/D143700
- oops I just realized there is a typo in the diff
- okay phew, I resubmitted it
- diff got all messed up and now hundreds of lines I didnt change are showing up
- something is telling me it was line endings 🙃
- okay i think thats what it was because regenerating the patch with `git format-patch
` and leaving it only edited by git fixed the issue

Jan 11

- CI build failed, failed `git clang-format`. lets figure out how to run it
- jumping back to https://llvm.org/docs/Contributing.html has the link to the script
- `nix-shell -p python3 clang-tools_14`
- `clang/tools/clang-format/git-clang-format HEAD~1`
- `git diff HEAD~1 -U999999 > mypatch.patch`

Jan 12

- the new diff passed the build :)

Jan 14

- my diff was approved :D

Jan 15

- in the early hours https://github.com/llvm/llvm-project/commit/35276f16e5a2cae0dfb49c0fbf874d4d2f177acc landed

Jul 25

- `llvmorg-18-init` is tagged and my commit becomes a part of the `release/17.x` branch

Jul 28

- `llvmorg-17.0.0-rc1` and my commit is usable by the world 🎉

----

Overall, aside from a small hiccup related to formatting the patch properly, once I figured out the process (and discovery is always the hardest part) I had a surprisingly smooth time. LLVM is a super vast project with a ton of different interests and stake holders and its easy to get lost in the sauce but interacting with [@nikic](https://github.com/nikic) in particular on both the issue triage and revision review side of things was a pleasure.

Definitely not an expert in C++ but the intimidation factor of LLVM is now gone so I would say mission accomplished and should the opportunity arise again, I can say I will be back on Phabricator.
