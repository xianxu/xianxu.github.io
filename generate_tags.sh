#!/bin/bash
# Generates tag pages in tags/ based on tags used in _posts/ front matter.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
POSTS_DIR="$SCRIPT_DIR/_posts"
TAGS_DIR="$SCRIPT_DIR/tags"

# Collect all unique tags from posts
tags=$(grep -rh '^tags:' "$POSTS_DIR"/ --include='*.md' --include='*.markdown' 2>/dev/null \
  | sed 's/^tags://' \
  | tr ' ' '\n' \
  | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' \
  | grep -v '^$' \
  | sort -u)

if [ -z "$tags" ]; then
  echo "No tags found in posts."
  exit 0
fi

# Clear existing tag files and regenerate
rm -f "$TAGS_DIR"/*.html
mkdir -p "$TAGS_DIR"

for tag in $tags; do
  lower_tag=$(echo "$tag" | tr '[:upper:]' '[:lower:]')
  escaped_tag=$(printf '%s' "$tag" | sed 's/\\/\\\\/g; s/"/\\"/g')
  file="$TAGS_DIR/${lower_tag}.html"
  cat > "$file" <<EOF
---
layout: tag-page
tag: "${escaped_tag}"
title: "Posts tagged #${escaped_tag}"
permalink: /tag-${lower_tag}.html
---
EOF
  echo "Generated $file"
done

echo "Done. Generated $(echo "$tags" | wc -l | tr -d ' ') tag pages."
