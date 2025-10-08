---
layout: post
title: If I Had 8 Hours
description: If I had 8 hours to invade a system, I would spend 6 doing reconnaissance
date: 2025-10-08
feature_image: images/2025-10-08-8-hours/Abraham_Lincoln.jpg
tags:
    - pentest
    - network
    - cybersec
author: benett
---

> “If I had eight hours to chop down a tree, I’d spend six sharpening my axe.”  
> — Abraham Lincoln

In penetration testing, the same principle applies.  
Success rarely comes from rushing the “cut”; it comes from meticulous preparation.

 <!--more--> 

## The Sharpening: Reconnaissance First

{% include image_caption.html imageurl="images/2025-10-08-8-hours/Binoculars.jpg" title="Binoculars" caption="Binoculars" %}

Before a single exploit is launched, a pentester’s most valuable investment is in reconnaissance.  
Mapping the target surface, understanding the technologies in use, cataloging exposed services, and gathering OSINT (Open-Source Intelligence) are the modern equivalents of honing an axe’s edge.

**Why reconnaissance matters:**

-   **Reduces noise:** Less brute-force guessing, more precise targeting.
-   **Reveals weak points early:** Misconfigured ports, forgotten endpoints, outdated software.
-   **Saves time later:** Exploits become smoother when you know where to strike.

## The Six Hours

Taking the analogy to the next step, let’s suppose we only have 8 hours to get the job done (excluding documentation writing and post-exploitation).

A typical timeline might look like this for an eight-hour engagement:

-   **Hour 1–2: Passive Recon**  
    Use tools like `whois`, `nslookup`, search engines, Shodan, and certificate-transparency logs to uncover domains, subdomains, and public assets — all without touching the target.

-   **Hour 3–4: Active Recon**  
    Carefully probe with `nmap`, `gobuster`, and similar tools to enumerate open ports, directories, services, and banner versions — always staying within the scope defined by the client.

-   **Hour 5: Vulnerability Mapping**  
    Correlate findings with CVE databases, look for common misconfigurations, privilege-escalation paths, or leaked credentials.

-   **Hour 6: Strategy Building**  
    Decide which attack paths are most viable, draft the exploitation plan, and prepare payloads or scripts.

By the end of this phase, your axe is ready to cut any ~~application~~ tree.

## The Cut: Exploitation

With a clear plan, the final two hours become significantly more impactful.  
Sometimes we get a clean cut and the objective is easily achieved; other times we realize the mission might require more than an axe, perhaps a chainsaw or more information than we initially had.

## Post-Exploitation

{% include image_caption.html imageurl="images/2025-10-08-8-hours/transporte-de-madeira.jpg" title="Madeira" caption="Madeira" %}

Ironically, the activity that’s often the hardest isn’t the cut or the preparation — it’s the logistics of carrying the wood out of the forest.  
Dropping the analogy: documentation and demonstrating data access or privilege escalation are often the toughest parts.  
Enumerating CVEs alone has little to no impact on the intended audience of the report. The ability to translate what we saw and understood during the process to professionals in other roles is one of the most important, yet often overlooked aspects of the job.

## Lessons From the Woods

Cutting corners on preparation often leads to wasted time, noisy scans, and incomplete findings.  
Sharpening your approach through thorough reconnaissance not only improves technical results but also builds client trust: you demonstrate professionalism and discipline.

So, next time you plan a pentest, remember Lincoln’s wisdom: the sharper the axe, the cleaner the cut.

---
