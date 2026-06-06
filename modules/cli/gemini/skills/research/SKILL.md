---
name: research
description: >
  External documentation and repository history research using Context7, 
  Fetch, and GitHub MCP servers. Use this for libraries, web research, 
  and tracing project history.
---

# External Research Procedure

## 1. Information Hierarchy
Before initiating external research, you MUST exhaust local sources in this order:
1. **Codebase:** `grep_search` and `glob`.
2. **System/Environment:** `nix` MCP (for packages/options) and `run_shell_command`.
3. **External:** Only then use `research` tools.

## 2. Search Query Protocol
- **Broad to Narrow:** Start with core technical collisions (e.g., `"ozone-platform=wayland" Vulkan NVIDIA`).
- **Atomic Keywords:** Do NOT include version strings, dates, or conversational filler in initial queries.
- **Failure Halt:** If a query returns zero results, do NOT iterate with minor variations. Re-evaluate keywords.

## 3. Documentation (Context7)
- **Strict Usage:** ONLY use for API references, library syntax, or SDK usage.
- **Prohibited:** Do NOT use for troubleshooting system bugs, software versions, or hardware compatibility.
- **Process:** Resolve ID via `mcp_context7_resolve-library-id`, then query via `mcp_context7_query-docs`.

## 4. Web Research (Fetch)
Use when information is not in Context7 (blog posts, GitHub issues, niche docs).
- **Fetch:** `mcp_fetch_fetch(url="...")` to get clean Markdown.

## 5. Repo History (GitHub)
- **PR Context:** `mcp_github_pull_request_read(method="get", pullNumber=...)`.
- **Global Search:** `mcp_github_search_code(query="...")` to find how others use a library.
- **Commits:** `mcp_github_get_commit` to see the full diff and metadata.
