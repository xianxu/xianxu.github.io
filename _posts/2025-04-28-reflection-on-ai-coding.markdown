---
layout: post
title:  "Reflecting on AI Coding"
date:   2025-04-28
tags: tech philosophy 
comments: true
---

I have a bit downtime between jobs, so I picked up AI coding tools and worked on a real project. The whole journey was a bit fortuitous, but it ended up an extremely interesting and revealing experience. Here's my recount of it. Am I a Prompt Engineer now? Am I an AI engineer now? ¯\_(ツ)_/¯

## About Me

First, some background of myself, to give you some context to evaluate about this blog.

I consider myself pretty technical. While I haven't really written code for 5 years after moving into management, I was still thinking about architectural designs. I'm still the same language polymath, still like to learn new programming languages (latest being [Julia](https://julialang.org/)). I still maintain my good old [neovim/terminal setup](https://xianxu.github.io/2025/01/04/dot-files.html). It's just my fancy that in time I will pick it up again. Recently due to job change, I have some free time, so I started picking it up again, mostly for fun.

I've been fascinated by LLMs, just like about everyone else. In the last two years, I gradually updated my very outdated ML knowledge, completed bunch of online courses mostly on Coursera and books e.g. [LLM from scratch](https://github.com/rasbt/LLMs-from-scratch). My last gig at Meta forced me to go into GPU programming related topics as well. 

I'm an avid user of ChatGPT, also tried many other chatbots, but found ChatGPT's fits my conversational style best. I use it to learn new things, and bounce off full spectrum of ideas, in random domains (tech, law, gardening etc.).

## LLM the Statistical Machine

I have gradually settled my view on LLMs. They are a new class of statistical computers, with new human-machine interfaces. Now the task for me, is to figure out how to best leverage it. Don't fight its imprecise nature; work with it. Earlier, I viewed LLMs as an encyclopedia, with very natural interfaces (just talk to it!). Now, with the coding assistants on the loose, I also view it as a huge pattern matching machine, that gives you good signal, if something sounds about right. That ability of sounding about right, paired with some grounding mechanism (such as run a test, or compile the code), doesn't feel that different from how human code. After all, no one can claim they can write 1000 lines of code, without trying to see if compiler agrees or not. So why would we insist LLM can just get things right in one go? There needs to be a process to ground LLMs in reality. And in coding, it's compiling and running tests. 

## The Project

### How it Started

Given I'm a very active user of ChatGPT, the stock app is showing limitations. Particularly in researching some topic, talking with ChatGPT through its app, while informing and entertaining, is not well organized. It's very hard to take notes so you can revisit later. In particular, I like the idea that **a chat transcript should be something durable, and something you can continue to curate and refresh**. At some point last week, an epiphany hit me: NeoVIM provides a great way of writing code to manipulate text, and provides great navigation among big piece of text. That sounds like a great test bed for this `live transcript` thing I want. A quick Google search showed [gp.nvim](https://github.com/Robitx/gp.nvim) is the current best, so I figure I can work to extend it. Well, just I have no idea how to program in `lua` besides coded a fishing bot 20 years ago in `World of Warcraft`). And I've no idea of NeoVIM's programming model, its plugin architecture, its APIs etc. 

My first dabble was adding some various configurations to make [gp.nvim](https://github.com/Robitx/gp.nvim) more palpable to my use case, change system prompt to ask the assistant to `reason` and create `memory` (well, fancy words, but also apt words), different syntax highlighting, better key bindings. I tinkered around, until another epiphany. Let me try [Claude Code](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/overview). I've heard about fanciful things about it from people I trust. Now let me get it real and see if `Claude Code` can help me learn a new program language, in a new code base, and creating features I need. The code base is small, ~5K LOC, in hindsight, a good starting point.

### What is the Project, Exactly?

Let's just say it's a work-in-progress. I envisioned a `live transcript` between user and assistant, a transcript user can arbitrarily update just like a text file, while easily pull additional opinions in from assistant. I started with the vision of a tree of text, not unlike [Google Wave](https://en.wikipedia.org/wiki/Google_Wave) back in the days. It's basically have similar functionality of ChatGPT or Claude Mac app, but exposes full transcript to be freely updatable. It also offers a peek at the inner workings of the world of prompt engineering, memory management, prefix cache management etc., as we build on top of a stateless API.

### What I Accomplished in Five days

Welcome to [Parley.nvim](https://github.com/xianxu/parley.nvim). It's a hard fork from `gp.nvim` to focus on live chat transcript experience, not providing assistant to some coding session in NeoVIM. It's made mostly by `Claude Code` and a bit of me guiding component design, fixing issues, testing and help debugging. And most important, I'm the **Uber PM** to dictate how features should work. Together, we made ~ 10K LOC in those 5 days (a week), so averaging 2K LOC a day. Compare to maybe 10K LOC a half on average at some Big Tech. Right, this setup is about `25x` faster. Well, beats your `10x` engineer!

I used `Parley`, over Anthropic's `Claude 3.7 Sonnet`, to review some legal document 100 pages long, 200+K words, in a transcript with tens of questions around the 17 articles of the document, sprinkled questions about legal terms I don't understand. Exactly how I wanted it to be!

## The Learning

### The Good

`Claude Code` is not your typical auto-complete. It is able to plan out write a whole new feature, across a couple of files all on its own, based merely on plain English description of the problem. I was positively wow-ed when it implemented the first feature correctly on the first try. 

### The Bad

`Claude Code` often would make localized fixes. For example, when it tries to fix some nil object problem, it adds nil checks to make the problem go away. That's at a very entry level programmer's skillset. I had to often ask it to figure out root cause of why that object is nil, in order to fix the real issue. I often need to stop it and ask it to focus on certain area of the code, or give it some example what I want to happen, or tell it observations that I think is relevant. There were even cases, where I interrupted it, thinking, dam, I can write that in 1 minute, just those 3 lines in that two places. Well, I'll admit I often over-estimated my fluency in the language and environment! I usually found myself boggled down of "mundane details". Right, Mundane details are exactly what Claude is great for! `Claude Code` often makes very complicated fixes, or designs. Such as keep looping through lines in the buffer over and over for each feature, where some planning can use a single loop while keeping track of running state. 

With this experience, I formed some hypothesis that it's easier for LLMs to write features, than fixing bugs. I theorized that for one, there are plenty of training examples for features, just use all public GitHub repos. Bug fixes seem a lot more subtle, as you need to trace through a call chain, which often are not localized in one portion of a file. Plus, there seems would have much less training data for debugging things, as those tend to be locked in developers mind. No one's going to document debugging steps, right?

On the other hand, this project is haphazardly conceived and coded. I can envision a more well prepared code base for `Claude Code` to be a lot more effective.

### Is That Just Pattern Recognition?

I think that's likely the case. It almost can be viewed as natural progression of IDEs (I know, I belittled IDE at the beginning of this post). The `show properties of an object` and select, then auto-complete a function based on description, then writing features is essentially auto-completion across bunch of files, at the proper location. 

There's nothing back to have a very capable pattern matcher at your disposal, you know.

### Ending Thoughts

1. AI coding is here, like it or not. Organizations need to adapt. 
2. It's _just_ big fancy pattern recognition. Properly used, it can make your workflow much faster.
3. I can also see many improper usages. If you are not careful, you will end up with an inconsistent bloated code base that doesn't work in many edge cases, that no one understands. 
4. Maybe what the human can do is to ground LLMs to reality.
    1. Setting up right and fast testing.
    2. Invest more in better architecture, to guide LLMs to make changes accordingly.
    3. Invest in consistent coding practices, to make LLMs' pattern matcher work even better.

PS: excited to head back to the startup world, where real things happen! 
