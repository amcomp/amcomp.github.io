---
layout: post
title: "Basics of DNS"
date: 2024-08-27 00:00:00 +0300
description: Basics of DNS # Add post description (optional)
img: pexels-pixabay-163064.jpg # Add image post (optional)
---

## What is DNS?

The Domain Name System (DNS) is a critical system in our modern network. It can be compared to a contact list or phonebook, in that a DNS server (depending on what level it is in the system) knows where a site or URL can be located. Understanding DNS at least to a fundamental level, is critical knowledge for systems administrators, DevOPs engineers, network engineers, and more positions. Simply put, DNS is the service, that converts IP addresses into human readable words. For example, you can open your browser and type Google.com, and you will get the ever-familiar website front page. You can also type 142.250.190.110 and still get the same site. 

## WHY DNS?

The internet is a dynamic landscape, with IP addresses being constantly changed. DNS enables the users of the internet to be able to search for websites by name, instead of IP address, making the process of browsing much easier. Having to manually keep track of IP addresses would be cumbersome and inefficient.   

## What is a domain?

Simply put, a domain is the alphanumeric text that is mapped to an IP address. google.com is a domain, because there are IP addresses associated to the text. “google” is known as a 2LD or second Layer Domain. “.com” is the TLD or Top Layer Domain, which is discussed later. 

## The four types of DNS Servers

### Recursive Resolver

This is the first step when you search for a website. A system administrator may be familiar with this Level of DNS, as many often configure their endpoints to use Google’s 8.8.8.8, Cloudflare’s 1.1.1.1, or even their own DNS server inside of Windows server. At this level, the recursive DNS gets the most traffic, so the server will be caching the Ip addresses and resolved names to help speed up the process, and often it all ends here as well. With big servers like 8.8.8.8 or 1.1.1.1, they are handling huge traffic, and caching a lot, so they are usually up to date with accurate resolutions.  If the Information is not cached, this server will send the request on to the root nameserver. Then Finally the authoritative nameserver.

### Root Nameserver

Acts like a directory of directories. There are many Top-Level Domains (TLD) (We know them as .com .org .gov and so on). The recursive resolver hands the request to the Root Nameserver which then decides which Top-Level Domain to hand the request too. There are 13 main root nameservers, maintained by the Internet Corporation for Assigned Names and Numbers (ICANN) 

### Top Level Domain

A Top-Level Domain (TLD) contains information for all the sites with a matching extension (Like .com), Once a DNS query get to this point, and the TLD identifies the query, it will be sent to the authoritative nameserver. 

### Authoritative nameserver

The final step in the DNS process. If the URL exists, and is configured correctly there is an authoritative nameserver, that contains detailed information about it. The recursive DNS server can gather and return to your computer with the data you requested. If the domain cannot be found, an error is returned.

## DNS Records

The data that the servers are passing around, can be described as “Records” and there are a few different kinds. These records are known as 

- A record and AAAA record
    - A records hold an IPV4 address (Like Google.com’s 142.250.191.238 address)
    - AAAA records hold an IPV6 address (Google.com’s 2607:f8b0:4009:801::200e)
- Mail exchanger record (MX record)
    - This record would direct to a mail server.
- Canonical name record (CNAME record)
    - Also known as an alias.
        - example.com will have the same result as www.example.com
- Name server record (NS record)
    - Indicates what server is the Authoritative Server for a domain.
- Pointer record (PTR record)
    - Record holds the name of the domain in text, the opposite of an A record.
- Text record (TXT record)
Stores administrative information on a record are often used for email security, with protocols like the Sender Policy Framework (SPF) or DomainKeys Identified Mail (DKIM).

# **Resources**

[Cloudflare DNS Articles](https://www.cloudflare.com/learning/dns/what-is-dns/)

[IBM DNS Articles](https://www.ibm.com/topics/dns)