---
title: "Magnolia ImageViewer"
date: 2023-10-24T00:01:45-07:00
---

Hey y'all, in our [last installment](https://mlog.nektro.net/posts/2023/magnolia-calculator/) I showed off the first "real application" coming out of Magnolia Desktop and today I wanted to show some screenshots for a new app aptly named ImageViewer.

Just like many other operating systems I feel that a user should not have to open a web browser in order to view the pictures on their computer. To this end we now have the ImageViewer program. There is still much work to do but as of today it contains fully custom working implementations for BMP, QOI, TGA, PNG, and JPG.

![image](https://user-images.githubusercontent.com/5464072/277570389-a40e7304-086f-40f0-bfcc-ae7aabe82df9.png)

![image](https://user-images.githubusercontent.com/5464072/277570594-ea7cef1e-31f6-45e6-a9c1-dd6b806e0788.png)

![image](https://user-images.githubusercontent.com/5464072/277571213-8273d1b2-8fab-4694-9136-a52d964cd5c8.png)

![image](https://user-images.githubusercontent.com/5464072/277571576-9bd1ced1-3d3d-4083-b8bc-108c12c8d291.png)

Additionally, a fix was made so that the `magnolia-ImageViewer` application and others can be run from outside the `magnolia-desktop` source tree.

Not every image will work just yet but I'm excited with the progress so far and preliminary tests on my Pinebook show that the apps continue to load near instantly. Richer support for the existing formats and more format support are on their way.

Images and other mutlimedia, along with robust text handling, are a cornerstone of modern applications and having this foundation of good image loading will be very useful as the suite of Magnolia apps is fleshed out. Every supported format is usable from the same `mag.e.Image` element and future improvements will be transferrable to all apps using it.

As always, thank you for reading and if you would like to support this work financially I am on [GitHub Sponsors](https://github.com/sponsors/nektro).

Catch you in the next one 👋
