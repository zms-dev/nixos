{ ... }:
{
  den.aspects.cli._.gemini-cli._.hooks._.notification = {
    includes = [ ];

    homeManager =
      {
        lib,
        pkgs,
        config,
        ...
      }:
      let
        jq = lib.getExe pkgs.jq;
        notify-send = lib.getExe pkgs.libnotify;
        hookPath = "gemini/hooks/notification.sh";
      in
      {
        home.file."${config.xdg.configHome}/${hookPath}" = {
          executable = true;
          text = ''
            #!/usr/bin/env bash
            input=$(cat)

            # Detect type (try notification_type first, fallback to type)
            type=$(echo "$input" | ${jq} -r '.notification_type' 2>/dev/null)
            if [ "$type" == "null" ] || [ -z "$type" ]; then
              type=$(echo "$input" | ${jq} -r '.type' 2>/dev/null)
            fi

            message=$(echo "$input" | ${jq} -r '.message' 2>/dev/null || echo "Gemini requires attention.")

            # Default values
            urgency="normal"
            icon="utilities-terminal"
            summary="Gemini CLI"

            case "$type" in
              "ToolPermission")
                urgency="critical"
                icon="security-high"
                summary="Gemini: Permission Required"
                ;;
              "ActionRequired")
                urgency="normal"
                icon="dialog-warning"
                summary="Gemini: Action Required"
                ;;
              "SessionComplete"|"idle_prompt")
                urgency="normal"
                icon="emblem-success"
                summary="Gemini: Task Complete"
                ;;
              "SystemError")
                urgency="critical"
                icon="dialog-error"
                summary="Gemini: System Error"
                ;;
              "UserInterrupt")
                urgency="normal"
                icon="dialog-warning"
                summary="Gemini: Interrupted"
                ;;
            esac

            ${notify-send} -a "Gemini CLI" \
              -u "$urgency" \
              -i "$icon" \
              -h string:x-canonical-private-synchronous:gemini-cli-hook \
              "$summary" "$message"

            exit 0
          '';
        };

        programs.gemini-cli.settings.hooks.Notification = [
          {
            hooks = [
              {
                type = "command";
                command = "${config.xdg.configHome}/${hookPath}";
              }
            ];
          }
        ];
      };
  };
}
