---
title: "git-newbranch"
date: 2024-06-20T14:37:41-07:00
---

As an avid contriubtor to open source, both in my own repositories and others', I interact with Git a lot and need to submit changes to those projects. If one such project happens to be on GitHub, then those changes need to go in a standalone branch before submission.

This is a very light addition on top of yesterday's post where we defined [`git-newbranchname`](./git-newbranchname.md) but this one has just as much joined its spot in my toolbox so I wanted to give it its own moment (URL) to shine.

```sh
git-newbranch() {
  git checkout -b $(git-newbranchname)
}
```
