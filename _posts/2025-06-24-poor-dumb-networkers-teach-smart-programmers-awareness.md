---
layout: post
title: Poor Dumb Networkers Teach Smart Programmers Awareness
description: Have you heard of the OSI Model? And can you differ what each layer do besides of the obvious? This is an article about the model, the layers and the shark.
date: 2025-06-24
feature_image: images/2025-06-24-OSI/theshark.png
tags:
    - software
    - cybersec
    - network
author: Benett
---

Have you heard of the OSI Model? And can you differ what each layer do besides of the obvious?
This is an article about the model, the layers and the shark.

## The Model

OSI Model was created to standardize network communication protocols, and use layers to divide different levels of abstraction. The principles used to that were:

-   A layer should be created where a different level of abstraction is needed.
-   Each layer should perform a well-defined function.
-   The function of each layer should be chosen with an eye toward defining internationally standardized protocols.
-   The layer boundaries should be chosen to minimize the information flow across the interfaces.
-   The number of layers should be large enough that distinct functions need not be thrown together in the same layer out of necessary, and small enough that the architecture does not become unwieldy.

The layered approach offers several advantages. By separating networking functions into logical smaller pieces, network problems can more easily be solved through a divide-and-conquer methodology. OSI layers also allow extensibility. New protocols and other network services are generally easier to add to a layered architecture.

## The Layers

{% include image_caption.html imageurl="images/2025-06-24-OSI/osi-model.png" title="OSI Model" caption="Layers Illustration" %}

The seven OSI layers from bottom to top are:

1. Physical: Connects the entity to the transmission media
2. Data Link: Provides error control
3. Network: Routes the information in the network
4. Transport: Provides end to end communication control
5. Session: Handles problems which are not communication issues
6. Presentation: Converts the information
7. Application: Provides different services to the application

But this article isn't about memorizing textbook definitions. It’s about **understanding** — something I struggled with until I met _the shark_.

## The Shark

Enter **Wireshark**, a packet analyzer that helped me _see_ what each OSI layer really does.

When analyzing traffic, I noticed Wireshark breaks packets into sections that roughly correspond to OSI layers. Let’s walk through an example.

{% include image_caption.html imageurl="images/2025-06-24-OSI/packetdetails.png" title="Packet Info" caption="" %}

We can see seven distinct layers to the packet: frame/packet, source MAC, source IP, protocol, protocol errors, application protocol, and application data. Below we will go over the layers in more detail.

### **Layer 1: The Frame (Physical Layer)**

This is where Wireshark shows frame-specific metadata, like the packet number and capture timestamp. It doesn’t show voltages or light pulses, but it gives insight into how the packet was physically transmitted.

{% include image_caption.html imageurl="images/2025-06-24-OSI/OSI-layer1.png" title="Frame" caption="" %}

### **Layer 2: Source MAC (Data Link Layer)**

Shows MAC addresses and Ethernet details. This is the "local" addressing used in LAN communication.

{% include image_caption.html imageurl="images/2025-06-24-OSI/OSI-layer2.png" title="Frame" caption="" %}

### **Layer 3: Source IP (Network Layer)**

Here, you see source and destination IP addresses. This layer is responsible for logical addressing and routing across networks.

{% include image_caption.html imageurl="images/2025-06-24-OSI/OSI-layer3.png" title="Frame" caption="" %}

### **Layer 4: Protocol (Transport Layer)**

This section includes the transport protocol (TCP/UDP), ports, and flags like SYN or ACK.

{% include image_caption.html imageurl="images/2025-06-24-OSI/OSI-layer4.png" title="Frame" caption="" %}

You may also spot **protocol-specific details**, like TCP reassembly, retransmissions, or out-of-order packets — still part of this layer.

{% include image_caption.html imageurl="images/2025-06-24-OSI/OSI-layer4-2.png" title="Frame" caption="" %}

### **Layer 5–7: Sessions, Presentation & Application?**

Here’s where things blur.

In Wireshark, **Layer 5 (Session)** and **Layer 6 (Presentation)** don’t have clear separation. That’s because modern protocols often handle session control and presentation formatting within the **application-layer protocols** themselves.

Instead, Wireshark groups layers 5–7 under what it calls **Application Layer protocols**, such as HTTP, FTP, or SMB.

### **Layer 7: Application Protocol**

Wireshark shows you protocol-specific details — headers, commands, status codes — everything the user-level application needs.

{% include image_caption.html imageurl="images/2025-06-24-OSI/OSI-layer5.png" title="Frame" caption="" %}

### **Application Data**

This is the payload — raw data being transferred, like an HTML page, file content, or form data.

{% include image_caption.html imageurl="images/2025-06-24-OSI/OSI-layer5-2.png" title="Frame" caption="" %}

---

## So, Where Are Layers 5 and 6?

You're not missing them — they're just **not visibly separated** in Wireshark.

-   **Session Layer (Layer 5)** handles connections and sessions between systems, but many modern protocols (like HTTP/2) bundle session handling into the application protocol itself.
-   **Presentation Layer (Layer 6)** takes care of formatting, encryption, and compression — again, these are usually built into the application layer (e.g., TLS for encryption, GZIP for compression).

So, while OSI offers a **conceptual model**, **Wireshark shows a practical view** — how protocols are implemented in real-world traffic, often blending layers 5–7 together.

As someone who often needs visual examples to better understand things, the shark really helped me with this one. And in case you often forget the layer names, here is something to remember:

**P**oor **D**umb **N**etworkers **T**each **S**mart **P**rogrammers **A**wareness
