---
title: Google rather break your ads than be privacy-friendly
date: 2021-03-30
---

## A little bit on EU regulations

In 2016, the **General Data Protection Regulation** (or GDPR for short) was voted in the EU. In short, it's a set of regulations for data collection and processing, and one of the most impactful changes it brings is that collecting **personal data** requires an **explicit consent** from the user. 

The way the ad industry responded, throught the **Internet Advertising Bureau** (IAB), was to create a common framework called the **Transparency & Consent Framework** (TCF).

This framework specifies a common ground for all actors in the ad industry, through an API:

- for **Consent Management Platforms** (CMPs, the folks providing the cookie banners) to provide
- for every other actor to consume

When a user arrives on the page and sets their cookie preferences, the API gives you two informations:

- Does the GDPR apply here?
- Here's what the user has or hasn't consented to

## April 1st in the EU

There's a **major issue** with the current state of these cookie banners: **they are full of UX dark patterns**:

- There's a big **Accept all** button, but in order to refuse you need to uncheck a dozen checkboxes
- You're most of the time giving a consent for a list of **1500+ companies** you never ever heard of (because there's no way to tell which ones will be involved in an ad loaded later)

That's why on April 1st, the French regulator responsible for the GPDR application starts enforcing the notion of **explicit consent**, and explained that these dark patterns could no longer stand.

What's going to happen is that most Consent Management Platforms are going to implement a **Refuse All** button. Some publishers already took action and added it, which lowers lowers the consent rate from a staggering ~100% to ~70% (surprising! when the "refuse" option doesn't take 10x more time than the "accept" one, you're giving the choice back to users!).

Which brings us to …

## The surprising case of Google

A typical ad campaign generally has **tracking pixels** (to verify how many users have seen your ads) and **redirect links** (to count how many users clicked on your ad).

Google has a great toolbox for advertisers and is widely used for these bits. That's the `doubleclick` pixels you'll generally see in your network requests.

With the GDPR, these pixels and redirect links now take two parameters: 

- `gdpr`: does the GDPR apply?
- `gdpr_consent`: the list of consents the user gave

These parameters give to the tracker the information about what they can or cannot do. Can they drop a cookie? Can they save personal data?

Most actors in that field don't need any of that to work, but with Google tracking, the story is different. If the GDPR applies and the user refused to give any consent, Google stops operating.

That means that even if your ad doesn't require any personal data and is displayed to a user who refused personal data collection, Google will:

- **not count your ad views**
- **redirect people who clicked on your ad to an `about:blank` page**

Given Google tools popularity on the market, what they're doing is making unaddressable ~30% (likely to be more in the future) of the EU traffic whenever their tools are used: **there's no point showing an ad to someone who's going to end up on a broken link if they decide to engage with it**. 

Given most actors in the ad tracking/trust industry work without cookies or personal data, it's safe to assume that a company with Google's wealth has the means to make it work that way. Instead, it seems like **Google rather break your ads than be privacy-friendly**.