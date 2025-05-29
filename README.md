# DNSMASQ IPv6-Only DNS Server (Docker)

A lightweight, containerized DNS server using [dnsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html) that **only resolves IPv6 (AAAA) records**.
Perfect for testing, dual-stack migrations, or any scenario where you want to strictly limit DNS to IPv6 traffic.

---

## Features

* **IPv6-Only**: Does not resolve IPv4 (A) records.
* **Customizable Upstream DNS**: Uses your chosen IPv6 DNS resolvers.
* **Simple & Lightweight**: Based on Alpine Linux.
* **No DHCP**: Pure DNS only.

---

## Quick Start

### 1. Build the Image

```sh
docker build -t dnsmasq-ipv6 .
```

### 2. Configure

Modify `dnsmasq.conf` as needed (default config is included for pure IPv6 use).

### 3. Run the Container

```sh
docker run -d --name dnsmasq-ipv6 \
  --network=host \
  --restart unless-stopped \
  dnsmasq-ipv6
```

> `--network=host` is recommended for easiest IPv6 exposure, but you can use custom bridge networking if needed.

---

## Docker Compose Example

```yaml
version: '3.8'
services:
  dnsmasq-ipv6:
    image: alpine:latest
    command: ["dnsmasq", "-k", "--conf-file=/etc/dnsmasq.conf"]
    volumes:
      - ./dnsmasq.conf:/etc/dnsmasq.conf:ro
    network_mode: host
    restart: unless-stopped
```

---

## Testing

To verify IPv6 resolution only:

```sh
dig @localhost -p 53 google.com AAAA
dig @localhost -p 53 google.com A
```

* Only the AAAA query should return results; the A query should return nothing or `::`.

---

## Notes

* This image does **not** support DHCP or any IPv4-related services.
* Suitable for labs, test environments, or production with proper firewalling.
* Requires host/bridge networking with IPv6 enabled.

---

## Credits

* [dnsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html)
* [Alpine Linux](https://alpinelinux.org/)

---

**Pull requests and issues welcome!**

---

Let me know if you want this tailored for GitHub, Portainer, or expanded for other use-cases!

