---
name: codebase
description: >
  Semantic and symbolic codebase analysis using the Serena MCP server. 
  Use this for deep structural understanding, implementation tracing, 
  and semantic refactoring.
---

# Serena Codebase Procedure

## 1. Structural Mapping
Don't just `ls`. Understand the *symbols*.
- **Overview:** `mcp_serena_get_symbols_overview(relative_path="...")` to see classes/methods.
- **Find:** `mcp_serena_find_symbol(name_path_pattern="...")` to locate specific logic.

## 2. Relationship Tracing
Use these to understand the "Why" and "Where else".
- **Implementations:** `mcp_serena_find_implementations` to see how a trait/interface is used.
- **References:** `mcp_serena_find_referencing_symbols` to see the impact of a change.
- **Declaration:** `mcp_serena_find_declaration` to find the exact source of a symbol.

## 3. Mutation Prohibition
You are strictly FORBIDDEN from using any `serena` tool that modifies the filesystem (e.g., `replace_content`, `replace_symbol_body`, `insert_after_symbol`, `rename_symbol`).
All file mutations MUST go through the core `replace` or `write_file` tools as mandated by `EXECUTION.md`. There are ZERO exceptions.

## 4. Language Constraints
- **Allowed:** Use `serena` for read-only analysis of languages where LSP-based symbolic analysis provides high-fidelity results (e.g., Lua, Rust, Go, Python).
- **Prohibited:** Do NOT use `serena` for analysis of `.nix` files. Use standard `grep_search` and `glob` instead.

## 5. Diagnostics
Check for errors before the user even runs a build.
- **LSP Check:** `mcp_serena_get_diagnostics_for_file(relative_path="...")`.
