---
title: "Magnolia Desktop"
date: 2022-06-18T18:11:32-07:00
---

Hello again! I want to start doing "Status update" style articles and more writing in general so I thought I'd announce on here the main project I've been working on recently amongst all my other open source work.

Magnolia is a new UI toolkit written entirely from scratch in Zig for Linux desktops. It has a focus on ease-of-use, performance, and supporting older devices. The only runtime system dependencies are X11 and OpenGL. The only additional build dependencies are Git, Zig, and Zigmod.

[Zig](https://github.com/ziglang/zig) is a new general-purpose programming language and toolchain for maintaining robust, optimal, and reusable software.

[Zigmod](https://github.com/nektro/zigmod) is a package manager for Zig I created when I first joined the community in early Nov 2020 and have been maintaining ever since.

The original inspriation for this project came from a variety of places. I've been doing a lot of work with Zig and it seemed perfect for the goals I had in mind. Fast compilation speeds, small binaries, simple and cohesive features, powerful compile-time metaprogramming, and a culture dedicated to making software that works well for the user. My specialty in programming for some time has been full stack web development but I have had an itch to make desktop-native apps for a while. At the same time I knew I did not want to make anything with [Electron](https://www.electronjs.org/). I have a [Pinebook Pro](https://www.pine64.org/pinebook-pro/) that I want to start using a lot more and it only has 4 GB of RAM. Simply running Firefox and VSCode is enough to use nearly all of its system resources. I find this unacceptable and I think a lot of other people would to, provided they were given the right tools.

The post that really got me to sit down and start working was [Flatpak Is Not the Future](https://ludocode.com/blog/flatpak-is-not-the-future) by Nicholas Fraser. Here he recounts an experience trying to download and run [KCalc](https://apps.kde.org/kcalc/), a simple calculator app from KDE, through various means. KCalc itself is only 4.4 MB in size, yet the default download methods listed ask the user to allot 900 MB of network and disk space. All this data slows down your apps and your computer for bad reasons. Apps should be getting smaller and faster, not the other way around. Magnolia is one girl's attempt at trying to turn that cuve around.

Note: this project is a WIP and still in a very experimental state. The purpose of this article is less about asking for users or contributors just yet, but more "just starting" the word of the project on this blog so that I have something to continue off of when posting updates, as opposed to recounting its entire history thus far which I'm about to do while its still incredibly new. I have been working on this for about a month or two now, and while I have made some good progress there's still *a lot* more to do which I'll post about here later.

[The first commit](https://github.com/nektro/magnolia-desktop/commit/26d768d65bc7b861a63e55da1a52a773b8a795f8) was made on 25 Apr 2022.

[`triangle-raw`](https://github.com/nektro/magnolia-desktop/blob/master/apps/triangle-raw.zig) was created to show off the classic 2D triangle hello world with direct OpenGL and X11 calls.

  ![image](https://user-images.githubusercontent.com/5464072/174461922-c5bef6af-6476-4db3-8178-7065b407ba31.png)

[`triangle`](https://github.com/nektro/magnolia-desktop/blob/master/apps/triangle.zig) made shortly after to show the same but now made with Magnolia primitives.

  ![image](https://user-images.githubusercontent.com/5464072/174461904-2c761381-66ee-464b-bdd2-3941687263d5.png)

[`demo-centersquare`](https://github.com/nektro/magnolia-desktop/blob/master/apps/demo-centersquare.zig) handle window resize events and keep a red square in the middle of the screen

  ![image](https://user-images.githubusercontent.com/5464072/174461953-211e1e8e-dac0-4843-b2e5-34843b623a08.png)

[`demo-focusblur`](https://github.com/nektro/magnolia-desktop/blob/master/apps/demo-focusblur.zig) handle focus/blur window events and make the screen green/red accordingly

  ![image](https://user-images.githubusercontent.com/5464072/174461967-1951158d-b561-4fb0-b706-670061928b11.png)
  ![image](https://user-images.githubusercontent.com/5464072/174461975-dd32a976-b45b-40f1-b05e-44018e71dd59.png)

[`demo-layout`](https://github.com/nektro/magnolia-desktop/blob/master/apps/demo-layout.zig) a showcase of the `StrictGrid` component

  ![image](https://user-images.githubusercontent.com/5464072/174461997-060c9428-a487-47ef-ab7b-2a71b84a101b.png)

[`demo-layout2`](https://github.com/nektro/magnolia-desktop/blob/master/apps/demo-layout2.zig) a showcase of the `DynGrid` component with a more typical app shell look

  ![image](https://user-images.githubusercontent.com/5464072/174462016-5b8e8514-0d61-4f1f-a4b5-411276a4e764.png)

[`demo-margin`](https://github.com/nektro/magnolia-desktop/blob/master/apps/demo-margin.zig) simple demo showing off the beginnings of the style system

  ![image](https://user-images.githubusercontent.com/5464072/174462040-1ea58145-31c0-4f1b-83c4-ee756722a288.png)

[`demo-text`](https://github.com/nektro/magnolia-desktop/blob/master/apps/demo-text.zig) a showcase of the `TextLine` component with from-scratch [BDF](https://en.wikipedia.org/wiki/Glyph_Bitmap_Distribution_Format) font parsing/rasterization

  ![image](https://user-images.githubusercontent.com/5464072/174462044-14923f41-0d7e-45d2-b7d5-a061a285d525.png)

[`demo-centersquare2`](https://github.com/nektro/magnolia-desktop/blob/master/apps/demo-centersquare2.zig) a reimplementation of `demo-centersquare` but now implemented with Magnolia intrinsics and the `*align` style attributes

  ![image](https://user-images.githubusercontent.com/5464072/174462062-4253704d-4e1f-4bd7-afb0-15be40b288f6.png)

[`demo-text2`](https://github.com/nektro/magnolia-desktop/blob/master/apps/demo-text2.zig) a showcase of the `TextFlow` component with Lorem Ipsum. (definitely some room for improvement here, text is super hard and will definitely get standalone followup articles)

  ![image](https://user-images.githubusercontent.com/5464072/174462071-638acaa5-3880-4179-91e8-d2df80a5d8e8.png)

Part of my hope with this project is to bring back the idea that desktop-native apps on Linux can be fast, easy to use, accessible to develop, and maintain a small footprint.

```
[nix-shell:~/dev/magnolia-desktop]$ zig build --prominent-compile-errors -Dall -Drelease-safe -Dstrip

[nix-shell:~/dev/magnolia-desktop]$ ls -lh zig-out/bin/
total 1.1M
-rwxr-xr-x 1 meg users  26K Jun 18 17:28 magnolia-demo-centersquare
-rwxr-xr-x 1 meg users  60K Jun 18 17:29 magnolia-demo-centersquare2
-rwxr-xr-x 1 meg users  26K Jun 18 17:28 magnolia-demo-focusblur
-rwxr-xr-x 1 meg users  61K Jun 18 17:29 magnolia-demo-layout
-rwxr-xr-x 1 meg users  59K Jun 18 17:29 magnolia-demo-layout2
-rwxr-xr-x 1 meg users  60K Jun 18 17:29 magnolia-demo-margin
-rwxr-xr-x 1 meg users 141K Jun 18 17:29 magnolia-demo-text
-rwxr-xr-x 1 meg users 139K Jun 18 17:29 magnolia-demo-text2
-rwxr-xr-x 1 meg users  26K Jun 18 17:28 magnolia-triangle
-rwxr-xr-x 1 meg users  19K Jun 18 17:28 magnolia-triangle-raw
```

This ease of building from source is another key requirement for this project that Zig provides for us, because prior to Magnolia apps becoming properly available on the different package repositories for the various distributions, building from source will likely be the only way for many users to get to experience these apps. Pre-packaging distribution-agnostic graphical applications on Linux is a not very solved problem. Some solutions are hacky, and some lead to the bloat mentioned in the post above about Flatpack. A good primer on this topic (which was actually unknown to me for quite some time) is [this video](https://youtu.be/pq1XqP4-qOo?t=95) by Andrew Kelley, the creator of Zig.

There's much on the horizon. Immediately so, there's icons, more text work, more styling demos, and the beginnings of a calculator, filebrowser, and system resource monitor.

Well that's all I have for today, stay tuned!

If you'd like to follow along check back here or read more of my source on Github https://github.com/nektro/magnolia-desktop or Sourcehut https://git.sr.ht/~nektro/magnolia-desktop.

I also have a [Twitter thread](https://twitter.com/nektro/status/1520549224907124736) and am on [Github Sponsors](https://github.com/sponsors/nektro) if you'd like to support my work.

Thanks for reading! :D
