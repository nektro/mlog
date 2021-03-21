---
title: "Add Your PGP Key to Github for Verified Commits"
date: 2021-03-21T10:27:09-07:00
---

This post assumes you've already read [Generating a PGP key](./generating-a-pgp-key.md).

I'll be using my key for these examples but you'll want to replace `95535225B55B5A9F39E29F5EDAB85EABB6014D3F` with your own in the commands.

For adding it to github run the following and copy the whole output.

```sh
gpg --armor --export 95535225B55B5A9F39E29F5EDAB85EABB6014D3F
```

That will generate a very long wall of text encapsulated by
```
-----BEGIN PGP PUBLIC KEY BLOCK-----


-----END PGP PUBLIC KEY BLOCK-----
```

Then navigate to https://github.com/settings/keys and paste the entire body of the output into the "New GPG Key" text box.
