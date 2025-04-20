---
title: "HTML USWDS Accordion"
date: 2025-04-20T13:13:59-07:00
---

Lately I've been building some side projects using USWDS, or [US Web Design System](https://designsystem.digital.gov/) and it has been going great.
They have a pretty good selection of components and mix together very well.

Most recently I wanted to use the [Accordion](https://designsystem.digital.gov/components/accordion/) component but was faced to see it was using `<div>` elements
and required using the provided JS bundle in order to perform its collapse and expand functionality. As a developer in the future I had a feeling we could build
it natively with `<details>` so that's exactly what I set out to do.

As for why the USWDS team didn't go with this approach it was likely due to stricter browser requirements they were under or the age of this component. However as of
Chrome 120, Firefox 130, and Safari 17.2, even we can get that classic accordion look where only one is open at a time by adding a matching `[name]` attribute similar
to the way you group `input[type=radio]` buttons. See [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/details) for all the *details* 🥁.

Here I use the `m-` prefix on the classes to not interfere with the builtin USWDS classes but otherwise this is a near-drop-in replacement. Color comments refer
to the names specified by the [system color tokens](https://designsystem.digital.gov/design-tokens/color/system-tokens/) used throughout USWDS.

```css
details.m-usa-accordion {
    margin: 0.5rem 0;

    & summary {
        display: block;
        background-color: #f0f0f0; /* gray-5 */
        background-image: url("/-/npm/@uswds/uswds@3.12.0/dist/img/usa-icons/add.svg"), linear-gradient(transparent, transparent);
        background-repeat: no-repeat;
        background-position: right 1.25rem center;
        background-size: 1.5rem;
        cursor: pointer;
        font-weight: 700;
        margin: 0;
        padding: 1rem 3.5rem 1rem 1.25rem;
        text-decoration: none;

        &:hover {
            background-color: #e6e6e6; /* gray-10 */
        }
        &:focus {
            outline: .25rem solid #2491ff; /* blue-40v */
            outline-offset: 0;
        }
        &:focus-visible {
            outline: 1px dotted;
        }
    }

    &[open] {
        & summary {
            background-image: url("/-/npm/@uswds/uswds@3.12.0/dist/img/usa-icons/remove.svg"), linear-gradient(transparent, transparent);
        }
    }

    & > div.m-usa-accordion__content {
        background-color: white;
        color: #1b1b1b; /* gray-90 */
        padding: 1rem 1.25rem calc(1rem - 0.25rem) 1.25rem;
    }
}
```

You can also bring back the traditional `<details>` triangle if prefer to not use the `+` and `-` icons to show the open/close status like so:

```diff
@@ -2,12 +2,7 @@
     margin: 0.5rem 0;

     & summary {
-        display: block;
         background-color: #f0f0f0; /* gray-5 */
-        background-image: url("/-/npm/@uswds/uswds@3.12.0/dist/img/usa-icons/add.svg"), linear-gradient(transparent, transparent);
-        background-repeat: no-repeat;
-        background-position: right 1.25rem center;
-        background-size: 1.5rem;
         cursor: pointer;
         font-weight: 700;
         margin: 0;
@@ -26,12 +21,6 @@
         }
     }

-    &[open] {
-        & summary {
-            background-image: url("/-/npm/@uswds/uswds@3.12.0/dist/img/usa-icons/remove.svg"), linear-gradient(transparent, transparent);
-        }
-    }
-
     & > div.m-usa-accordion__content {
         background-color: white;
         color: #1b1b1b; /* gray-90 */
```
