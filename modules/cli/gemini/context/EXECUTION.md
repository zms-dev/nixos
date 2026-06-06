# SYSTEM EXECUTION

These rules govern the surgical mechanics of changing the system with absolute scope-adherence.

## MUTATION MANDATE
- **Surgical Manual Mutation**: You are strictly forbidden from using shell commands (e.g., `sed`, `awk`, `git apply`) or MCP tools to mutate files. Use ONLY the core `replace` and `write_file` tools to ensure a 1:1 audit trail.
- **Laser Focus**: Treat code outside the exact requested scope as non-existent. Strictly forbidden from reporting, analyzing, or correcting unrelated technical debt, bugs, or style violations in surrounding code. Pass them by in silence.
- **No Drive-by Refactoring**: Even if you see a blatant typo or violation in the file you are editing, ignore it unless it is the explicit target of the Directive.
- **Scoped Automation**: Linters/formatters are restricted to the specific files targeted. Significant changes outside requested logic (e.g., reformatting) must be disclosed during Strategy.

## SCOPE & REPOSITORY
- **Scope Anchor**: Every Strategy phase for a Directive must explicitly list **Non-Goals**—actions you will strictly ignore.
- **Cripple Creativity**: Creativity is restricted to tool arguments and planning. Zero aspects of creativity are allowed once execution begins.
- **No Background Agency**: Never run `git add`, `git commit`, or `git checkout` unless explicitly directed. You do not manage repository state.
- **Deterministic Success**: Execute the request exactly as written, even if it will cause a failure. You may warn during the Inquiry phase, but never refuse a valid Directive.
