# Subnet Architecture & Traffic Segmentation Design

This document defines the 5 distinct subnets (L2 bridges & L3 segments) configured on the `server` host. The network is segmented by traffic type, initiation vector, and destination familiarity to enforce boundary controls.

---

## 1. Subnet Traffic Taxonomy

| Subnet Name | CIDR Block | Bridge Interface | Traffic Profile | NAT (WAN Access) |
| :--- | :--- | :--- | :--- | :--- |
| **`untrusted-ingress`** | `10.10.1.0/24` | `br-untr-in` | **Incoming - Unknown**: Arbitrary external P2P torrent peers initiating inbound connections. | **Yes** (P2P peer communication) |
| **`trusted-ingress`** | `10.10.100.0/24` | `br-trust-in` | **Incoming - Known**: Authenticated user clients/agents accessing web UIs, dashboards, or portals. | **Yes** (Metadata/updates retrieval) |
| **`untrusted-egress`** | `10.50.1.0/24` | `br-untr-eg` | **Outgoing - Unknown**: Downloader clients pulling down heavy payloads from arbitrary WAN hosts. | **Yes** (Heavy download payload traffic) |
| **`trusted-egress`** | `10.50.100.0/24` | `br-trust-eg` | **Outgoing - Known**: Coordinators, managers, and scrapers querying specific, well-defined metadata or indexer APIs. | **Yes** (Known API and metadata traffic) |
| **`isolated`** | `10.100.100.0/24` | `br-isolated` | **LAN-Only**: Strictly local traffic with zero outbound WAN (NAT) access. | **No** (Completely isolated from the Internet) |

---

## 2. Subnet Definitions & Container Placements

### `untrusted-ingress` (Tier 1: `10.10.1.0/24`)
* **Intention**: Hosts peer-to-peer applications exposed directly to unknown incoming external peers.
* **NAT Enabled**: Yes (incoming/outgoing torrent peer discovery).
* **Bridge**: `br-untr-in`
* **Containers**:
  * `rtorrent` (peer-to-peer torrent client).

### `trusted-ingress` (Tier 2: `10.10.100.0/24`)
* **Intention**: Interactive web portals, dashboards, and version control instances that receive incoming traffic from known/authenticated users (either on the LAN or remote proxy).
* **NAT Enabled**: Yes (for fetching media metadata, remote webhooks, and updates).
* **Bridge**: `br-trust-in`
* **Containers**:
  * `jellyfin` (media player server).
  * `seerr` (Overseerr requests portal).
  * `forgejo` (Git repository service).
  * `home-assistant` (smart home administration dashboard).
  * `homepage` (application directory/status dashboard).
  * `linkding` (bookmark dashboard).
  * `opencode` (web VS Code IDE server).
  * `wikimedia` (documentation wiki portal).

### `untrusted-egress` (Tier 3: `10.50.1.0/24`)
* **Intention**: Downloader clients that initiate outgoing connections to arbitrary external WAN nodes to pull down large files (payloads).
* **NAT Enabled**: Yes (required to fetch files from arbitrary sites).
* **Bridge**: `br-untr-eg`
* **Containers**:
  * `nzbget` (Usenet downloader).
  * `metube` (YouTube/web video downloader).
  * `speedtest-tracker` (downloads payloads from arbitrary speedtest nodes to measure WAN performance).

### `trusted-egress` (Tier 4: `10.50.100.0/24`)
* **Intention**: Automation coordinators, scrapers, indexers, and local control interfaces. These services only initiate outbound WAN connections to specific, known APIs (e.g. MusicBrainz, TVDb, TMDb, subtitle APIs, indexer endpoints).
* **NAT Enabled**: Yes (restricted to specific known API endpoints via host firewall/routing where possible).
* **Bridge**: `br-trust-eg`
* **Containers**:
  * `flood` (web controller for rTorrent).
  * `radarr` / `sonarr` / `lidarr` / `readarr` (media automation stack).
  * `prowlarr` / `nzbhydra` (indexer proxies).
  * `bazarr` (subtitle tracker).
  * `autobrr` (IRC/announce automation).
  * `buildarr` / `recyclarr` (declarative configuration sync agents).
  * `tdarr` (media transcode orchestrator).

### `isolated` (Tier 5: `10.100.100.0/24`)
* **Intention**: Core LAN utility services that do not need outbound WAN access. They operate strictly within the local host/bridge networks.
* **NAT Enabled**: No (completely blocked from accessing the internet).
* **Bridge**: `br-isolated`
* **Containers**:
  * `pi-hole` (provides local DNS resolving to other local subnets and caches local records).
  * `unpackerr` (runs background extraction of local archive files).
