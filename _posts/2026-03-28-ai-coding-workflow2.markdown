layout: post
title:  "AI Workflow Evolved"
date:   2026-03-28
tags: tech ai 
comments: true
---

It's three weeks after my last post on [AI coding workflow]({% post_url 2026-03-08-ai-coding-workflow %}), so many things have changed, both my understanding of such workflows and the world around it. For example, Nvidia open sourced [OpenShell](https://github.com/NVIDIA/OpenShell). Let's take a look at my evolution, I think this might be useful for people new to the space.

1. Archaic time, where I just used coding agent like `claude` directly, sending prompt directly inside its cli. It's a fun but flaky workflow.

2. Using workflow management like `Conductor`, that's where I was when I wrote [this]({% post_url 2026-03-08-ai-coding-workflow %}).

3. Made my own little workflow, both because of my realization that there isn't that much those "workflows" provide, and my desire to learn what's under the hood. This resulted in a simple `Makefile` based flow, where I use `make issue 42` to download github issue to a well-known-to-AGENTS.md location, and more diligently shaping the workflow in the AGENTS.md. I had two modes, either working on a branch in `worktree`, or working directly on `main`. After all, I'm a single guy tweaking Parley.

4. I kept tinkering this workflow, adding some archive function, to back up `issue.md` and `todo.md` after each feature was done to `history/`. This made it easier to continue tweaking key files, such as `AGENTS.md`, `lessons.md` and `specs`. 

5. [OpenShell](https://github.com/NVIDIA/OpenShell) was open sourced, and you can take a look at their workflow, which was expressed as a set of [agent skills](https://github.com/NVIDIA/OpenShell/tree/main/.agents/skills). Roughly, you can describe what I did in my `Makefile` using plain English and get agent to do it. I'm not very sure what's the point to make such very deterministic workflow agentic; but either way, my `Makefile` was totally written by agents, so in a sense, my `Makefile` based workflow is just compiled agentic instructions. 

6. As I worked with my workflow in `3.`, one issue is that the issues, the code, and the plan to implement issues in the codebase are scattered in several different places, and have different life cycles. In [Conversation: agentic state management](https://xianxu.github.io/2026/03/28/agentic_state_management.html) I wondered why not just use repo to manage issue tracking. This resulted in me just putting issues in a structured way in `issues/` in the repo itself, and the creation of simple `Parley` function to [manage those issues](https://github.com/xianxu/parley.nvim/blob/main/specs/issues/issue-management.md). This made my "single developer" workflow supercharged.

7. Then the latest, I integrated with `OpenShell`, basically replicating what I did in `6.` within an `OpenShell` Docker container for isolation. I just "chatted" about [what I want](https://github.com/xianxu/parley.nvim/blob/main/design/2026-03-28.18-37-34.270.md) in `Parley`, committing it to repo, and ask Claude to [make a plan](https://github.com/xianxu/parley.nvim/blob/main/history/000010-introducing-openshell.md) based on that chat. Some manual testing to make sure it works, and now I have a hermetic sandboxed agentic environment. Agentic coding made setting this up really a bliss, mostly I did was: "go create an OpenShell environment based on my Mac setup in `~/.config/nvim`, `~/.zshrc` and `~/settings/brewfile`".

All of those tinkering is to get a real sense of the shifting ground of software development. It is very evident that agentic coding allow you to customize your environment, just like I mentioned in [Peronalized Software]({% post_url 2026-03-19-the-rise-of-personal-software %}), your development environment is also ripe of customization to your hearts content. 

What's next? I firmly believe that the future is **human setting up the environment**, allowing full automation of coding. I don't believe human can be in the loop to review most of what agents write, it will be such a big bottleneck. Then the million dollar question, is how would we be comfortable agent is doing the right thing, not exposing your private key, not doing <span>$O(n^2)$</span> algorithm when <span>$O(n)$</span> algorithm is available? I don't know, but intend to find out. 

