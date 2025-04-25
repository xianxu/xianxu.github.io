---
layout: post
title:  "Use ChatGPT to Learn, and NeoVIM to Take Note"
date:   2025-04-24
tags: tech 
comments: true
---

In a previous post, I talked about [ChatGPT in NeoVIM](https://xianxu.github.io/2025/04/18/chatgpt-in-neovim.html). I have since then updated the plugin, with the help of [Claude Code](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/overview). I'd like to talk about my workflow [here](https://xianxu.github.io/2025/04/24/claude-code.html). 

I chat avidly with ChatGPT. One big class of my chat is about learning new topics and domains. You can think of, for example, "the contour of the [Establishment Clause](https://en.wikipedia.org/wiki/Establishment_Clause)", its history, and current holdings. And as such, oftentimes, I'm not familiar with that domain, which means a couple of things: 

1. I often have many more questions after ChatGPT's initial answers. The chat can easily span into a tree, pretty hard to track in a chat window.
2. I need to make notes, so that I can synthesize and learn from such sessions. This also means to annotate, change, or delete anything in a chat session, and after such a change, potentially to ask for additional advice and insights from ChatGPT. 

One way to do it,  is to collaboratively construct a transcript, which I can update and annotate, and with the eventual goal of producing a curated FAQ of a topic/domain. Think of a living document that works with you. Welcome to the [ChatGPT in NeoVIM](https://xianxu.github.io/2025/04/18/chatgpt-in-neovim.html), which after my addition, can serve quite well for this purpose. Here's a description of the workflow. 

1. It's just a document that's organized with alternative questions and answers.
2. You ask questions in the 💬: lines.
3. Assistant answers in the 🤖: lines.
4. The assistant is instructed to "reason" and output one 🧠: line. This is just there to make the answer better. 
5. The assistant is also instructed to "summarize" and output one 📝: line. This is there so that later we can use it to concisely describe earlier chats with a lot fewer tokens.
6. In typical flow, you just ask new questions at the end of a document, on the 💬: line.
7. You can edit any text, to make it relevant to you. I added some highlighting rules in nvim, e.g. `@text@` would be highlighted, for me to remember some key phrases. Another example, you can add markdown headings, and the first 2 level headings will be presented in TOC along with chat exchanges.
8. You can ask the assistant to answer your updated question again. In this mode, chat exchanges up to that question are used to construct context, leaving rest untouched. The assistant's answer is used to update just the corresponding answer.

Still a WIP, but already very useful! 

