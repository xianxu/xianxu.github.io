(function () {
  const globalUsedIds = new Set();
  const globalCounters = {
    para: 1,
    item: 1,
  };

  function onReady(callback) {
    if (document.readyState === "loading") {
      document.addEventListener("DOMContentLoaded", callback, { once: true });
    } else {
      callback();
    }
  }

  function slugify(text) {
    return text
      .toLowerCase()
      .trim()
      .replace(/[\u0300-\u036f]/g, "")
      .replace(/[^a-z0-9\s-]/g, "")
      .replace(/\s+/g, "-")
      .replace(/-+/g, "-")
      .replace(/^-|-$/g, "")
      .slice(0, 48);
  }

  function appendAnchorLink(element, id) {
    for (let i = 0; i < element.children.length; i += 1) {
      const child = element.children[i];
      if (child.classList && child.classList.contains("deep-anchor")) {
        return;
      }
    }

    if (element.classList.contains("deep-anchor-initialized")) {
      return;
    }

    const anchor = document.createElement("a");
    anchor.className = "deep-anchor";
    anchor.href = `#${id}`;
    anchor.setAttribute("aria-label", "Link to this section");
    anchor.textContent = "¶";
    anchor.tabIndex = -1;

    element.classList.add("has-deep-anchor");
    element.classList.add("deep-anchor-initialized");
    element.appendChild(anchor);
  }

  function assignAnchors(container) {
    function register(element, prefix) {
      if (!element) {
        return;
      }

      if (element.id) {
        globalUsedIds.add(element.id);
        appendAnchorLink(element, element.id);
        return;
      }

      const text = (element.textContent || "").trim();
      if (!text) {
        return;
      }

      let baseSlug = slugify(text);
      if (!baseSlug) {
        baseSlug = String(globalCounters[prefix]++);
      }

      let id = `${prefix}-${baseSlug}`;
      let suffix = 2;
      while (globalUsedIds.has(id)) {
        id = `${prefix}-${baseSlug}-${suffix++}`;
      }

      element.id = id;
      globalUsedIds.add(id);
      appendAnchorLink(element, id);
    }

    const paragraphs = container.querySelectorAll("p");
    paragraphs.forEach((p) => {
      if (p.closest("li") || p.closest(".footnotes")) {
        return;
      }
      register(p, "para");
    });

    const listItems = container.querySelectorAll("li");
    listItems.forEach((li) => {
      if (li.closest(".footnotes")) {
        return;
      }
      register(li, "item");
    });
  }

  onReady(function () {
    document.querySelectorAll("[id]").forEach((element) => {
      if (element.id) {
        globalUsedIds.add(element.id);
      }
    });

    document.querySelectorAll(".post-content").forEach(assignAnchors);
  });
})();
