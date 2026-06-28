# 🌐 ISP Connectivity & BGP Routing

> Dual-Homed BGP, NAT/PAT, QoS & Automatic Failover — Built in Cisco Packet Tracer 8.2.2

<img width="1558" height="670" alt="image" src="https://github.com/user-attachments/assets/0f090b93-9889-40dc-978c-bd5ae21caae3" />

---

## Project Overview

This project demonstrates the design, implementation, and live verification of an enterprise network achieving **high-availability internet connectivity** through two independent ISP providers. It uses **Border Gateway Protocol (BGP)** for dynamic path selection and automatic failover — a real-world skill rarely seen at entry level.

### Business Problem Solved
| Requirement | Solution |
|---|---|
| Continuous internet access | Dual-homed BGP with two ISPs |
| No single point of failure | Automatic failover via BGP reconvergence |
| Private-to-public IP translation | NAT/PAT on edge router |
| Voice quality over WAN | QoS with strict priority queuing |

---

## Network Architecture

```
          [ INTERNET-RT ]  ← AS 300 (Simulated Public Internet)
               /     \
        [ISP1-RT]   [ISP2-RT]   ← AS 100 / AS 200
               \     /
            [EDGE-RT]           ← AS 65001 (Enterprise Edge)
            /        \
       [LAN-SW1]  [LAN-SW2]     ← Access Layer
       /     \       /     \
   PCs  Phones   PCs   Phones   ← End Users & VoIP
```

### Three-Layer Design
- **Layer 1 — Upstream:** INTERNET-RT simulating the public internet
- **Layer 2 — ISP:** Two independent ISPs for full redundancy
- **Layer 3 — Customer:** EDGE-RT with internal LANs, servers, and IP phones

---

## Device Inventory

| Device | Model | Role | AS Number |
|---|---|---|---|
| INTERNET-RT | Cisco 2911 | Simulated internet | AS 300 |
| ISP1-RT | Cisco 2911 | Primary ISP | AS 100 |
| ISP2-RT | Cisco 2911 | Backup ISP | AS 200 |
| EDGE-RT | Cisco 2911 | Enterprise edge router | AS 65001 |
| LAN-SW1, LAN-SW2 | Cisco 2960 | Access layer switches | — |
| ENT-SERVER x2 | Server | DHCP & DNS per subnet | — |
| PCs, IP Phones | Mixed | End users & voice | — |

---

## IP Addressing Plan

### WAN Links (/30 Point-to-Point)
| Link | Subnet |
|---|---|
| ISP1 ↔ INTERNET | 203.0.113.0/30 |
| ISP2 ↔ INTERNET | 203.0.114.0/30 |
| ISP1 ↔ EDGE | 100.64.1.0/30 |
| ISP2 ↔ EDGE | 100.64.2.0/30 |

### LAN Subnets
| VLAN | Purpose | Subnet |
|---|---|---|
| VLAN 10 | Data (Site 1) | 192.168.10.0/24 |
| VLAN 20 | Data (Site 2) | 192.168.20.0/24 |
| VLAN 110 | Voice (Site 1) | 192.168.110.0/24 |
| VLAN 120 | Voice (Site 2) | 192.168.120.0/24 |

---

## Configuration Phases

### Phase 1 — Topology & Addressing
Devices placed, WAN IPs assigned, all links verified up/up.

### Phase 2 — BGP Peering
```bash
router bgp 65001
 neighbor 100.64.1.1 remote-as 100
 neighbor 100.64.2.1 remote-as 200
 network 192.168.10.0 mask 255.255.255.0
 network 192.168.20.0 mask 255.255.255.0
 network 100.64.1.0 mask 255.255.255.252
 network 100.64.2.0 mask 255.255.255.252
```

### Phase 3 — NAT/PAT
```bash
access-list 1 permit 192.168.10.0 0.0.0.255
access-list 1 permit 192.168.20.0 0.0.0.255

ip nat inside source list 1 interface se0/3/0 overload
ip nat inside source list 1 interface se0/3/1 overload
```

### Phase 4 — DHCP/DNS
ENT-SERVERs configured with DHCP pools and DNS zones for local hostname resolution per subnet.

### Phase 5 — Dual-Homed BGP Failover
Live failover tested with continuous ping. ISP1 shut down mid-test → BGP converged to ISP2 within **~30 seconds** → ping resumed successfully.

### Phase 6 — QoS for VoIP
```bash
access-list 101 permit udp any any eq 5060
access-list 101 permit udp any any range 16384 32767

class-map VOICE-TRAFFIC
 match access-group 101

policy-map WAN-QOS
 class VOICE-TRAFFIC
  priority 256
 class class-default
  fair-queue
```

---

## Verification Results

### BGP Neighbor Status
| Neighbor | AS | State | Prefixes Received |
|---|---|---|---|
| 100.64.1.1 | 100 | Established | 4 |
| 100.64.2.1 | 200 | Established | 4 |

### Live Failover Test
- Continuous ping running to INTERNET-RT (203.0.113.1)
- ISP1 link manually shut down during test
- BGP detected failure and converged to ISP2 in ~30 seconds
- ~15 packets dropped during reconvergence, then resumed
- `show ip bgp` confirmed path shifted: AS 100 → AS 200
- `show ip nat translations` confirmed NAT switched to ISP2 serial IP

### NAT/PAT Sample Output
```
Pro    Inside Global     Inside Local      Outside
icmp   100.64.1.2:26     192.168.10.10:26  203.0.113.1:26
icmp   100.64.1.2:27     192.168.10.10:27  203.0.113.1:27
icmp   100.64.1.2:2      192.168.20.11:2   203.0.113.1:2
```

---

## Key Concepts Demonstrated

**BGP Path Selection Order:**
1. Local Preference (highest wins)
2. AS-PATH length (shortest wins)
3. Origin
4. MED
5. eBGP over iBGP
6. Router ID

> ISP1 was naturally preferred due to shorter AS-PATH.

**Why Dual-Homed BGP Matters:**
Single ISP connections are a business risk. Dual-homed BGP ensures the network stays online even if an entire ISP infrastructure fails — this is why enterprises pay for redundant connections.

**Why QoS is Critical for VoIP:**
Without QoS, bulk data transfers monopolize WAN bandwidth, causing voice packets to drop and calls to sound robotic. Strict priority queuing keeps voice crisp at all times.

---

## Skills Demonstrated

- eBGP peering and neighbor configuration
- Multi-ISP redundancy design
- NAT/PAT configuration and verification
- WAN link and failover management
- QoS architecture for VoIP
- DHCP/DNS server configuration
- Voice VLAN design
- Live failover testing and analysis
- Routing table and NAT translation verification
- Network documentation

---

## Tools Used

- **Cisco Packet Tracer 8.2.2**
- Cisco IOS CLI (2911 Routers, 2960 Switches)

---

## Repository Structure

```
├── README.md
├── topology/
│   └── BGP-Dual-Homed.pkt        # Packet Tracer file
├── configs/
│   ├── EDGE-RT.txt
│   ├── ISP1-RT.txt
│   ├── ISP2-RT.txt
│   └── INTERNET-RT.txt
└── docs/
    └── ISP_Connectivity_BGP_Documentation.pdf
```

---


> *This project is part of a hands-on networking portfolio built to demonstrate real-world enterprise network engineering skills.*
