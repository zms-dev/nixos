/*
  chromium — Chromium browser with extensions, hardware acceleration, and privacy optimizations
  https://www.chromium.org/
*/
{ ... }:
{
  den.aspects.apps._.chromium = {
    includes = [ ];

    homeManager =
      { lib, pkgs, ... }:
      let
        features = {
          # --- Performance & Engine ---
          # Faster mid-tier JS compiler
          V8Maglev = true;
          # Cache pages in RAM for instant navigation
          BackForwardCache = true;
          # Multi-threaded downloads
          ParallelDownloading = true;
          # Faster network protocol
          Quic = true;
          # Enable smooth scrolling animations
          SmoothScrolling = true;
          # Direct GPU memory access for rendering
          ZeroCopy = true;
          # Hardware-accelerated drawing for canvas elements
          CanvasOopRasterization = true;
          # Offload JS memory management to background threads
          V8ConcurrentMarking = true;
          V8ConcurrentScavenging = true;

          # --- Hardware Acceleration (NVIDIA 4090) ---
          # Video Decoding/Encoding
          VaapiVideoDecoder = true;
          VaapiVideoEncoder = true;
          GlobalVaapiLock = true;
          # Prioritize Vulkan-VAAPI path for better interop with Vulkan renderer
          VaapiVideoDecodeLinuxVulkan = true;
          VaapiOnNvidiaGPUs = true;
          VaapiIgnoreDriverChecks = true;
          AcceleratedVideoEncoder = true;
          PlatformHEVCDecoderSupport = true;

          # Rendering Backend & Sync
          DefaultANGLEVulkan = true;
          VulkanFromANGLE = true;
          # Modern synchronization for Wayland/NVIDIA (Fixes negative latency)
          WaylandExplicitSync = true;

          # --- Integration ---
          # Use native PipeWire for audio/video capturing
          WebRTCPipeWireCapturer = true;
          # Run audio service in a dedicated process for better isolation
          AudioServiceOutOfProcess = true;
          # Allow WebRTC to automatically adjust microphone input levels
          WebRtcAllowInputVolumeAdjustment = true;

          # --- Privacy & Security ---
          # Visit link database partitioning
          PartitionVisitedLinkDatabase = true;
          # Prefetch privacy changes
          PrefetchPrivacyChanges = true;
          # Split cache partitioning
          SplitCacheByNetworkIsolationKey = true;
          SplitCodeCacheByNetworkIsolationKey = true;
          # Connection partitioning
          EnableCrossSiteFlagNetworkIsolationKey = true;
          HttpCacheKeyingExperimentControlGroup = true;
          PartitionConnectionsByNetworkIsolationKey = true;
          # Strict origin isolation
          StrictOriginIsolation = true;
          # Reduce accept language header
          ReduceAcceptLanguage = true;
          # Content settings partitioning
          ContentSettingsPartitioning = true;

          # --- Experimental / Potentially Unstable (Disabled) ---
          # Legacy GL paths (Disabled in favor of unified Vulkan pipeline)
          VaapiVideoDecodeLinuxGL = false;
          AcceleratedVideoDecodeLinuxZeroCopyGL = false;
          # New buffer format (Fix available via PR 430 patch for nvidia-vaapi-driver)
          UseMultiPlaneFormatForHardwareVideo = true;
          # Native Vulkan path (Incompatible with NVIDIA/Wayland Ozone)
          Vulkan = false;
          # Wayland color management (Prevents washed out colors)
          WaylandWpColorManagerV1 = false;
          # Direct Video Decoder (ChromeOS path, incompatible with Linux NVIDIA)
          UseChromeOSDirectVideoDecoder = false;

          # --- UX & Bloat Reduction (Disabled) ---
          ProactiveTabFreezeAndDiscard = false;
          AutomaticTabDiscarding = false;
          TpcdHeuristicsGrants = false;
          TpcdMetadataGrants = false;
          EnableHyperlinkAuditing = false;
          NTPPopularSitesBakedInContent = false;
          UsePopularSitesSuggestions = false;
          EnableSnippets = false;
          ArticlesListVisible = false;
          EnableSnippetsByDse = false;
          InterestFeedV2 = false;
          PrivacySandboxSettings4 = false;
          BrowsingTopics = false;
          BrowsingTopicsDocumentAPI = false;
          BrowsingTopicsParameters = false;
          AdaptiveButtonInTopToolbarTranslate = false;
          DetailedLanguageSettings = false;
        };

        enabledFeatures = builtins.attrNames (lib.attrsets.filterAttrs (_: v: v == true) features);
        disabledFeatures = builtins.attrNames (lib.attrsets.filterAttrs (_: v: v == false) features);
      in
      {
        programs.chromium = {
          enable = true;
          package = pkgs.chromium.override {
            enableWideVine = true;
          };
          extensions = [
            "ddkjiahejlhfcafbddmgiahcphecmpfh" # uBlock Origin Lite
            "gcbommkclmclpchllfjekcdonpmejbdp" # https-everywhere
            "pfkkfbfdhomeagojoahjmkojeeepcolc" # watchmarker-for-youtube
            "gebbhagfogifgggkldgodflihgfeippi" # return-youtube-dislike
            "ponfpcnoihfmfllpaingbgckeeldkhle" # enhancer-for-youtube
            "mnjggcdmjocbbbhaepdhchncahnbgone" # sponsorblock-for-youtube
            "eimadpbcbfnmbkopoojfekhnkhdbieeh" # dark-reader
            "hlepfoohegkhhmjieoechaddaejaokhf" # refined github
          ];
          commandLineArgs = [
            # Wayland
            "--ozone-platform-hint=auto"
            # Performance
            "--gtk-version=4"
            "--ignore-gpu-blocklist"
            "--enable-gpu-rasterization"
            "--enable-oop-rasterization"
            "--enable-zero-copy"
            # Force stable decoding path for Chromium 147+ on NVIDIA
            "--use-cmd-decoder=passthrough"
            # Silence Vulkan compatibility errors in the terminal
            # "--disable-vulkan-fallback-to-gl-for-testing"
            # Force stable OpenGL/EGL backends to silence Vulkan errors
            "--use-gl=angle"
            "--use-angle=vulkan"
            # Increase threads for drawing to utilize high core count
            "--num-raster-threads=12"
            # Increase memory limit for single tabs
            "--js-flags=\"--max-old-space-size=8192\""
            # Use strict extension verification
            "--extension-content-verification=enforce_strict"
            "--extensions-install-verification=enforce_strict"
            # Etc
            "--disk-cache=$XDG_RUNTIME_DIR/chromium-cache"
            "--disable-reading-from-canvas"
            "--no-first-run"
            "--disable-wake-on-wifi"
            "--disable-speech-api"
            "--disable-speech-synthesis-api"
            "--disable-breakpad"
            # Disable pings
            "--no-pings"
            # Require HTTPS for component updater
            "--component-updater=require_encryption"
            # Disable crash upload
            "--no-crash-upload"
            # don't run things without asking
            "--no-service-autorun"
            # Disable sync
            "--disable-sync"
            # please stop asking me to be the default browser
            "--no-default-browser-check"

            "--enable-features=${builtins.concatStringsSep "," enabledFeatures}"
            "--disable-features=${builtins.concatStringsSep "," disabledFeatures}"
          ];
        };
      };
  };
}
