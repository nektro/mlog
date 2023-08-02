---
title: "Automating Living at Head With Zigmod"
date: 2023-08-01T20:48:36-07:00
---

So what is "living at HEAD" ? Living at HEAD is the idea that at all times when working on a project there only exists a single version of all of your dependencies, regardless of depth. On top of that, you work towards keeping this single version of each of your dependencies as closest to the most recent version available as possible. Now I will admit that achieving this can require quite a bit of work but if the tools you use are working with you towards this goal rather than against you, the benefits are numerous.

I forgot where I had heard about this concept originally, but in the time since I've become more than sold on the idea. When originally researching for this article I came across this particular phrasing of the method from Abseil[1]'s philosophy page where they dedicate a whole section to describing the benefits they've seen from using this methodology on over 250M lines of C++ at Google. Furthermore, GitHub uses it to keep their Ruby on Rails monolith up to date[3].

Whole classes of problems[4] that complicate both application development and package manager implementations cease to exist if you embrace this concept. Additionally rather than falling behind on updates, it promotes a Kenergy of continuously staying up to date, contributing back to upstream, and auditing upstream for bugs, getting new features early, and pushing back against bad ones.

Zigmod has brought this to Zig package management from its inception, bringing more[5] and more[6] observability into your dependency tree and the contributing to upstream guide in the tutorial[7] is a personal proud point.

Now to the title of this post, I wanted to share two commands I use locally to reduce the friction of pushing local changes of your dependencies and contributing back to upstream even easier, as evidenced by my PR history[8].

Locally I've named these `zigmod-search-changes` and `zigmod-commit-changes` respectively but you're welcome to rename and edit either as you see fit.

```bash
zigmod-search-changes() {
  here=$(pwd)
  for x in $(find .zigmod -type d | grep \\.git$)
  do
    dep=$(dirname "$x")
    cd $dep
    haschanges=$(git status | grep 'Changes not staged for commit:' | wc -l)

    if [[ $haschanges == "1" ]]
    then
      echo $dep
      git gui
    fi

    cd $here
  done
}
```

```bash
zigmod-commit-changes() {
  here=$(pwd)
  for x in $(find .zigmod -type d | grep \\.git$)
  do
    dep=$(dirname "$x")
    cd $dep
    haschanges=$(git status | grep 'Your branch is ahead of' | wc -l)

    if [[ $haschanges == "1" ]]
    then
      echo $dep
      git push origin $(git branch --show-current)
    fi

    cd $here
  done
}
```

The first of the two searches your `.zigmod` folder for Git repositories and will open your client of choice for you to inspect the changes and make any necessary commits or revert mistakes. I used to use Github Desktop[9] but later switched to `git gui`[10] for this feature of being able to view a repo in the current directory without prior configuration.

The latter command does the same search in a local `.zigmod` folder but this time searching for repoitories that have commits ahead of the default branch. It then runs `git push origin`. This is mostly because due to the nature of Zig's package ecosystem being so young I often am the author of more than 75% of any of my projects' dependencies. However, the previous command prints the path to any found directories so `cd`ing to it to make a new branch as discussed in the Zigmod tutorial mentioned earlier[7] is only a copy and paste away.

----

I wanted to share this both as an excercise of my writing since I've fallen off a bit in frequency and to get the word out about an about this little script I use every week and bring the headaches I've never haved because of this methodology to more people. And in doing so empowering more people give a helping hand to the random folks from Nebraska[11] we depend on every day as the source of our dependencies become more and more diversified.

[1]: https://abseil.io/
[2]: https://abseil.io/about/philosophy#we-recommend-that-you-choose-to-live-at-head
[3]: https://github.blog/2023-04-06-building-github-with-ruby-and-rails/
[4]: https://jlbp.dev/what-is-a-diamond-dependency-conflict
[5]: https://github.com/nektro/zigmod/blob/master/docs/commands/fetch.md
[6]: https://github.com/nektro/zigmod/blob/master/docs/commands/license_.md
[7]: https://github.com/nektro/zigmod/blob/master/docs/tutorial.md#contributing-to-dependency-upstream
[8]: https://github.com/pulls?q=is%3Apr+author%3Anektro+archived%3Afalse+is%3Aclosed+-user%3Aziglang
[9]: https://desktop.github.com/
[10]: https://git-scm.com/docs/git-gui
[11]: https://xkcd.com/2347/
