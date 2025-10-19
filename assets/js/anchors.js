(function () {
  const globalUsedIds = new Set();
  const globalCounters = {
    para: 1,
    item: 1,
    head: 1,
    foot: 1,
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

  let activeAnchorHost = null;

  function setActiveAnchorHost(host) {
    if (activeAnchorHost && activeAnchorHost !== host) {
      activeAnchorHost.classList.remove("deep-anchor-active");
    }

    activeAnchorHost = host;
    if (host) {
      host.classList.add("deep-anchor-active");
    }
  }

  function clearActiveAnchorHost(event) {
    if (
      event &&
      event.target &&
      event.target.closest &&
      event.target.closest(".has-deep-anchor")
    ) {
      return;
    }

    if (activeAnchorHost) {
      activeAnchorHost.classList.remove("deep-anchor-active");
      activeAnchorHost = null;
    }
  }

  const pointerSupported = typeof window !== "undefined" && "PointerEvent" in window;

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
    anchor.setAttribute("title", "Link to this section");
    anchor.tabIndex = -1;
    anchor.innerHTML = '<span class="deep-anchor-icon" aria-hidden="true">🔗</span>';

    element.classList.add("has-deep-anchor");
    element.classList.add("deep-anchor-initialized");

    element.appendChild(anchor);

    const handleActivation = function (event) {
      if (anchor.contains(event.target)) {
        return;
      }

      const selection = window.getSelection ? window.getSelection() : null;
      if (selection && selection.toString && selection.toString().length > 0) {
        return;
      }

      setActiveAnchorHost(element);
    };

    anchor.addEventListener("focus", function () {
      setActiveAnchorHost(element);
    });

    anchor.addEventListener("click", function (event) {
      event.stopPropagation();
      setActiveAnchorHost(element);
    });

    if (pointerSupported) {
      anchor.addEventListener("pointerdown", function (event) {
        event.stopPropagation();
        setActiveAnchorHost(element);
      });

      element.addEventListener("pointerdown", handleActivation);
    } else {
      anchor.addEventListener("touchstart", function (event) {
        event.stopPropagation();
        setActiveAnchorHost(element);
      });

      element.addEventListener("touchstart", handleActivation);
    }

    element.addEventListener("click", handleActivation);
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
        register(li, "foot");
        return;
      }
      register(li, "item");
    });

    const headings = container.querySelectorAll(
      "h1, h2, h3, h4, h5, h6"
    );
    headings.forEach((heading) => {
      if (heading.closest(".footnotes")) {
        return;
      }
      register(heading, "head");
    });
  }

  onReady(function () {
    document.addEventListener("click", clearActiveAnchorHost);
    if (pointerSupported) {
      document.addEventListener("pointerdown", clearActiveAnchorHost);
    } else {
      document.addEventListener("touchstart", clearActiveAnchorHost);
    }

    document.querySelectorAll("[id]").forEach((element) => {
      if (element.id) {
        globalUsedIds.add(element.id);
      }
    });

    document.querySelectorAll(".post-content").forEach(assignAnchors);

    if (window.location.hash) {
      const target = document.getElementById(
        decodeURIComponent(window.location.hash.slice(1))
      );
      if (target && target.classList.contains("has-deep-anchor")) {
        setActiveAnchorHost(target);
      }
    }

    window.addEventListener("hashchange", function () {
      if (!window.location.hash) {
        clearActiveAnchorHost();
        return;
      }

      const target = document.getElementById(
        decodeURIComponent(window.location.hash.slice(1))
      );

      if (target && target.classList.contains("has-deep-anchor")) {
        setActiveAnchorHost(target);
      }
    });
  });
})();
