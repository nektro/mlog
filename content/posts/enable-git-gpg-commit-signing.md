---
title: "Enable GPG Commit Signing in Git"
date: 2021-03-21T10:21:06-07:00
---

This post assumes you've already read [Generating a PGP key](./generating-a-pgp-key.md).

I'll be using my key for these examples but you'll want to replace `95535225B55B5A9F39E29F5EDAB85EABB6014D3F` with your own in the commands.

```sh
git config --global user.signingkey 95535225B55B5A9F39E29F5EDAB85EABB6014D3F
git config --global commit.gpgsign true
```

This will automatically sign all of your commits with the key you added to `user.signingkey`.
