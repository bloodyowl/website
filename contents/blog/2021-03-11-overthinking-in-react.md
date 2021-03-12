---
title: Overthinking in React
date: 2021-03-11
---

Now and then, I stumble opon online pieces about how to make React applications the right way™, whether on an optimization angle or a scalability one.

Some will tell you that in order to be performant, you'll need to make `useMemo` and `useCallback` your best friends, and use it in every component. Some will tell you that you need to put your data in some kind of external store like [Redux](https://redux.js.org) or [mobx](https://mobx.js.org/README.html). Some will argue about the best way to organize your [styled components](https://styled-components.com). Some will tell you how the [Context API](https://reactjs.org/docs/context.html) is the solution to all your pains.

The thing is, when you look at it, that **most of these advices are whether aesthetical choices or premature optimizations**. Managing an external store can be a pain for data invalidation and effect management, `useMemo` and `useCallback` can sometimes hurt more than they fix anything in terms of performance.

You end up managing a worse codebase, for a little to none benefit, you just cycled through the **hype-fatigue** process.

As in most industries, we have a certain kind of underlying social contract of trust with influence. Some famous tech person says something, therefore it's a _best practices_, everyone needs to update their codebase.

Some call that the [Dan Abramov effect](https://twitter.com/ThePracticalDev/status/718462272335704064) (even though [Dan](https://twitter.com/dan_abramov) actually mostly writes about how not to fall for the hype). Back in the days, whenever Dan tweeted some repository, people took it for an endorsement, and jumped right in.

This is the case for a **lot** of influential people in tech, in different areas. We tend to fall for the status, for the hype, while undermining our actual needs.

If you don't want to fall in that hype-fatigue cycle, keep in mind to:

1. **start naively**
2. assess other things **if there's an issue**

Your code doesn't need to be hype, but what it does might.
