---
title: "Generating a PGP Key"
date: 2021-03-21T10:18:07-07:00
---

For this we'll be using GnuPG, aka GPG, which is a common implementation of the PGP spec.

```sh
$ gpg --full-generate-key
```

As this will be your master key, make sure to pick `RSA and RSA`, `4096 bits`, and `does not expire` for the generation options.

Once it is complete, it will print the details of it. Here's what I got as an example.

```
pub   rsa4096 2021-03-21 [SC]
      95535225B55B5A9F39E29F5EDAB85EABB6014D3F
uid                      Meghan Denny <hello@nektro.net>
sub   rsa4096 2021-03-21 [E]
```

The `955352...` part is the identifier for your new key and will be used in future commands.
