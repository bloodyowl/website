---
title: Principles for maintainable codebases
date: 2025-04-23
---

## Write dumb code

Write code that's easy to understand, don't try to be a smartass that writes clever one-liners or using hidden heuristics only the author knows about (detailed in this [previous article](/blog/2021-01-09-write-dumb-code/)).

## Keep an explicit data flow

Don't use magic tools to inject dependencies or values, just pass your dependencies to your functions.

In most codebases, the only things you want to inject turn out to be a very minimal set of data (a database ref, a few vendor SDKs to mock), it's completely fine instantiating your dependencies yourself and passing them down explicitly where they're used.

## Low overhead

Use the language concepts and features rather than re-creating them: [modules](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Modules), [functions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Functions), [types](https://www.typescriptlang.org). Keep your dependencies to the minimum.

If your framework has its own module system, drop it immediately.

## No over abstraction

Don't create abstractions before a need emerges. There's no one-rule-fits-all on this.

We like anticipating situations that won't happen in the foreseable future and end up paying the price of maintaining increasingly complex systems that probably won't ever serve a purpose.

## Cohesive responsibilities

Keep responsibilities cohesive rather than spreading them in different parts of the codebase. The app structure should roughly reflect its public API.

Applying outdated _wisdom_ from 2000s programming books, we tend to mixup technical nature and concern, and end up with codebases that require a huge mental overhead because a simple feature relies on code that's scattered across dozens of files that are split by type rather than grouped by purpose.

Your concern should be to have a consistent feature.

## Explorable codebase

The codebase should be understandable without external context and have explicit links between modules. It should be easy to find the desired module starting from the entry point.

This is essential for debugging. If you're using a framework that auto-instanciates and binds some part of the system automatically, you'll have a really bad time onboarding people and getting them to debug the system.

## Quick feedback loop

Running the app locally or running your test should be easy and fast so that you have a quick feedback loop in your development environment.

People work in different ways, some are more efficient by using TDD, some by running good old calls to iterate. Your system should allow for both. You want to provide a good DX for your team rather than coercing them into using something they might not be confortable with.

Another area where a quick feedback loop is important is the time it takes for your CI to deploy your app. Always improve on this, ship as often as you can.

## Test boundaries, not internals

Don't waste your energy in writing thousand of unit tests. Write most tests in an end-to-end style, testing the IO of the boudaries of your application (API, incoming messages).

Unit testing the internals is very valuable when dealing with really complex isolated bits, and they should be used there.

Nonetheless, in most web applications, most of the value you can extract is by testing against the public API on a fully isolated app instance for each test (no manual setup, writing tests is fast, tests will be more stable over time, give you some form of dogfooding on how the API is consumed).

## Stop the microservices madness

Always start with a monolith, only split if you have an extremely good reason for it (independant release cycles between teams is not one of them).

We rarely anticipate the burden of complexity that microservices get. What's trivial with a single application (like popping a preview deployment for a development branch) becomes a problem you need dedicated teams for.

## Use the compiler

When the language you're using provides you with a decent type system, embed as many properties as you can directly in your modeling. Making something illegal in a program is less of an effort than testing it manually.

## Ask why

This is likely the most important principle: always ask why. Always question.

If you don't understand the value of some widely adopted "best practice", dig into it.

Most times, people apply these practices because it was written in a book, so _it must be true_. If you're wondering why something was implemented in a curious way, get to understand the properties that the implementation wanted to guarantee, and start thinking from there.

Each situation is unique, your team composition, the product you're building, the technology evolutions that happened since then.

Reassess all the time.
