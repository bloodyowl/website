---
date: 2019-07-17
title: Requests with ReasonML
---

Hello

```reasonml
module Request = {
  type t('a) =
    | NotAsked
    | Loading
    | Done('a);
};
```
