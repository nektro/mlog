---
title: "Status update, January 2023"
date: 2023-01-15T16:44:38-07:00
---

> *Originally published on https://nektro.mataroa.blog/*

Well hello friends!

So I took my advice from last update and kept essentially a journal too keep track of all my life and code happenings from day to day. And wow when I tell you what this has done for my sense of productivity. I will be fair that for my own sake I didn't document every time I sat down to watch TikTok or check up on Twitter or HackerNews but having a casual record of the time I spent debugging things, making little progress here and there, going down a YouTube rabbit hole, or spending time away from the keyboard really put into perspective what monthly updates had essentially summed up to "lost time". The final format of these articles will continue to shift over time but I'm glad to have found a flow that not only makes these easier to write but leaves me feeling better about myself after the fact.

----

### Dec 20

Following up from last month's article we start on the 20th of Dec. Oops I was late which shouldn't happen anymore pending extenuating circumstances since now I can spend the 15th writing rather than research writing. The night of the article I worked on codename "Waffle" and made bits of progress on the custom OAuth2 identity server. Progress on this was slow because I started to realize how much policy is baked into things like this and I started wondering about network issues it might have in the future. But today was only about working on the sign up form which led me to decide usernames would have the same rule as sites like Twitter/Twitch where you can have upper- and lowercase letters in the name but only so long as there's no case-insensitive match against others in the database. Names will also be limited to nine characters so as to fit in IRC and to not explode, there'd have to be a limit on some number and I can always increase it later.

On this day I also went to the gym for the first time in a long time and biked for 2.4 miles. Was really hoping I'd keep it up but sadly I did not. Will ask future me if writing this out motivates me to go back.

### Dec 21

Realized waffle/identity is gonna need a way to validate emails too and I don't want to use regular expressions. I know there has to be a way. I found a really nice pair of python libraries: [JoshData/python-email-validator](https://github.com/JoshData/python-email-validator) and [kjd/idna](https://github.com/kjd/idna) that do both validation and normalization and have lots of tests, nice. Will be porting a good portion of these to Zig.

This led me to want to update [github.com/nektro/zig-unicode-ucd](https://github.com/nektro/zig-unicode-ucd) so that it could be a backbone for a lot of the data that library is going to need. The Unicode consortium produces a large collection of machine readable data files that document many of the characters, scripts, and rules that Unicode offers. This project runs a Zig script and produces Zig code that is then provided direct access to through a Zigmod package. As motivated as I was to make a dent in the remaining files it was not before a Youtube break according to my notes. I'm gonna leave my notable Youtube list at the bottom of this article though to not clutter these day entries with too many links.

After that youtube break, we got right to work: updated the generators to be compatible with Zig master, and added support for `CaseFolding`, `CompositionExclusions`, `DerivedAge`, `DerivedCoreProperties`, `EastAsianWidth`, and `EmojiSources`.

### Dec 22

I was clearly on a roll because today I steamrolled through more `zig-unicode-ucd` work: added `EquivalentUnifiedIdeograph`, `HangulSyllableType`, `IndicPositionalCategory`, `IndicSyllabicCategory`, `Jamo`, `LineBreak`, `NameAliases`, `NamedSequences`, `NamedSequencesProv`, `PropList`, `Scripts`, `VerticalOrientation`, and `emoji`.

On this day I also had a doctor's appointment finally got approved to be on estrogen again 🎉.

### Dec 23

`zig-unicode-ucd` work continued: added `ScriptExtensions`.

I had my first laser hair removal appointment for my chin which itself was alright. Painful but very quick and I was super excited to finally be starting this. I've been out publicly as trans for almost 5 years now and in that time I've been shaving my face every day (sometimes even more than once) for 3-4 of them. This process takes about 5-6 sessions but should significantly reduce the frequency of hair growth in that area and last for a pretty long time.

Another thing about this day was that the night prior Portland had experienced a super bad snowstorm and so almost no one was out on the road on my way to the appointment, which was pretty cool.

### Dec 24

`zig-unicode-ucd` work continued: added `PropertyAliases`, `PropertyValueAliases`.

Watched [Dune (2021)](https://www.imdb.com/title/tt1160419/) and totally loved it.

Started working on [ziglang/zig#13982](https://github.com/ziglang/zig/pull/13982) on Dec 13, abandonded it this day after I ran into an unrecoverable merge conflict. Future me should probably revive it.

### Jan 1

I was very busy this day with non-code stuff and I had this idea around Dec 20 but its about a new year's resolution so this entry makes the most sense to talk about it. As I've gotten more experienced, I've also become a lot more comfortable contributing to more projects. I've just about mastered my github flow, and in the past I even sent a patch to GCC (which I embarrassingly messed up because I forgot to set my email client to plain text, which I have [since rectified](https://nektro.mataroa.blog/blog/send-and-compose-plain-text-emails-in-thunderbird/) and documented). In the new year of 2023 I want to try to make a contribution to a project that seems untouchable from the outside. So my goal is to make an attempt to submit a patch to Linux itself and document the whole process.

"untouchable" may be the wrong word but its a project that I know is immensely important and I'm not really sure where I'd start. I respect the people that work on it a lot and want to learn more about that world. (Just rewrote this sentence dealing with a smidge of imposter syndrome haha). So I'm going to try and find a maintenance task and write about it to try and make it seem a lot more approachable not only to myself but perhaps anyone else who might read it and think they're not cut out for it when the reality might totally be otherwise.

### Jan 2

Starting off the new year, [Magnolia Desktop](https://git.sr.ht/~nektro/magnolia-desktop#magnolia) got some love: added `demo-panelhoriz-fillw` and `demo-panelvert-fillh` and merged the `PanelHoriz` and `PanelVert` into one component. Having these pieces separate at first was a big help in understanding their similarities and differences. However now that I understand them, and thanks to the cleanliness of Zig code, it makes a lot more sense to have them as one with a field that specifies the layout algorithm.

Playing around with some other code I also managed to find and file [ziglang/zig#14164](https://github.com/ziglang/zig/issues/14164).

### Jan 3

In Magnolia: with some layout squared away, it was time to resurrect the construction of our custom opentype font parser and we started off strong finishing the `head`, `hhea`, `maxp`, and `OS/2` tables.

For dinner I went food shopping and ended up making mashed potatoes from scratch for the first time in quite a while, they came out quite yummy :) Unfortunately I forgot to take a picture.

And to wrap up the day I filed [ziglang/zig#14183](https://github.com/ziglang/zig/issues/14183)

### Jan 4

In Magnolia more `.ttf` tables were added: `hmtx`, `prep`, `cvt`.

My one of my partners who works in travel make an RSS feed of the alerts from every US Embassy. [link](https://gist.github.com/nektro/9a22309c26c2e1c0f22e221bf957701a) for the curious.

### Jan 5

Today I went to work and got layed off. I spent the rest of the day touching base with the handful of coworkers who were also affected and taking some time to absorb the news.

### Jan 6

Went through my email backlog and added a bunch of new filters. For some it might seem wild, but I love having email on a non-gmail domain and that I do my own spam filtering. I do get more than average I think because I was apart of a data breach a few years ago wrt to that I had bought a hardware crypto wallet before I had completely signed off the technology.

It felt weird to wake up jobless this day but I spent a little more time than usual to make my lunch to make up for it.

Never forget.

In Magnolia: I started working on the truetype `glyf` table.

### Jan 7

In Magnolia: I worked on `glyf` some more, but ended up running in a hard to debug miscompilation which ended up stalling my progress.

### Jan 8

In Magnolia: I found a weird workaround for the miscompilation if I made the size of a particular `std.BoundedArray` a power of two max_length.

Come the afternoon I started an attempt at updating Zig to work with the latest LLVM master in preparation for the upcoming LLVM 16 release.

### Jan 9

Finished the LLVM upgrade at the time of writing which culminated in my [`llvm16-wip`](https://github.com/nektro/zig/commits/llvm16-wip) branch. Kept `-wip` in the name since LLVM 16 hasnt been released yet.

LLVM 16 got experimental support for the Xtensa architecture added, so [huh so I could've sworn that Xtensa was used in Arduino but that seems to be mistaken. Not sure where I got that idea].

In Magnolia: `glyf` has some serious documentation holes, stared at my screen for longer than I'd like to admit lol.

Filed [zigtools/zls#901](https://github.com/zigtools/zls/issues/901)

### Jan 10

Discovered `ttfdump(1)` after some more google searching. The help this has been is incredble. So my flag and point parsing code was actually perfect, I just wasn't having it run for long enough. The MS page wording had me mixup the length of the flags array (which is the same as the number of points) with the only length field saved which is the number of contours. However the correct length was found by adding one to the final index of a different array in the table named `endPtsOfContours`. After that I also skipped over the `post` table since it has to do soley with printer support and quickly wrapped up the `name` table after discovering an "issue" in that table where some of the strings are [interned](https://en.wikipedia.org/wiki/String_interning) but that was diagnosed again thanks to `ttfdump`. After all that `ProggyClean.ttf` now parsed successfully 🎉.

This felt like a big accomplishment because it now meant I could get away from parsing for a bit (soon) and work on implementing the drawing and rasterization of the fonts. `ProggyClean.ttf` was chosen as a starter baseline since its the font that comes pre-included in [Dear ImGui](https://github.com/ocornut/imgui) which is another popular simple GUI toolkit, particularly for making menus in games though its used in all sorts of applications.

I also rewatched [AlphaGo - The Movie | Full award-winning documentary](https://www.youtube.com/watch?v=WXuK6gekU1Y)

Late at night as I'm lieing in bed I remember I actually had skipped over the `cmap` table previously and need to implement it before I can properly draw. It's actually a rather important table too. It's the one responsible for providing the maps between Unicode codepoints and glyph indexes inside the font.

### Jan 11

Today was a big maintenance catch up day. I pushed a bunch of local changes to update some of my packages to Zig master that needed it.

I updated [Zigmod](https://github.com/nektro/zigmod) to Zig master.

I updated [Ziglint](https://github.com/nektro/ziglint) to Zig master.

I also updated [kristoff-it/suzie](https://github.com/kristoff-it/suzie) to work with Zig master. This is a bot Loris makes to give folks a highlighting role in Discord when they're streaming about Zig. However I needed to update its dependencies first. So this work so far has culinated in [fengb/zasp#6](https://github.com/fengb/zasp/pull/6) and [fengb/zCord#13](https://github.com/fengb/zCord/pull/13) but the Suzie PR will be coming soon too once those are merged so be on the lookout for that.

Later that afternoon I also managed to **finally** get the back cover off of my Pinebook Pro. Two of the screws were severely stripped and so I thought it was almost dead. But on this day I decided to try finagling it a little more and I finally got it open! This was necessary as I needed to take the emmc out since I'd forgotten the manjaro password and needed access to the boot loader so I could boot SD cards again.

My love for NixOS has continued and I managed to download their aarch64 SD image and it booted and dropped me to a shell with no issues 🎉. It was in this moment however I needed another SD card so that one could have the installer and one could have my files. It was late at night so my journey took a pause.

Filed [zigtools/zls#912](https://github.com/zigtools/zls/issues/912)

### Jan 12

Issues of mine [ziglang/zig#14164](https://github.com/ziglang/zig/issues/14164) and [ziglang/zig#12403](https://github.com/ziglang/zig/issues/12403) were resolved thanks to Vexu. Thanks a ton for all you do, you're a rockstar.

On my NixOS trend from the day prior I took some time to read though some of the popular issue threads.

Shortly after that Andrew merged the Zig package manager MVP 🎉 so I spent some time reading and commenting on all the follow up issues that were made as a result.

Rewatched [Vox - Why danger symbols can’t last forever](https://www.youtube.com/watch?v=lOEqzt36JEM)

### Jan 13

Determined to get the laptop working after it being out of service for so long I went out to the store and picked up another SD card. (I actually did happen to have another one at home but it was unfortunately badly corrupted). The NixOS installer worked like a charm and sans me forgetting to enable WiFi and thus having to boot back into the installer to do so, I got it working 🎉🎉.

![](https://cdn.discordapp.com/attachments/559483572403044352/1063552291250122903/2023-01-13_12-16.png)

Excited more than ever to have a laptop again, I was quickly reminded why I started projects like Magnolia. (albeit these specific ones are likely not fixable by Magnolia). Upon getting my Firefox setup I opened up a Youtube video to try out the speakers and it began to stutter almost immediately (network was definitely not the bottle neck). Determined to figure out if it was Youtube/being in a browser, I downloaded a video and discovered that this issue was even happening in VLC. Worse yet, upon watching any video for more than a couple minutes the entire system would freeze and need a force reboot. And the 4 GB of RAM made running [`nix-index`](https://github.com/bennofs/nix-index) impossible. This was quite sad as that package also provides the invaluable `nix-locate` command.

In Magnolia: I deleted it from GitHub and the source is now only available through [https://git.sr.ht/~nektro/magnolia-desktop](https://git.sr.ht/~nektro/magnolia-desktop). GitHub was already only a mirror at the time. Additionally I continued work on the `cmap` truetype table but words weren't really making sense this afternoon.

Filed [ziglang/zig#14313](https://github.com/ziglang/zig/issues/14313)

Last but definitely not least I wrote the first installment of [This Week in Zig](https://thisweekinzig.mataroa.blog/blog/zig-weekly-update-2023-1/): a weekly round up of compiler and standard library progress I'm going to be publishing on Sundays.

### Jan 14

Today was pretty casual as my partners were home for the weekend. I posted about 'This Week in Zig' in the Discord and went out to get dim sum for lunch. Later that night Jos taught me and another friend of ours how to make and fold dumplings. Was loads of fun.

Later that night I watched some talks that came out from goto; Copenhagen 2022

- https://gotocph.com/2022/sessions/2080/introduction-to-the-zig-programming-language
- https://gotocph.com/2022/sessions/2193/avoiding-the-temptation-to-over-engineer
- https://gotocph.com/2022/sessions/2035/lessons-from-billions-of-breached-records

### Jan 15

- https://gotocph.com/2022/sessions/2188/five-lines-of-code

Today was publish day but the morning was pretty casual. Went out for lunch again to try a bbq food court and went for a small drive around Portland before it started raining. Then I took a really nice nap when we got home.

In Magnolia: tried finishing up the `cmap` table, hit another miscompilation.

And wrote this article you're reading now. Hope you've enjoyed and I'll see you next time 👋.

### YouTube round up

- [How This Bridge Was Rebuilt in 15 Days After Hurricane Ian - Practical Engineering](https://www.youtube.com/watch?v=jVi5p-yyF3c)
- [3 books if you only read scifi & fantasy, and 3 other books you should read anyway - Hello Future Me](https://www.youtube.com/watch?v=j-XqvbyUF5Y)
- [We tested the US Military’s secret space weapon - Veritasium](https://www.youtube.com/watch?v=J_n1FZaKzF8)
- [Taking A Break From YouTube - GothamChess](https://www.youtube.com/watch?v=eACSzFJpetI)
- [The Perfect Christmas Dinner - Joshua Weissman](https://www.youtube.com/watch?v=tE80FR2EUeg) -- especially loved the cucumber dish, they have something very similar at [Dough Zone](https://www.doughzonedumplinghouse.com/) and its delicious
- [I, HATE, I, ROBOT, - Just Write](https://www.youtube.com/watch?v=zYnQGWjsGXQ)
- ["From Street to Suite" (my presentation for the PornHub Sex Worker Safety Conference) - DevianOllam](https://www.youtube.com/watch?v=8I21RlpKWbc)
- [Knives Out: A Complex Film about Simple Things - StoryStreet](https://www.youtube.com/watch?v=fOX7gOlb8xM)
- [Director Rian Johnson Breaks Down a Scene from 'Knives Out' - Vanity Fair](https://www.youtube.com/watch?v=69GjaVWeGQM)
- ['Dune' Director Denis Villeneuve Breaks Down the Gom Jabbar Scene - Vanity Fair ](https://www.youtube.com/watch?v=GoAA0sYkLI0)
- [The Lessons I Learned From Kung Fu Panda - StoryStreet](https://www.youtube.com/watch?v=zkcs-fJVyO8) but stopped at the section for Kung Fu Panda 2 since I haven't seen that yet.
- [Cheap And Healthy Meals For The Week, Done In 1 Hour - Joshua Weissman](https://www.youtube.com/watch?v=AYXfaVD5o40)
- [I Coded a Video Editor (and it kind of sucks) - GamesWithGabe](https://www.youtube.com/watch?v=iydG-e1dQGA)
- [How to travel with just one bag (& zero sacrifices) - Maurice Moves](https://www.youtube.com/watch?v=fqu02-6c7Os)
- [22 Problems Solved in 2022 - Wendover Productions](https://www.youtube.com/watch?v=c3dDagZMALQ)
- [I Tried a Luxury Cruise and The Reality Surprised Me - Emma Cruises](https://www.youtube.com/watch?v=KMDuPRnkbrs)
- [The One Tiny Law That Keeps Amtrak Terrible - Wendover Productions](https://www.youtube.com/watch?v=qQTjLWIHN74)
- [Why You Are Bad At Chess - GothamChess](https://www.youtube.com/watch?v=RSFusRQhF6o)
- [Well, Someone Had to Explain the Liar's Dice Scene In Pirates of the Caribbean: Dead Man's Chest - Lord Ravenscraft](https://www.youtube.com/watch?v=T44LuxdH0iw)
- [Avatar The Last Airbender: Finding Hope in Our Scars - StoryStreet](https://www.youtube.com/watch?v=x4ABFBgIjdY)
- [Browser hacking: Fixing a stack overflow in the LibJS garbage collector - Andreas Kling](https://www.youtube.com/watch?v=WxIgzBXVb4A)
- [This Phone is $169 - What's the Catch? - Marques Brownlee](https://www.youtube.com/watch?v=1xiqOg1NRPA)
- [The Biggest Chess Drama - GothamChess](https://www.youtube.com/watch?v=hMlEfPIWdLA)
- [I Cooked Against A Michelin Star Chef - Joshua Weissman](https://www.youtube.com/watch?v=V7zVJWLXUsM)
- [Would You Fall for It? [ST08] - Not Just Bikes](https://www.youtube.com/watch?v=n94-_yE4IeU)
- [Papyrus: The World's 2nd Most Hated Font - Linus Boman](https://www.youtube.com/watch?v=3t1D3ebc6h0)
- [How this font became the face of Chinese food in America - Linus Boman](https://www.youtube.com/watch?v=YP9gEeVQZ2U)
- [Why some Asian accents swap Ls and Rs in English - Vox](https://www.youtube.com/watch?v=2yzMUs3badc)
- [How to find a planet you can’t see - Vox](https://www.youtube.com/watch?v=STsI6IbPbGQ)
- [Browser hacking: Let's not lose the selection when resizing the browser! - Andreas Kling](https://www.youtube.com/watch?v=d9SIP87IR4Q)
- [Meme Review: but it's a 👏quantified 👏typographic 👏analysis - Linus Boman](https://www.youtube.com/watch?v=cJYm-de_UHE)
- [I Trained Like A Chess Grandmaster - Michelle Khare](https://www.youtube.com/watch?v=t8IVLOM1fXI)
