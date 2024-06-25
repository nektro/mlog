---
title: "git-commit2pr"
date: 2024-06-20T14:37:41-07:00
---

As an avid contriubtor to open source, both in my own repositories and others', I interact with Git a lot and need to submit changes to those projects. If one such project happens to be on GitHub, then those changes need to go in a standalone branch before submission.

Following up from my previous articles, I'm finally at a command I've been very excited to share about. It took a few tries to nail this down but ever since I did, it's been indispensable.

Going to show the whole thing and then explain how we got here:

```sh
git-commit2pr() {
    current=$(git branch --show-current)
    newone=$(git-newbranchname)
    patchfile=$(git format-patch HEAD~1)
    git reset --merge HEAD~1
    git checkout -q origin/main
    git checkout -b ${newone}
    git am --reject ${patchfile}
    git checkout ${current}
    echo "Made new branch ${newone}"
    echo "New current HEAD:"
    git --no-pager log --oneline HEAD...HEAD~1
}
```

When working in open source or a company project, it will be easier for reviewers to merge your code the smaller and more atomic your changes are. However, given the nature of these changes being small it is common when working on them to do multiple in one sitting.

As they are likely to be independent, submitting these in a stacked PR is not not ideal. Instead with this command, you make all your commits to `master` as if it a stack; then `git-commit2pr` will pop it off the stack and put the changes into its own branch, waiting for you to push it.

Those familiar with more obscure Git command, might find the similarities between this and `git cherry-pick`, however here it is essentially moving the commit rather than duplicating it as well as creating the new branch for you.

When using this it is best to `git stash` any uncommitted changes before running since it will change your `HEAD` multiple times. As a result of using `git format-patch` a copy of the changes will end up in the current working directory so that no progress is lost even if one of the later Git commands fails.

----

Going line by line:

```
    current=$(git branch --show-current)
```

Save the current branch name in a variable.

```
    newone=$(git-newbranchname)
```

Save the name of a new pseudo-random branch name in a variable. This does not create it yet.

```
    patchfile=$(git format-patch HEAD~1)
```

Serialize the current current commit referenced by `HEAD` as a `.patch` file and store the path it into a variable.

```
    git reset --merge HEAD~1
```

Pop the commit we just serialized off the branch we're currently on.

```
    git checkout -q origin/main
```

Switch to merge base to get ready to apply our changes.

```
    git checkout -b ${newone}
```

Create the branch we saved the name of earlier.

```
    git am --reject ${patchfile}
```

Reference the serialized commit we saved earlier and apply it to the new branch we created. There are some non-blocking errors that might be thrown based on the state of the current working directory; ignore them if we can.

```
    git checkout ${current}
    echo "Made new branch ${newone}"
```

Switch back to the branch we started on and log to the user the shiny new branch we just made.

```
    echo "New current HEAD:"
    git --no-pager log --oneline HEAD...HEAD~1
```

Pretty print the new status of `HEAD`.

---

Happy hacking!
