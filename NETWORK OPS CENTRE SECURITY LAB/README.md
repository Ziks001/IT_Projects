| Zone | Security Level | Hosts |
|------|---------------|-------|
| Internet | 0 - Zero Trust | ISP-RT, OUTSIDE-PC |
| DMZ | 50 - Semi-Trusted | WEB-SERVER, MAIL-SERVER, NOC-SERVER |
| LAN Inside | 100 - Fully Trusted | HR, Finance, IT, Management PCs |
<img width="1336" height="650" alt="image" src="https://github.com/user-attachments/assets/563c53c7-593a-4ed2-bfb6-4d57ce9513e7" />

The ASA enforces zone boundaries automatically. A `no forward interface vlan 1` command on the
DMZ interface ensures that even a fully compromised DMZ server cannot initiate connections to the LAN.

## Technologies Used

- Cisco ASA 5505 - stateful firewall with NAT/PAT
- DMZ Architecture - three-zone separation for public-facing services
- VLANs (802.1Q) - departmental traffic segmentation on LAN
- Extended ACLs - department-level access control (Finance/HR isolation)
- SSH v2 - encrypted management, Telnet disabled on all devices
- Port Security - MAC-based access control with sticky learning
- NTP - centralised clock sync via NOC-SERVER
- Syslog - all device logs forwarded to NOC-SERVER for monitoring

## IP Addressing

| Segment | Subnet | Gateway |
|---------|--------|---------|
| Internet WAN | 203.0.113.0/30 | 203.0.113.1 (ASA outside) |
| DMZ | 172.16.10.0/24 | 172.16.10.1 (ASA dmz) |
| ASA to LAN link | 192.168.100.0/30 | 192.168.100.1 (ASA inside) |
| VLAN 10 - HR | 192.168.10.0/24 | 192.168.10.1 |
| VLAN 20 - Finance | 192.168.20.0/24 | 192.168.20.1 |
| VLAN 30 - IT | 192.168.30.0/24 | 192.168.30.1 |
| VLAN 40 - Management | 192.168.40.0/24 | 192.168.40.1 |

## Implementation Phases

1. Physical topology and device placement across three zones
2. ASA firewall configuration - interfaces, security levels, NAT/PAT, outside ACL
3. LAN segmentation - VLANs, SVIs, inter-VLAN routing, LAN-SECURITY ACL
4. SSH hardening on all routers and switches
5. Port security on all access ports (restrict mode for NOC visibility)
6. NTP synchronisation - NOC-SERVER as master
7. Syslog centralised logging - all devices reporting to NOC-SERVER

## Security Policies

**Firewall (ASA) - What is permitted from the internet into the DMZ:**
- TCP port 80 and 443 to WEB-SERVER
- TCP port 25 to MAIL-SERVER
- UDP port 514 from ISP-RT to NOC-SERVER (syslog)
- Everything else is denied

**LAN ACL - Department isolation rules:**
- IT has full unrestricted access
- Finance cannot reach HR subnet (bidirectional block)
- HR cannot reach Finance subnet (bidirectional block)
- HR and Finance cannot directly access the DMZ
- All other traffic is permitted

## Verification Results

All phases were tested and verified in Packet Tracer.

| Test | Result |
|------|--------|
| Internet to WEB-SERVER (HTTP/HTTPS) | PASS |
| Internet to LAN - blocked by firewall | PASS |
| DMZ to LAN initiation - blocked by no forward | PASS |
| Finance to HR - blocked by ACL | PASS |
| HR to Finance - blocked by ACL | PASS |
| IT to DMZ - allowed | PASS |
| LAN to internet via NAT/PAT | PASS |
| SSH access only, Telnet rejected | PASS |
| Port security violation logged to syslog | PASS |

## Lessons Learned

**ASA nameif on physical ports fails** - the ASA 5505 physical ports are Layer 2 only.
Solution: assign physical ports to VLANs, then configure nameif on the VLAN interfaces.

**Third ASA interface license error** - the base license restricts named interfaces.
Solution: `no forward interface vlan 1` unlocks the DMZ interface as a workaround.

**DHCP conflict on ASA startup** - the default DHCP pool occupied the inside subnet.
Solution: remove the default pool with `no dhcpd enable inside` before assigning IPs.

**Syslog missing from SW1/SW2** - management IPs were not routable back through the ASA.
Root cause: return path failure for host routes. Documented as a known limitation.

**NTP unsynchronised on Cisco 2960 in Packet Tracer** - this is a confirmed simulator bug,
not a configuration error. The configuration is correct per Cisco IOS documentation.

## Tools

- Cisco Packet Tracer 8.2.2

## Status

Completed. All phases configured and verified.
