---
title: "Scriptable Zig"
date: 2026-10-12T12:05:28-07:00
---

There is a preamble you can add to any Zig file to make it runnable as a script.

```c
#if 0
p=$(mktemp -t tmp.XXXXXXXXXX.zig)
cc -x c -E -P $0 > $p
zig run $p
exit $?
#endif

const std = @import("std");

pub fn main() !void {
    std.log.info("hello world!", .{});
}
```

Then after a quick `chmod +x ./script.zig` it works even without a `sh` prefix:

```
$ ./script.zig
info: hello world!
```

Now this a long ways from perhaps [only needing a shebang](https://github.com/ziglang/zig/issues/2703) but it is indeed functional today 🎉.

The meat here could *almost* be a one-liner in `zig run <(cc -x c -E -P $0)` but that resulted in Zig erroring with `error: unrecognized file extension of parameter '/dev/fd/63'` since `zig run` works with both Zig and C and C++ and Asm.

You can try adding `-x zig` but then you get `error: language not recognized: 'zig'` since `-x` mainly forwards to the embedded C compiler. (maybe that's an enhancement worth adding 😉)

Ah trying this with C it seems not being a one-liner also gets around `error: failed to check cache: '/dev/fd/63' file_hash Unseekable` which is indeed tricky.

This post was inspired by https://www.reddit.com/r/C_Programming/comments/1x2k1y0/compiling_c_is_so_fast_that_i_use_it_as_a/pf37mie/.

Using `$0` and `mktemp` allows this method to be recursive such that Zig scripts can call each other and not clobber sources when printing stack traces after something goes wrong.

`exit $?` forwards the `zig run` result to the parent environment.

----

Actually, you can take advantage of not needing a shebang and that Zig's comment syntax matches the path delimiter. This works too:

```zig
//usr/bin/env zig run $0 -- $@; exit

const std = @import("std");

pub fn main() !void {
    std.log.info("hello world!", .{});
    std.os.linux.exit(1);
}
```

Happy coding!
