# mcp — Model Context Protocol (MCP) server tool policy rules configuration for gemini-cli
{ ... }:
{
  den.aspects.cli._.gemini-cli._.policies._.mcp = {
    includes = [ ];

    homeManager =
      { ... }:
      {
        programs.gemini-cli.policies."mcp" = {
          rule = [
            # --- Always Allow Purely Read-Only Servers ---
            {
              toolName = "mcp_nixos_*";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "mcp_context7_*";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "mcp_time_*";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "mcp_fetch_*";
              decision = "allow";
              priority = 100;
            }

            # --- Serena (Codebase Analysis) - Allow Read-Only Tools ---
            {
              toolName = "mcp_serena_get_symbols_overview";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "mcp_serena_find_symbol";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "mcp_serena_find_referencing_symbols";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "mcp_serena_find_implementations";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "mcp_serena_find_declaration";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "mcp_serena_get_diagnostics_for_file";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "mcp_serena_read_file";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "mcp_serena_list_dir";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "mcp_serena_find_file";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "mcp_serena_search_for_pattern";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "mcp_serena_read_memory";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "mcp_serena_list_memories";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "mcp_serena_check_onboarding_performed";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "mcp_serena_get_current_config";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "mcp_serena_onboarding";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "mcp_serena_initial_instructions";
              decision = "allow";
              priority = 100;
            }

            # --- GitHub - Allow Read-Only Tools ---
            {
              toolName = "mcp_github_get_*";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "mcp_github_list_*";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "mcp_github_search_*";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "mcp_github_pull_request_read";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "mcp_github_issue_read";
              decision = "allow";
              priority = 100;
            }

            # --- Memory (Graph) - Allow Read-Only Tools ---
            {
              toolName = "mcp_memory_read_graph";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "mcp_memory_search_nodes";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "mcp_memory_open_nodes";
              decision = "allow";
              priority = 100;
            }

            # --- Git (MCP) - Allow Read-Only Tools ---
            {
              toolName = "mcp_git_git_status";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "mcp_git_git_diff*";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "mcp_git_git_log";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "mcp_git_git_branch";
              decision = "allow";
              priority = 100;
            }
            {
              toolName = "mcp_git_git_show";
              decision = "allow";
              priority = 100;
            }
          ];
        };
      };
  };
}
