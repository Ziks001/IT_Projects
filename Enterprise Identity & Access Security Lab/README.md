# Enterprise Identity & Access Security Lab
### Zero-Trust Identity Architecture: Microsoft Entra ID

**Platform:** Microsoft Entra ID (Microsoft 365 E5 Developer) ·

---

## Project Overview

This project simulates a real-world zero-trust identity architecture for a fictional organization, built entirely inside a live Microsoft Entra ID tenant. Every design decision follows the principle that **access is never permanent, never unconditional, and never unmonitored**.

### What Problem Does This Solve?

Most account compromises don't happen because of sophisticated exploits. They happen because of permanent admin access, missing MFA, legacy authentication protocols, and access that nobody ever re-checks once granted. This lab builds the four-layer defense that addresses each of these directly:

| Layer | Technology | Solves |
|---|---|---|
| **Enforcement** | Conditional Access | Context-aware access decisions (MFA, device, location, legacy auth) |
| **Privilege** | Privileged Identity Management (PIM) | Eliminates standing/permanent admin access |
| **Detection** | Identity Protection | Automated response to risky sign-ins and compromised accounts |
| **Governance** | Access Reviews | Periodic recertification — access doesn't accumulate forever |

---

## Technologies Used

`Microsoft Entra ID P1/P2` · `Conditional Access` · `Privileged Identity Management (PIM)` · `Identity Protection` · `Access Reviews` · `Microsoft Graph (Entra Admin Center)`

---

## 1. Identity Architecture & Org Design

A small but realistic org structure was built to mirror department-based, group-driven access — never assigning permissions directly to individual users.

| User | Department | Notes |
|---|---|---|
| Sarah Chen | Finance | Standard user |
| James Okafor | IT Admin | PIM-eligible for User Administrator |
| Amara Bello | HR | Standard user |
| David Martins | Sales | Standard user |
| Test BreakDoor | Emergency Access | Permanent Global Admin, excluded from all Conditional Access policies |

**Security Groups** (all access assigned via group, never directly to user):
`SG-IT-Admins` · `SG-Finance` · `SG-HR` · `SG-Sales` · `SG-CA-Exclude-Breakglass`

> **Breakglass account design:** A dedicated emergency-access account with permanent (non-PIM) Global Administrator rights, explicitly excluded from every Conditional Access policy. This is standard production practice — it guarantees tenant access even if a CA policy is misconfigured or PIM itself fails.

Screenshot: All users list
<img width="1280" height="461" alt="image" src="https://github.com/user-attachments/assets/35561e66-77c4-4ff5-98ab-90259f2ff8d6" />

Screenshot: All groups list
<img width="1280" height="152" alt="image" src="https://github.com/user-attachments/assets/632fcdc4-56a4-4c34-9b4a-2ae8ed10cc2c" />


## 2. Conditional Access: Context-Aware Enforcement

Six Conditional Access policies were designed, each targeting a specific real-world risk. All policies were built and validated in **Report-only mode** before enforcement, the same staged-rollout discipline used in production environments to avoid accidental lockouts.

| Policy | Targets | Control | Why It Matters |
|---|---|---|---|
| **CA01** - Require MFA | All users (scoped to Teams + SharePoint) | Require MFA | Blocks the majority of credential-based account compromise |
| **CA02** - Block Legacy Authentication | All users, all resources | Block access | Legacy protocols (POP3/IMAP/basic SMTP) cannot support MFA, a common compromise vector |
| **CA03** - Admin Device Compliance | Global Admin, User Admin, Security Admin roles | Require compliant/hybrid-joined device | Highest-value accounts restricted to trusted, managed devices |
| **CA04** - Location Restriction | All users (scoped to Teams + SharePoint) | Block outside approved country | Demonstrates location-based zero-trust |
| **CA05** - User Risk Response | All users | Require password change + MFA | Migrated from deprecated standalone risk policy (see note below) |
| **CA06** - Sign-in Risk Response | All users | Require MFA on medium+ risk | Real-time response to suspicious sign-in signals |

### Design Decision: Resource Scoping

Rather than targeting **"All resources"** broadly on lockout-risk policies (MFA, location), I deliberately scoped CA01 and CA04 to specific applications (Teams, SharePoint). This mirrors how production CA rollouts work, pilot against a narrow app set, observe in Report-only, then expand. Policies with inherently low lockout risk (legacy auth blocking, role-scoped admin policies) were left at "All resources" since their blast radius is already contained by their other conditions.

### Platform Note: Risk Policy Migration

During implementation, Microsoft's legacy standalone "User risk policy" / "Sign-in risk policy" pages (under Identity Protection) returned a deprecation notice:


CA05 and CA06 were built as native Conditional Access policies using the **User risk** and **Sign-in risk** conditions directly, rather than the deprecated standalone policy type, reflecting the platform's current direction.

Screenshot: Full Conditional Access policy list (all 6 policies, Report-only state)
<img width="1280" height="702" alt="image" src="https://github.com/user-attachments/assets/c6be7151-1efb-4c9c-824c-7c39bf51ac7c" />

Screenshot: CA01 resource scoping (Teams + SharePoint selected)
<img width="925" height="840" alt="image" src="https://github.com/user-attachments/assets/c92b4b2a-81ce-4626-a121-9e299a287eb5" />

Screenshot: CA02 legacy auth client app conditions
<img width="1043" height="827" alt="image" src="https://github.com/user-attachments/assets/91583e5a-5bfa-42e8-ab77-5544ca2d4168" />

Screenshot: CA03 admin role targeting
<img width="921" height="612" alt="image" src="https://github.com/user-attachments/assets/22e14249-0149-4c14-86ff-5a01058e6496" />

Screenshot: CA05/CA06 risk-based conditions inside Conditional Access
<img width="868" height="855" alt="image" src="https://github.com/user-attachments/assets/11ed5827-1273-478d-84ef-a5b62a3b2144" />
<img width="1041" height="733" alt="image" src="https://github.com/user-attachments/assets/f642dacb-46b3-4b7f-bd9c-2a512f3ac8df" />

---

## 3. Privileged Identity Management (PIM): Just-In-Time Access

Standing admin access was eliminated. James (IT Admin) was converted from a direct role assignment to a **PIM-eligible** assignment for User Administrator, requiring active justification, approval, and time-bound activation for every use.

**Role activation settings configured:**
- Maximum activation duration: 4 hours
- Justification required: check
- Approval required: check (approver: tenant Global Admin)
- MFA required on activation: check (stacks with Conditional Access MFA policy; defense in depth)

**Workflow tested end-to-end:**
1. James requests activation via **PIM → My roles → Activate**, provides justification, completes MFA
2. Request enters **pending** state
3. Admin reviews and approves via **PIM → Approve requests**
4. Role becomes **Active** for the defined time window, then automatically expires

Screenshot: PIM eligible assignment configuration (James, User Administrator, Eligible)
<img width="1280" height="581" alt="image" src="https://github.com/user-attachments/assets/a1af411a-d412-49a1-92c5-2a0d1c378843" />


---

## 4. Identity Protection: Automated Risk Response

Identity Protection policies were configured to automatically respond to Microsoft's risk-detection signals, rather than relying on manual log review.

| Policy | Risk Type | Threshold | Response |
|---|---|---|---|
| User risk policy | Account-level risk (e.g. leaked credentials) | High | Require password change |
| Sign-in risk policy | Per-sign-in risk (e.g. impossible travel, anonymous IP) | Medium and above | Require MFA |

**Design rationale:** Sign-in risk is intentionally more sensitive (catches more, responds lighter with MFA) since individual sign-in signals carry more false-positive risk. User risk is intentionally stricter (catches less, responds heavier with a forced password change) since a higher confidence threshold is needed before a disruptive action.

> **Honest note on live detections:** in a low-traffic trial tenant, real-time risk detections are sparse by nature, this is expected and was documented rather than artificially manufactured. The monitoring pipeline and response policies were verified as correctly configured and active.

Screenshots: Identity Protection Overview dashboard
<img width="868" height="855" alt="image" src="https://github.com/user-attachments/assets/2e061ec2-1369-433c-9357-9bef767b8818" />

<img width="1041" height="733" alt="image" src="https://github.com/user-attachments/assets/4cbf3d8b-ce23-4df7-9cc7-3b72f8d397a4" />


---

## 5. Verification & Testing

| Test | Method | Result |
|---|---|---|
| CA policy evaluation against real sign-ins | Sign-in logs → Report-only tab | Policies correctly evaluated live traffic |
| Policy impact analysis | Conditional Access → Insights and reporting | Confirmed before enforcing live |
| Staged rollout | CA02 and CA03 switched Report-only → On after validation | No lockouts, enforcement active |
| PIM eligible → active workflow | Manual activation + approval cycle | Full lifecycle confirmed working |
| Overall posture | Microsoft Identity Secure Score | Measurable improvement vs. baseline |

---

## 6. Key Lessons & Design Decisions

| Decision | Reasoning |
|---|---|
| Group-based access only, never direct-to-user | Mirrors production RBAC hygiene, access is auditable and revocable by removing group membership |
| Dedicated breakglass account excluded from all CA policies | Guarantees recovery access if any policy is ever misconfigured |
| Report-only before enforcement, on every policy | Prevents accidental lockouts, the single most common real-world CA mistake |
| Scoped "risky" policies to specific apps rather than "All resources" | Reduces blast radius while still proving the enforcement logic works |
| PIM with mandatory approval + justification + MFA | Defense-in-depth, even a stolen, MFA-bypassed session still can't silently escalate to admin |
| Migrated risk policies to Conditional Access rather than the deprecated standalone blade | Demonstrates awareness of platform changes, the standalone risk policy UI is being retired October 2026 |
| Staged enforcement, low-risk policies first | Matches real change-management discipline rather than enabling everything simultaneously |

---

## Skills Demonstrated

**Identity & Access Management**: Conditional Access policy design, context-aware access control, legacy authentication elimination, device compliance enforcement

**Privileged Access Management**: PIM eligible vs. active assignment design, approval workflows, time-bound privilege, justification requirements

**Threat Detection & Response**: Identity Protection risk policies, risk-based conditional access, automated remediation design

**Governance & Compliance**: Access review design, recertification workflows, audit-ready access lifecycle management

**Change Management**: Report-only validation, staged policy enforcement, platform deprecation awareness

---



> Raw Conditional Access policy JSON exports were intentionally excluded from this public repository. JSON exports nest tenant and object identifiers across multiple levels, making them harder to fully sanitize than a screenshot. All published screenshots have sensitive identifiers (tenant ID, object GUIDs, real user details) blurred or cropped before upload.

---

*This project was built in a live Microsoft Entra ID tenant (Microsoft 365 E5 Developer) as part of a Microsoft identity security portfolio. It demonstrates practical, hands-on competence in zero-trust architecture, privileged access management, and identity governance, directly applicable to Identity & Access Engineer, Security Analyst, and IT Administrator roles.*
