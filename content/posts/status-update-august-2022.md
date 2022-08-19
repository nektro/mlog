---
title: "Status update, August 2022"
date: 2022-08-18T21:23:43-07:00
---

Hello all! I had quite a few life happenings this month and ran into some unexpected complications with projects so I'm not quite where I thought I was going to be with progress this update, but there's still a good amount to talk about so I'll get into it. I marked my 6 and 2 month anniversaries with my partners, I started a new job at [Humu](https://www.humu.com/) on the 8/8 after being laid off from my previous company back in mid April, and I did some logistical organizing to make developing at my apartment vs my partners' apartment more smooth.

In Zig, I did a little bit of stage2 and standard library work; namely
- [#12179](https://github.com/ziglang/zig/pull/12179) implementing `noinline fn` on 7/24
- [#12278](https://github.com/ziglang/zig/pull/12278) fixing inconsistency of `std.Target` using `systemz` for `s390x` on 7/28
- [#11867](https://github.com/ziglang/zig/pull/11867) ensuring builtin packages are always available to package dependencies on 6/14 which was finally merged this month also on 7/28.

In the process of updating my projects to use the self hosted compiler I also reported a number of issues (some of which are even already closed at the time of writing!)
- [#12242](https://github.com/ziglang/zig/issues/12242) ran into a `TODO implement coerce tuples to tuples` on 7/31
- [#12403](https://github.com/ziglang/zig/issues/12403) ran into a declaration `@typeInfo` miscompilation when using `usingnamespace` on 8/10
- [#12459](https://github.com/ziglang/zig/issues/12459) ran into an internal panic when calling `@typeInfo` on a union with `noreturn` fields on 8/16

On 8/1 I updated https://github.com/nektro/zig-flag to support Windows in [`22ce2c3`](https://github.com/nektro/zig-flag/commit/22ce2c3f5e560c72728fde9df47ba29566b17e40).

Shortly after I updated https://github.com/nektro/ziglint to work with Zig's latest master at the time.

In my continued work on implementing a custom CI in Aquila, https://github.com/nektro/docker-qemu-system reached a workable level of maturity and will recieve few updates going forward.

On 8/10 https://github.com/nektro/zig-extras got an update in [`a5384d1`](https://github.com/nektro/zig-extras/commit/a5384d1d002b3d4f3ccdcb67d7ce35797bb79335) to expose the ~~clever~~cursed `range(n)` function so that https://github.com/nektro/zig-range no longer has to be added as an explicit dependency in order to use it.

On 8/10 I also pushed a local update I'd made to https://github.com/nektro/zig-ulid which exposes a `.bytes()` method in [`7f2c7ed`](https://github.com/nektro/zig-ulid/commit/7f2c7edf0e7f91229be17bda52d0e74d42d862e2). This function is nice because it takes advantage of two things: the length of a ULID as a string is constant, and Zig arrays are value types (as opposed to a pointer). Previously the way to convert a ULID to a string (`[]const u8`) was to call `.toString()` with an Allocator so that returning the result would not cause a use-after-free of a local. However, this new function with the return type of `[26]u8` can be returned directly with no need for an Allocator (and thus be a lot faster).  A large number of calls in Aquila code were converted from `ulid.toString(allocator)`+`defer` to only be `&ulid.bytes()`.

8/10 was a busy day because I also updated https://github.com/nektro/zigmod to use Zig's latest master, however a new release was not tagged because the Windows CI failed with the following message. If anyone has insight into what the cause of the issue might be, do please reach out.

```
$ ./build_release.sh x86_64-windows-gnu
r81.6a2d664 x86_64-windows-gnu
error(link): DLL import library for -lKERNEL32 not found
error: DllImportLibraryNotFound
error: zigmod-x86_64-windows...
error: The step exited with error code 1
```

Pieces of work on Aquila were made all throughout the month. Much work has been put into making the process of generating runner images and queuing them in the system to be as seamless and automated as possible. While Aquila is a Linux-only application, the goal is to be able to run/test as many operating systems as possible. I really hoped to have the release soon but a complication came up in the way I was storing the archive of ready VM images on disk and teach Aquila on how to parse the folder to distinguish between tagged releases of Zig and master builds. Be on the lookout for the release soon. The initial CI code/runner will likely be up in the coming days and then a follow up will be made that includes all the new web endpoints to view the results from jobs.

To the end of OS support, https://github.com/nektro/mount.ufs was started on 8/11. It's totally WIP so far but the plan is to implement UFS filesystem mountinig in userspace using FUSE. By implementing mounting the various filesystems in userspace, embedding ssh config files into the VM images can be done entirely headlessly and succeed regardless of the flags an Aquila admin's kernel was compiled with support for. Not requiring user intervention for this step will also enable more reproducible builds and be less error prone. UFS is commonly used in FreeBSD (among others) and will be the first non-Linux OS added to the Aquila [support matrix](https://github.com/nektro/aquila/blob/master/docs/ci/compatibility.md).

Last but not least, Magnolia-Desktop continued work and compiles exclusively on stage2! Making it past the comptime miscompilations of stage1 I got SVG parsing of [Adwaita icons](https://gitlab.gnome.org/GNOME/adwaita-icon-theme) working, as well as loading them from the standard `XDG_DATA_DIRS` locations. Drawing them on screen is still an ongoing WIP since I discovered the OpenGL primitive I was using to draw arbitrary shapes does not quite like being told to draw concave shapes, so that is being refactored. However that doesn't stop me from showcasing some wireframes ;)

![image](https://user-images.githubusercontent.com/5464072/185541775-0e102f93-ae18-4227-bb8a-b0309fddf888.png)

That's all for now, see you next month :)
