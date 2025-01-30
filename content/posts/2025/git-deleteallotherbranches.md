---
title: "git-deleteallotherbranches"
date: 2025-01-30T02:43:40-08:00
---

As an avid contriubtor to open source, I accrue a lot of branches in my local Git repos.
However once the PR has been merged upstream I wanted an easy way to clean up.
This new command (usually ran from `master`/`main`) will enumerate over all other branches and delete them.

```sh
git-deleteallotherbranches() {
  git branch | grep -v $(git branch --show-current) | xargs -L1 git branch -D
}
```

Happy coding!
