---
title: "Using a `<table>` with grid layout"
date: 2025-04-19T13:44:18-07:00
---

There have been quite a few number of times where the default layout algorithm of the `<table>` element has surprised me.
Most particularly how there isn't much control on the width of columns. There seems to be some CSS workarounds for this
but in 2025 we have `display: grid`. Is there any way we can use that with tables?

As it turns out, there sure is! Thanks to `subgrid` we can keep the HTML markup of our table but have fine-grained control over
layout with this below class and a single `grid-template-columns` definition.

```css
.table-as-grid {
    display: grid;

    & :is(thead, tbody) {
        display: grid;
        grid-template-columns: subgrid;
        grid-column: 1 / -1;

        & tr {
            display: grid;
            grid-template-columns: subgrid;
            grid-column: 1 / -1;

            & :is(th, td) {
                display: block;

                &[colspan] {
                    grid-column: span attr(colspan);
                }
                /* ^ is not supported in chrome < 133 */
                /* ^ is not supported in firefox yet (upvote https://bugzilla.mozilla.org/show_bug.cgi?id=435426) */
                /* ^ is not supported in safari yet (upvote https://bugs.webkit.org/show_bug.cgi?id=26609) */
                &[colspan="2"] {
                    grid-column: span 2;
                }
            }
        }
    }
}
```
