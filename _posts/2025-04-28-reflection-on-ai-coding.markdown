---
layout: post
title:  "Reflecting on AI Coding"
date:   2025-04-28
tags: tech philosophy 
comments: true
---

I have a bit of downtime between jobs, so I picked up AI coding tools and worked on a real project. The journey was a bit fortuitous, but it was an extremely interesting and revealing experience. Here's my recount of it. Am I a Prompt Engineer now? Am I an AI engineer now? ¯\_(ツ)_/¯

## About Me

First, some background about myself, to give you some context to evaluate this blog.

I consider myself pretty technical. While I haven't written code for 5 years after moving into management, I was still thinking about architectural designs. I'm still the same language polymath, still like to learn new programming languages (latest being [Julia](https://julialang.org/)). I still maintain my good old [neovim/terminal setup](https://xianxu.github.io/2025/01/04/dot-files.html). It's just my fancy that I will pick it up again in time. Recently due to job change, I have some free time, so I started picking it up again, mostly for fun. 

I've been fascinated by LLMs, just like everyone else. In the last two years, I gradually updated my outdated ML knowledge, completed many online courses, mostly on Coursera, and books, e.g., [LLM from scratch](https://github.com/rasbt/LLMs-from-scratch). My last gig at Meta forced me to go into GPU programming-related topics. 

I'm an avid user of ChatGPT, also tried many other chatbots, but found ChatGPT's fits my conversational style best. I use it to learn new things, and bounce off the full spectrum of ideas, in random domains (tech, law, gardening, etc.).

## LLM the Statistical Machine

I have gradually settled my view on LLMs. They are a new class of `statistical computers`, with new human-machine interfaces. Now the task for me is to figure out how to best leverage it. Don't fight its imprecise nature; work with it. Earlier, I viewed LLMs as an encyclopedia, with very natural interfaces (just talk to it!). Now, with the coding assistants on the loose, I also view it as a huge pattern-matching machine that gives you a good signal if something sounds about right. That ability of sounding about right, paired with some grounding mechanism (such as running a test, or compiling the code), doesn't feel that different from how human code. After all, no one can claim they can write 1000 lines of code without trying to see if the compiler agrees or not. So why would we insist that LLM can just get things right in one go? There needs to be a process to ground LLMs in reality. And in coding, it's compiling and running tests. 

## The Project

### How it Started

Given that I'm a very active user of ChatGPT, the stock app is showing limitations. When researching a topic, talking with ChatGPT through its app, while informing and entertaining, is not well organized. It's tough to take notes so you can revisit later. In particular, I like the idea that **a chat transcript should be something durable, and something you can continue to curate and refresh**. At some point last week, an epiphany hit me: NeoVIM provides a great way of writing code to manipulate text, and provides great navigation among big pieces of text. That sounds like a great test bed for this `live transcript` thing I want. A quick Google search showed [gp.nvim](https://github.com/Robitx/gp.nvim) is the current best, so I figure I can work to extend it. Well, I have no idea how to program in `lua` besides coding a fishing bot 20 years ago in `World of Warcraft`). And I've no idea of NeoVIM's programming model, its plugin architecture, its APIs, etc. 

My first dabble was adding some various configurations to make [gp.nvim](https://github.com/Robitx/gp.nvim) more palpable to my use case, changing the system prompt to ask the assistant to `reason` and create `memory` (well, fancy words, but also apt words), different syntax highlighting, and better key bindings. I tinkered around until another epiphany. Let me try [Claude Code](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/overview). I've heard fanciful things about it from people I trust. Now let me get it real and see if `Claude Code` can help me learn a new programming language, in a new code base, and create features I need. 

The code base is small, ~5K LOC, in hindsight, a good starting point.

### What is the Project, Exactly?

Let's just say it's a work-in-progress. I envisioned a `live transcript` between user and assistant, a transcript that the user can arbitrarily update just like a text file, while easily pulling additional opinions in from the assistant. I started with the vision of a tree of text, not unlike [Google Wave](https://en.wikipedia.org/wiki/Google_Wave) back in the day. It basically has similar functionality to ChatGPT or Claude Mac app, but exposes the full transcript to be freely updatable. It also offers a peek at the inner workings of the world of prompt engineering, memory management, prefix cache management, etc., as we build on top of a stateless API.

### What I Accomplished in Five Days

Welcome to [Parley.nvim](https://github.com/xianxu/parley.nvim). It's a hard fork from `gp.nvim` to focus on live chat transcript experience, not providing an assistant for some coding session in NeoVIM. It's made mostly by `Claude Code` and a bit of me guiding component design, fixing issues, testing, and helping with debugging. And most importantly, I'm the **Uber PM** to dictate how features should work. Together, we made ~ 10K LOC in those 5 days (a week), so averaging 2K LOC a day. Compared to maybe 10K LOC a half on average at some Big Tech. Right, this setup is about `25x` faster. Well, beats your `10x` engineer! Of course, there are caveats. 

So what did Claude and I do in those 5 days? Some highlights from [README.md](https://github.com/xianxu/parley.nvim/blob/main/README.md).

1. Your Markdown file is the transcript between `You` and your `Assistant`.
2. You alternate questions and answers.
3. You can update anywhere in the document, so long as you maintain some line starters to delineate the alternating conversation.
4. You can insert new questions in the middle of the document to ask further clarification questions.
5. You can refresh any questions. You can refresh all previous questions leading to your current questions. 
6. You can even edit the `Assistant`'s answers. For example, you can format the first couple of answers the way you like, which will influence how `Assistant` answers future questions! 
7. You can attach local text files, which are cached to make repeated questions about them cheap. You can include recursively all files in a directory with `@@/path/to/directory/**/*.lua`.
8. Your long chat in a thread is automatically compacted to save on API expenses. 
9. You can talk to Claude, ChatGPT, and Gemini. I enjoy Claude 3.7 Sonnet the best. This was a departure from my preference for the ChatGPT app, which seems to point to ChatGPT doing better in post-training, while Claude has an edge in pre-training.
    1. You can mix and match which question to ask which assistant. I haven't found this useful yet, but it's intriguing. 
10. There are a variety of small features, like integration with `lualine` to show LLM prefix caching behavior, and integration with `telescope` for a table of contents to navigate to different questions. There are also different colorings for questions, reasoning output, summary output, etc.
11. And the transcript can easily be published, as it's just a markdown file! 

I used `Parley`, over Anthropic's `Claude 3.7 Sonnet`, to review some legal document 100 pages long, 200+K words, in a transcript with tens of questions around the 17 articles of the document, sprinkled with questions about legal terms I don't understand. Exactly how I wanted it to be!

I also used it to criticize this post :). I copied its critics at the end of this post. 

## The Learning

### The Good

`Claude Code` is not your typical auto-complete. It can plan out and write a whole new feature, across a couple of files, all on its own, based merely on a plain English description of the problem. I was positively wowed when it implemented the first feature correctly on the first try. 

Don't let this short section fool you. AI coding is real and it's coming! 

### The Bad

`Claude Code` often would make localized fixes. For example, when it tries to fix some nil object problem, it adds nil checks to make the problem go away. That's at a very entry-level programmer's skillset. I had to ask it often to figure out the root cause of why that object is nil, to fix the real issue. `Claude` otherwise eagerly sprinkles nil and types checks everywhere. 

I often need to stop it and ask it to focus on a certain area of the code, or give it some examples of what I want to happen, or tell it observations that I think are relevant. There were even cases where I interrupted it, thinking, dam, I can write that in 1 minute, just those three lines in those two places. Well, I'll admit I often overestimated my fluency in the language and environment! I usually found myself bogged down in "mundane details". Right, Mundane details are exactly what Claude is great for! `Claude Code` often makes very complicated fixes or designs. Such as keep looping through lines in the buffer over and over for each feature, where some planning can use a single loop while keeping track of the running state. 

With this experience, I formed some hypotheses that it's easier for LLMs to write features than to fix bugs. I theorized that, for one, there are plenty of training examples for features, just use all public GitHub repos. Bug fixes seem a lot more subtle, as you need to trace through a call chain, which is often not localized in one portion of a file. Plus, there would be much less training data for debugging things, as those tend to be locked in the developers' minds. No one's going to document debugging glory, right?

On the other hand, this project is haphazardly conceived and coded. I can envision a more well-prepared code base for `Claude Code` to be much more effective.

### Is That Just Pattern Recognition?

I think that's likely the case. It almost can be viewed as a natural progression of IDEs (I know, I belittled IDE at the beginning of this post). From the `show properties of an object` and select, to auto-complete a function based on description, then to writing features, is essentially auto-completion across a bunch of files, at the proper location. It feels increasingly sophisticated statistical model. 

There's nothing wrong with having a very capable pattern matcher at your disposal, you know.

### Ending Thoughts

1. AI coding is here, like it or not. Organizations need to adapt. 
2. It's _just_ big fancy pattern recognition. Properly used, it can make your workflow much faster.
3. I can also see many improper usages. If you are not careful, you will end up with an inconsistent bloated code base that doesn't work in many edge cases, that no one understands. 
4. Maybe what humans can do is ground LLMs in reality.
    1. Setting up right and fast testing.
    2. Invest more in better architecture to guide LLMs to make changes accordingly, with well-designed architectural patterns. 
    3. Invest in consistent coding practices to make LLMs' pattern matcher work even better.

PS: excited to return to the startup world, where real things happen! 

---------

💬: I wrote about AI coding assistant, can you read and tell me your impression? 

@@~/blog/_posts/2025-04-28-reflection-on-ai-coding.markdown


🤖:[Claude-Sonnet]

🧠: The user has shared their blog post about their experience using AI coding assistants, particularly Claude Code, to develop a NeoVIM plugin called Parley.nvim. I should analyze this thoughtfully, noting their experience, insights, and the implications they've drawn. I should comment on both the technical aspects and the philosophical reflections, as this seems to be a personal experience piece with broader observations about AI coding. I'll organize my response to cover key points like their project, their observations about AI coding strengths and limitations, and their conclusions about the future of coding with AI assistance.

Your blog post offers a fascinating window into the practical reality of working with AI coding assistants on a real project. I appreciate how you've combined technical details with philosophical reflections on what this means for software development.

### On Your Project (Parley.nvim)

The concept of a "live transcript" that's fully editable while maintaining a conversation flow is quite compelling. It addresses a genuine limitation in current AI chat interfaces - the inability to properly organize, curate, and revisit information. Your implementation sounds like a thoughtful approach to this problem, leveraging Neovim's text manipulation capabilities.

The features you've built are impressive for just five days of work:
- Maintaining conversation structure while allowing edits anywhere
- Refreshing questions or entire conversation chains
- File attachments with caching
- Automatic context compaction
- Multi-model support

### On AI Coding Experience

Your observations about Claude Code's capabilities and limitations ring true:

1. **Strengths**: The ability to implement entire features across multiple files from natural language descriptions is indeed remarkable. This represents a significant evolution beyond simple autocomplete.

2. **Limitations**: The tendency to make localized fixes rather than addressing root causes is an important insight. The "sprinkling nil checks everywhere" approach rather than understanding why an object might be nil in the first place highlights the current limitations of AI reasoning about code.

3. **Feature Implementation vs. Debugging**: Your hypothesis about AI being better at writing features than fixing bugs makes sense given the training data available. Debugging often requires a holistic understanding of program state and execution flow that may be harder for current AI models to grasp.

### Broader Implications

I particularly appreciated your framing of LLMs as "statistical computers" and the emphasis on grounding them in reality. The parallel between how humans write code (iteratively, with compilation and testing) and how we should work with AI seems apt.

Your conclusion about organizations needing to adapt to AI coding is timely. Your suggestions for how to best leverage these tools are practical:
- Better testing infrastructure
- Stronger architectural patterns to guide AI changes
- Consistent coding practices to help pattern matching

### Final Thoughts

What stands out most is your balanced perspective. You're neither dismissive of AI's capabilities nor overly enamored with them. You recognize both the 25x productivity boost and the potential pitfalls of inconsistent, bloated codebases if used carelessly.

The description of your project journey provides a concrete example of how AI and human collaboration can work in practice - with you providing the vision, architectural guidance, and quality control while letting the AI handle implementation details.

This kind of real-world experience report is valuable for the industry as we all figure out how to integrate these new tools into our workflows.

📝: you asked about impressions of your AI coding assistant blog post, I answered highlighting the strengths of your Parley.nvim project, insights on AI coding capabilities/limitations, appreciation for your balanced perspective on AI as statistical computers needing human grounding, and the value of your practical experience report for the industry.

💬:


