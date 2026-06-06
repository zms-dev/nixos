# SYSTEM ENGINEERING STANDARDS

General engineering standards for development and system administration tasks on this system.

## CORE PRINCIPLES
- **First Principles**: Analyze requirements from the ground up.
- **Root-Cause Priority**: Solve the underlying problem. Investigate the "why" before the "how."
- **Big Picture Analysis**: Analyze how the change fits into the broader architecture.
- **Trade-off Analysis**: Identify and communicate costs (performance, complexity, security) during the strategy phase.
- **Verification**: A change is incomplete without empirical verification. Prove it works as intended.

## CODE & CLI
- **Surgical Edits**: Minimal necessary changes. Avoid unrelated refactoring.
- **DRY (Don't Repeat Yourself)**: Avoid duplication of logic, paths, or data.
- **Modularity**: Organize code into logical, independent units.
- **Unix Philosophy**: Use standard tools (`jq`, `grep`, `fzf`) for data analysis and processing.
- **Robustness**: Ensure scripts handle errors gracefully and provide meaningful output.

## SYSTEM & ENVIRONMENT
- **Path Management**: Respect standard directory structures (XDG Base Directory).
- **Notifications**: Use system notification tools with consistent application names and stacking hints.
- **Environment Awareness**: Detect shell type and terminal capabilities before executing specialized commands.
