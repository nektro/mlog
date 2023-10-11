---
title: "Magnolia Calculator"
date: 2023-10-10T20:58:12-07:00
---

https://mastodon.social/@nektro/110857823907433264

> I've been working on a nice catalog of demos for Magnolia Desktop, but it now has reached a point where I made real app: Calculator

![image](https://user-images.githubusercontent.com/5464072/273686126-a442e09b-c059-4517-95b8-34af7fd5fb92.png)

This has been a long time coming since my first introductory post to Magnolia Desktop [over a year ago](https://mlog.nektro.net/posts/magnolia-desktop/) both because a lot of life happened and other projects took precendence for a while. A myriad of other demos have been added in that time and if you check mastodon I posted that about a month ago. In that time I had a surgery and my original plan for this article was for it to be a double feature but JPEG is more complex than anticipated. I still wanted to call out Calculator on its own however because it was a pointed example from one of the blog posts that inspired me to start the project.

As recounted from my previous post:

> The post that really got me to sit down and start working was [Flatpak Is Not the Future](https://ludocode.com/blog/flatpak-is-not-the-future) by Nicholas Fraser. Here he recounts an experience trying to download and run [KCalc](https://apps.kde.org/kcalc/), a simple calculator app from KDE, through various means. KCalc itself is only 4.4 MB in size, yet the default download methods listed ask the user to allot 900 MB of network and disk space. All this data slows down your apps and your computer for bad reasons. Apps should be getting smaller and faster, not the other way around. Magnolia is one girl's attempt at trying to turn that cuve around.

Admitting that there is still work to be done with regards to font rendering and getting them from the system, the app today is still functional, and only depends on Zig, Zigmod, X11, and OpenGL.

```sh
[nix-shell:/dev/magnolia-desktop]$ zig build -Dall -Dmode=ReleaseSafe

[nix-shell:/dev/magnolia-desktop]$ ls -lah zig-out/bin/
-rwxr-xr-x 1 meghan users 2.9M Oct  9 13:05 magnolia-Calculator
```

Which we can even bring down much further if we strip debug symbols:

```sh
[nix-shell:/dev/magnolia-desktop]$ zig build -Dall -Dmode=ReleaseSafe -Dstrip

[nix-shell:/dev/magnolia-desktop]$ ls -lah zig-out/bin/
-rwxr-xr-x 1 meghan users 226K Oct  9 13:06 magnolia-Calculator
```

Pretty good :)

----

The Magnolia project remains committed to providing efficient yet powerful apps for the Linux GUI landscape and I have much more to come. As I gently alluded to in the beginning of this article, the next installment should be ready shortly. 👀

As always, thank you for reading and if you would like to support this work financially I am on [GitHub Sponsors](https://github.com/sponsors/nektro).

Catch you in the next one 👋
