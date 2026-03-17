---
contents:
  - id: 35
    label: Fragment 1
    language: markdown
createdAt: 1770137876783
description: null
folderId: 11
id: 23
isDeleted: 0
isFavorites: 0
name: Labels are a last resort
tags: []
updatedAt: 1770137980746
---

## Fragment: Fragment 1
```markdown
---
title: "Labels are a last resort"
source: "https://www.refactoringui.com/previews/labels-are-a-last-resort"
---

# Labels are a last resort

Adapted from our book and video series, [Refactoring UI]()

Put down the accessibility pitchfork — this isn't about forms.

When presenting data to the user (especially data from the database), it's easy to fall into the trap of displaying it using a naive _label: value_ format.

The problem with this approach is that it makes it difficult to present the data with any sort of hierarchy; every piece of data is given equal emphasis.

## You might not need a label at all

In a lot of situations, you can tell what a piece of data is just by looking at the format.

For example, _janedoe@example.com_ is an email address, _(555) 765-4321_ is a phone number and _$19.99_ is a price.

When the format isn't enough, the context often is. When you see the phrase _"Customer Support"_ listed below someone's name in an employee directory, you don't need a label to make the connection that that is the department the person works in.

When you're able to present data without labels, it's much easier to emphasize important or identifying information, making the interface easier to use while at the same time making it feel more "designed".

## Combine labels and values

Even when a piece of data isn't completely clear without a label, you can often avoid adding a label by adding clarifying text to the value.

For example, if you need to display inventory in an e-commerce interface, instead of "In stock: 12", try something like "12 left in stock".

If you're building a real estate app, something like "Bedrooms: 3" could simply become "3 bedrooms".

When you're able to combine labels and values into a single unit, it's much easier to give each piece of data meaningful styling without sacrificing on clarity.

## Labels are secondary

Sometimes you really _do_ need a label; for example when you're displaying multiple pieces of similar data and they need to be easily scannable, like on a dashboard.

In these situations, add the label, but treat it as supporting content. The data itself is what matters, the label is just there for clarity.

De-emphasize the label by making it smaller, reducing the contrast, using a lighter font weight, or some combination of all three.

## When to emphasize a label

If you're designing an interface where you know the user will be _looking for_ the label, it might make sense to the emphasize the label instead of the data.

This is often the case on information-dense pages, like the technical specifications of a product.

If a user is trying to find out what modem is in a laptop, they're probably scanning the page for the words "Modem", "WiFi" or "Wireless", not "Qualcomm" or "Intel".

Don't de-emphasize the data _too_ much in these scenarios; it's still important information. Simply using a darker color for the label and a slightly lighter color for the value is often enough.

```
