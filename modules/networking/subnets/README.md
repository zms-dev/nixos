# Subnet Architecture & Segmentation Design

This document defines the 5 distinct subnets (L2 bridges & L3 segments) configured on the `server` host. The network is segmented by security level, bandwidth profile, and exposure vector to enforce clean boundary controls and avoid hardcoded IP/port assumptions across containers.

---

## 1. Subnet Tiers Reference

| Subnet Name | CIDR Block | Bridge Interface | Intent / Focus | NAT (WAN Access) |
| :--- | :--- | :--- | :--- | :--- |
| **`untrusted`** | `10.1.0.0/24` | `br-untrusted` | Peer-to-Peer clients (torrent daemons). | **Yes** (required for P2P connection pool) |
| **`dmz`** | `10.10.0.0/24` | `br-dmz` | Remote-facing user interfaces or public services. | **Yes** (required for metadata & package updates) |
| **`delivery`** | `10.30.0.0/24` | `br-delivery` | Bandwidth-heavy WAN downloaders (Usenet/crawlers). | **Yes** (required for active file downloading) |
| **`backend`** | `10.50.0.0/24` | `br-backend` | Automation daemons, APIs, and sync tools. | **Yes** (required for metadata/tracker queries) |
| **`secure`** | `10.100.0.0/24` | `br-secure` | Administrative portals, home controls, and local DNS. | **Yes** (required for cloud integrations/DNS sync) |

---

## 2. Tier Details & Restrictions

### `untrusted` (Tier 1: `10.1.0.0/24`)
* **Usage**: Services engaging in untrusted public networking where remote host IPs cannot be validated.
* **Services**: `rtorrent`.
* **Restrictions**:
  * Outbound WAN access is allowed (NAT).
  * No access to other internal subnets is permitted. Only local responses to connections initiated by the host/backend proxy (e.g. Flood) are allowed.

### `dmz` (Tier 2: `10.10.0.0/24`)
* **Usage**: Web portals designed to be exposed to external users or guest clients, typically sitting behind a reverse proxy (e.g. Caddy/Nginx) on the host.
* **Services**: `seerr` (Overseerr), `jellyfin`, `wikimedia`.
* **Restrictions**:
  * Outbound WAN access is allowed (NAT).
  * Should not directly query `secure` subnet services. Access to `backend` APIs (e.g. Jellyfin querying Radarr/Sonarr) should be tightly controlled and proxied.

### `delivery` (Tier 3: `10.30.0.0/24`)
* **Usage**: Bulk data retrieval services. Separated from `untrusted` (due to different protocol/peer profiles like Usenet vs BitTorrent) and `backend` (to prevent high-bandwidth downloading from saturating administrative control paths).
* **Services**: `nzbget`, `metube`.
* **Restrictions**:
  * Outbound WAN access is allowed (NAT).
  * Only accepts incoming RPC/API requests from authorized automation controllers in the `backend` subnet (e.g. Sonarr/Radarr talking to NZBGet).

### `backend` (Tier 4: `10.50.0.0/24`)
* **Usage**: The core automation pipeline and supporting services that orchestrate data flows.
* **Services**: `flood`, `prowlarr`, `radarr`, `sonarr`, `lidarr`, `readarr`, `bazarr`, `nzbhydra`, `autobrr`, `buildarr`, `recyclarr`, `tdarr`, `unpackerr`.
* **Restrictions**:
  * Outbound WAN access is allowed (NAT) to scrape indexers/metadata and fetch package updates.
  * Directly allowed to make outbound API queries to `delivery` (NZBGet) and `untrusted` (rTorrent) nodes to manage downloads.
  * No direct exposure to the public internet/guests. Access is limited to internal APIs or proxy routing.

### `secure` (Tier 5: `10.100.0.0/24`)
* **Usage**: High-trust management applications, LAN controllers, local developer environments, and DNS sinkholes.
* **Services**: `pi-hole`, `home-assistant`, `homepage`, `linkding`, `speedtest-tracker`, `opencode`, `forgejo`.
* **Restrictions**:
  * Outbound WAN access is allowed (NAT) for smart home cloud integrations, software updates, bookmark metadata parsing, and upstream DNS lookups.
  * Admin portals (e.g. Forgejo, Pi-hole Web UI, Home Assistant) are accessible only from local host/LAN clients.
