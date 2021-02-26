---
title: Write dumb code
date: 2021-01-09
---

Most of us, in the early years of our carreers focus on making code **that we can be proud of**. Clean code. Elegant code. Smart code. 

I used to spend hours trying to make my code do smart stuff, avoiding repetition at all cost with factorisation, writing abstractions all over the place, making sure that I wrote the shortest snippet possible for a given task.

I don't give a f**k about that anymore. At all.

I came to a small mantra:

<div style="font-size: 32px; text-align: center;">
  <strong>Make smart plans.</strong><br>
  <strong>Write dumb code.</strong>
</div>

## why → how → what

I really like Simon Sinek's [«Start with why»](https://www.youtube.com/watch?v=u4ZoJKF_VuA) TED talk (you've probably already seen it), and while it speaks about companies, I think that the general idea is applicable to a lot of fields.

To paraphrase a little: **start from the vision, then figure out how to make it happen, then do it**.

<img src="/public/assets/images/GoldenCircle.webp" onload="this.style.opacity=1" alt="Why, how and what" width="1258" height="708" loading="lazy" />

Of course Sinek talks about a general principle, but in our case it also works in the small.

### why

Knowing the **why** is what makes us understand from the start what **value** we're expected to bring. The **why** is our guideline, what we aim for. When knowing the **why**, even if we get stuck on the technical part, it gives us the opportunity to find alternative ways to provide a similar value. 

### how

Once we know **why** we'll do something, we can focus on the **how**. **How** are we going to make that happen? **How** will it work? **How** will our feature, our project, our fix, fit in the project? **How** does solution one compares to solution two?

### what

When you've planned **how**, the **what** is the least interesting part. It is a translation job. We write in one language what we've expressed in another.

Doing things in that order is beneficial in many ways to the organisation and the people in it:

- people get to know the value that they'll bring from the start
- with the goal in mind, they'll be able to have better ideas
- it eliminates "bad" ideas early in the process

## Our job isn't about code

What I consider to be a good developer isn't someone who'll be able to write the most efficient single-line snippet, but someone who is good at getting from **why** to **how**, and simply happens to make the **what**.

To get there, I think that at some point we all need to stop caring about beautiful code. In that sense, normalisation tools like [Prettier](https://prettier.io) were in my opinion one of the biggest leaps that we've made in the recent years, because they enabled us not to focus our energy on **what** by-products.

Our job is about turning a **vision** into a **reality**.

Code isn't an end in itself. That's why I strongly believe in **dumb code**.

## What's "dumb code"?

What I call **dumb code** is code that's:

- **easy to read**: so that your teammates (or future you) can get it simply
- **explicit**: it doesn't matter if your variable or function name is super-long. Don't put in a comment what you can put in a name. 
- **honest**: do **not** hide business complexity to fake simplicity. The only thing you'll accomplish is making people go to more places to grasp the ideas. 
- **deletable**: so that you don't get to the situation where nobody dares touching a piece of the program, not knowing if it'll break something

To take a trivial example: in our front-end React codebase at BeOp, we do what's called **props-drilling**, which means that we pass down all the data from the root components down through props. I used to find that ugly. Today, some folks would still fight against that, arguing that it doesn't **look clean**, that we'd better **use a separate data store**. 

Sure. It's dumb.

It's the dumbest way to pass data from a component to its descendants. **That's also the simplest**. Anyone who's worked on a React codebase knows how to pass a prop to a component. Anyone who reads a component source knows **exactly** what data it needs in seconds. If we used a data store, that person would probably need to go back and forth between 3 or 4 files just to figure out what happens.

When you write **smart code**, the most likely person you'll outsmart is your future self, when coming back to that _very clever_ piece of code that you don't remember and that you'll spend a few hours figuring out. 

If a piece of code that you don't find perfect brings immediate value to your product, why wouldn't you add it?

<img src="/public/assets/images/EffortValue.webp" onload="this.style.opacity=1" alt="Effort on value" width="1252" height="698" loading="lazy" />

**Dumb code mecanically reduces the** immediate and later **effort**, making the value that you're able to bring more accessible.

If we were code writing machines, we wouldn't bring much to the table. 

We're good when we take a step back and get the big picture. 

<div style="font-size: 32px; text-align: center;">
  <strong>Make smart plans.</strong><br>
  <strong>Write dumb code.</strong>
</div>
