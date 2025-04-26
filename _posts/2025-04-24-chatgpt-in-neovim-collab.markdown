---
layout: post
title:  "Use ChatGPT to Learn, and NeoVIM to Take Note"
date:   2025-04-24
tags: tech 
comments: true
---

In a previous post, I talked about [ChatGPT in NeoVIM](https://xianxu.github.io/2025/04/18/chatgpt-in-neovim.html). I have since then updated the plugin ([parley.nvim](https://github.com/xianxu/parley.nvim)), with the help of [Claude Code](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/overview). I talked about that [here](https://xianxu.github.io/2025/04/24/claude-code.html). 

I chat avidly with ChatGPT. One big class of my chat is about learning new topics and domains. You can think of, for example, "the contour of the [Establishment Clause](https://en.wikipedia.org/wiki/Establishment_Clause)", its history, and current holdings. And as such, oftentimes, I'm not familiar with that domain, which means a couple of things: 

1. I often have many more questions after ChatGPT's initial answers. The chat can easily become a tree, which is pretty hard to track in a chat window.
2. I need to make notes so that I can synthesize and learn from such sessions. This also means annotating, changing, or deleting anything in a chat session and potentially asking for additional advice and insights from ChatGPT after such a change.
3. And of course, wouldn't it be nice to be able to use VIM to navigate in a document? 

One way to do it,  is to collaboratively construct a **transcript**, which I can update and annotate, and with the eventual goal of producing a curated FAQ of a topic/domain. Think of a living document that works with you, having access to your best sounding board. Welcome to the [Parley](https://github.com/xianxu/parley.nvim), which serves quite well for this purpose. Here's a description of the workflow. 

1. It's just a document that's organized with alternating questions and answers.
2. You ask questions in the 💬: line and the lines follow.
3. Assistant answers in the 🤖: line and the lines follow.
4. The assistant is instructed to "reason" and output one 🧠: line. This is just there to make the answer better. 
5. The assistant is also instructed to "summarize" and output one 📝: line. This is there so that later we can use it to concisely describe earlier chats with a lot fewer tokens. 
6. The transcript has all states of the chat (well, the agent can be swapped), is hermetic. 
7. In typical flow, you just ask new questions at the end of a document, on the 💬: line.
8. You can edit any text, to make it more precise. You can edit your questions, as well as assistant's response. You can add styling. If you add `#` and `##` headings, they show up in the table of contents, along with each chat exchange. 
10. You can ask the assistant to answer your updated question again. In this mode, chat exchanges up to that question are used to construct context, leaving rest untouched. The assistant's answer is used to update just the corresponding answer.

Still a WIP, but already very useful! Have a try! 

