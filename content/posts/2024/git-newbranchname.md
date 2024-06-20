---
title: "git-newbranchname"
date: 2024-06-19T18:03:21-07:00
---

As an avid contriubtor to open source, both in my open repositories and others', I interact with Git a lot and need to submit changes to those projects. If one such
project happens to be on GitHub, then those changes need to go in a standalone branch before submission.

For single file changes the GitHub on-site editor is often sufficient however the branch name will be something like `patch-1`, `patch-2`, etc and incrementing up as you
make more. However this naming scheme can be confusing because should you end up needing to checkout the changes locally it will create a branch with that name and then
once the branch is merged upstream it will be deleted from origin but not your local checkout. This then leads to a confusing situation where you make another patch and
the branch name given by GitHub is yet again `patch-1`.

As a result I started generating my own branch names like so:

```sh
git-newbranchname-old() {
  echo "nektro-patch-${RANDOM}"
}
```

This worked great for a while, however I did end rewriting this since I ran into some situations where the `$RANDOM` bash variable was providing me with very low entropy
and I was still getting branch name collisions. I unforunately did not document why this was happening, but I did come up with a new version that will not ever have that
issue, and this is the one I still use today:

```sh
actualrandom() {
  cat /dev/urandom | head -c $1 | xxd -ps | awk '{printf "0x" $0}' | xargs -0 printf "%d\n"
}
git-newbranchname() {
  rand=$(actualrandom 2)
  echo "nektro-patch-${rand}"
}
```
