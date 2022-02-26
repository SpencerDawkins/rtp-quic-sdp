---
title: SDP Offer/Answer for RTP using QUIC as Transport
abbrev: SDP O/A for RTP over QUIC
docname: draft-dawkins-avtcore-sdp-rtp-quic-latest
date:
category: std

ipr: trust200902
area: applications
workgroup: AVTCORE Working Group
keyword: Internet-Draft QUIC RTP SDP

stand_alone: yes
pi: [toc, sortrefs, symrefs]

author:
 -
  ins: S. Dawkins
  name: Spencer Dawkins
  organization: Tencent America LLC
  country: United States of America
  email: spencerdawkins.ietf@gmail.com

normative:

  RFC2119:
  RFC3261:
  RFC3264:
  RFC3550:
  RFC3551:
  RFC3711:
  RFC4585:
  RFC5761:
  RFC5124:
  RFC7667:
  RFC7850:
  RFC8174:
  RFC8298:
  RFC8825:
  RFC8843:
  RFC8866:
  RFC8999:
  RFC9000:
  RFC9001:
  SDP-parameters:
    target: https://www.iana.org/assignments/sdp-parameters/sdp-parameters.xhtml#sdp-parameters-2
    title: "SDP Parameters - Proto"
    date: September 2021
  SDP-attribute-name:
    target: https://www.iana.org/assignments/sdp-parameters/sdp-parameters.xhtml#sdp-att-field
    title: "SDP Parameters - attribute-name"
    date: September 2021
  MOQ:
    target: https://www.ietf.org/mailman/listinfo/moq
    title: "Moq -- Media over QUIC"

informative:

  I-D.ietf-avtcore-rtp-vvc:
  I-D.engelbart-rtp-over-quic:
  I-D.huitema-quic-ts:
  RFC4145:

--- abstract

This document describes these new SDP "proto" attribute values, "QUIC", "QUIC/RTP/AVP", and "QUIC/RTP/AVPF", and describes how SDP Offer/Answer can be used to set up an RTP connection using QUIC as a transport protocol.

These proto values are necessary to allow the use of QUIC as an underlying transport protocol for applications such as SIP and WebRTC that commonly use SDP as a session signaling protocol to set up RTP connections.

--- middle

# Introduction {#intro}

This document describes these new SDP "proto" attribute values, "QUIC", "QUIC/RTP/AVP", and "QUIC/RTP/AVPF", and describes how SDP Offer/Answer ({{RFC3264}}) can be used to set up an RTP ({{RFC3550}}) connection using QUIC ({{RFC9000}} and related specifications) as a transport protocol.

These proto values are necessary to allow the use of QUIC as an underlying transport protocol for applications such as SIP ({{RFC3261}}) and WebRTC ({{RFC8825}}) that commonly use SDP as a session signaling protocol to set up RTP connections.

## Notes for Readers {#readernotes}

(Note to RFC Editor - if this document ever reaches you, please remove this section)

This document is intended for publication as a standards-track RFC in the IETF stream, but has not been adopted by any IETF working group, and does not carry any special status within the IETF.

## Terminology

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "NOT RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in BCP 14 ({{RFC2119}}) ({{RFC8174}}) when, and only when, they appear in all capitals, as shown here.

##Scope of this document {#scope}

This document focuses on the IANA registration and description of the RTP sessions using SDP Offer/Answer, as would be the case for many current RTP applications in common use, such as SIP ({{RFC3261}}) and WebRTC ({{RFC8825}}).

This document is intended as complementary to drafts such as {{I-D.engelbart-rtp-over-quic}}, which largely focus on RTP/RTCP encapsulation in QUIC, so that the SDP experts can focus on SDP offer/answer aspects, and the RTP experts can focus on RTP/RTCP encapsulation aspects.

## Contribution and Discussion Venues for this draft. {#contrib}

(Note to RFC Editor - if this document ever reaches you, please remove this section)

With the concurrence of the AVTCORE and MMUSIC working group co-chairs, this document should be discussed in the AVTCORE working group, in the same venue where RTP over QUIC proposals are being discussed. When proposals for RTP over SIP have stablized in AVTCORE, this document will be sent to the MMUSIC working group for review by SDP experts, but SDP-specific comments are welcomed at any time.

Readers are also invited to open issues and send pull requests with contributed text for this document in the GitHub repository at https://github.com/SpencerDawkins/sdp-rtp-quic. The direct link to the list of issues is https://github.com/SpencerDawkins/sdp-rtp-quic/issues.

##Assumptions for this document {#assume}

This document assumes that for RTP-over-QUIC, it is useful to register these AVP profiles using QUIC, in order to allow existing SIP and RTCWEB RTP applications to migrate more easily to QUIC:

 * RTP/AVP ("RTP Profile for Audio and Video Conferences with Minimal Control (RTP/AVP)"), as defined in {{RFC3551}}.
 * RTP/AVPF ("Extended RTP Profile for Real-time Transport Control Protocol (RTCP)-Based Feedback (RTP/AVPF)"), as defined in {{RFC4585}}.

This document assumes that any implementation adding support for RTP-over-QUIC could reasonably also add support for BUNDLE ({{RFC8843}}) and "rtcp-mux" ({{RFC5761}}), so these capabiilities are not mentioned further in this document.

## Rationale on the Choice of AVP Profiles in an RTP Over QUIC Context

An RTP implementation that uses QUIC as its underlying transport protocol may choose to rely only on RTCP for feedback. For this reason, the QUIC/RTP/AVPF profile is defined in this specification, to provide the best RTCP feedback possible to RTP senders. 

An RTP implementation that uses QUIC as its underlying transport protocol may choose to rely information available at the QUIC level for feedback. For this reason, the QUIC/RTP/AVP profile is defined in this specification, to minimize the RTP-level overhead for RTP senders. 

An RTP implementation that uses QUIC as its underlying transport protocol will always send an RTP stream that is encrypted between the two QUIC endpoints. 

It is undesireable to also use SRTP payload encryption, because this adds double encryption overhead and increases the payload size by adding a second HMAC to the payload. 

For this reason, the potential QUIC/RTP/SAVP and QUIC/RTP/SAVPF profiles are not defined in this specification. 

## Open Questions {#open-questions}

The current contents of {{idents-atts}} and {{iana}} would allow an existing RTP/RTCP implementation to make a relatively straightforward transition from "RTP over UDP" to "RTP over QUIC datagrams over UDP", and likewise from "RTCP over UDP" to "RTCP over QUIC datagrams over UDP".

Although it is still early days for RTP over QUIC, things may not be that straightforward. Just limiting our attention to various proposals for "RTP over QUIC" that have already been discussed on the Media Over QUIC IETF mailing list {{MOQ}} and in various IETF side meetings, we have seen

* a desire to make use of QUIC connection migration in case of path failure between two endpoints
* a desire to replace RTP Round Trip Time (RTT) measurement with something like a proposed QUIC extension for timestamps ({{I-D.huitema-quic-ts}}) that could be used to measure one-way delays
* a desire to make use of QUIC streams, potentially with QUIC datagrams in the same QUIC connection
* a desire to decouple the RTP state machine and the QUIC state machine, which currently assume they are solely responsible for managing sending rates, without any knowledge of what the other plans to do
* a desire to select a media-focused congestion control mechanism such as "Self-Clocked Rate Adaptation for Multimedia", or SCReAM ({{RFC8298}}), that can be included in QUIC implementations
* a desire to use RTP over QUIC in peer-to-peer applications, which likely would require extensions to the QUIC protocol for NAT traversal, at a bare minimum

Changes to the SDP signaling in {{idents-atts}} and {{iana}} may be (and likely would be) needed in order to support any of these desires (or other desires that may surface in the future).

#Identifiers and Attributes {#idents-atts}

As much as possible, these are reused from other specifications, with references to the original definitions.

##Protocol Identifiers

### The QUIC proto {#quic}

The 'QUIC' protocol identifier is similar to the 'UDP' and 'TCP' protocol identifiers in that it only describes the transport protocol, and not the upper-layer protocol.

An 'm' line that specifies 'QUIC' MUST further qualify the application-layer protocol using an fmt identifier, such as "QUIC/RTP/AVPF".  Media described using an 'm' line containing the 'QUIC' protocol identifier are carried using QUIC ({{RFC9000}}).

The following is an update to the ABNF for an 'm' line, as specified by {{RFC8866}}, that defines a new value for the QUIC protocol.

~~~~~~
   media-field =         %s"m" "=" media SP port \["/" integer\]
                             SP proto 1*(SP fmt) CRLF

   m= line parameter        parameter value(s)
   ------------------------------------------------------------------
   <media>:                 (unchanged from {{RFC8866}})
   <proto>:                 'QUIC'
   <port>:                  UDP port number
   <fmt>:                   (unchanged from {{RFC8866}})

~~~~~~

### The QUIC/RTP/AVP proto {#avp}

The following is an update to the ABNF for an 'm' line, as specified by {{RFC8866}}, that defines a new value for the QUIC/RTP/AVP protocol.

~~~~~~
   media-field =         %s"m" "=" media SP port \["/" integer\]
                             SP proto 1*(SP fmt) CRLF

   m= line parameter        parameter value(s)
   ------------------------------------------------------------------
   <media>:                 (unchanged from {{RFC8866}})
   <proto>:                 'QUIC/RTP/AVP'
   <port>:                  UDP port number
   <fmt>:                   (unchanged from {{RFC8866}})

~~~~~~

### The QUIC/RTP/AVPF proto {#avpf}

The following is an update to the ABNF for an 'm' line, as specified by {{RFC8866}}, that defines a new value for the QUIC/RTP/AVPF protocol.

~~~~~~
   media-field =         %s"m" "=" media SP port \["/" integer\]
                             SP proto 1*(SP fmt) CRLF

   m= line parameter        parameter value(s)
   ------------------------------------------------------------------
   <media>:                 (unchanged from {{RFC8866}})
   <proto>:                 'QUIC/RTP/AVPF'
   <port>:                  UDP port number
   <fmt>:                   (unchanged from {{RFC8866}})

~~~~~~

##A QUIC/RTP/AVPF Offer

A complete example of an SDP offer using QUIC/RTP/AVPF might look like:

|SDP line | Notes |
|v=0 |Same as {{RFC8866}}|
|o=jdoe 3724394400 3724394405 IN IP4 198.51.100.1 |Same as {{RFC8866}}|
|s=Call to John Smith |Same as {{RFC8866}}|
|i=SDP Offer #1 |Same as {{RFC8866}}|
|u=http://www.jdoe.example.com/home.html |Same as {{RFC8866}}|
|e=Jane Doe <jane@jdoe.example.com> |Same as {{RFC8866}}|
|p=+1 617 555-6011 |Same as {{RFC8866}}|
|c=IN IP4 198.51.100.1 |Same as {{RFC8866}}|
|t=0 0 |Same as {{RFC8866}}|
|m=audio 49170 RTP/AVP 0 |Same as {{RFC8866}}|
|m=audio 49180 RTP/AVP 0 |Same as {{RFC8866}}|
|m=video 51372 QUIC/RTP/AVPF 99 |QUIC transport|
|a=setup:passive|will wait for QUIC handshake (setup attribute from {{RFC4145}})|
|a=connection:new|don't want to reuse an existing QUIC connection (connection attribute from {{RFC4145}})|
|c=IN IP6 2001:db8::2 |Same as {{RFC8866}}|
|a=rtpmap:99 h266/90000 |H.266 VVC codec {{I-D.ietf-avtcore-rtp-vvc}}|

This example is largely based on an example appearing in {{RFC8866}}, Section 5, but is using QUIC/RTP/AVPF to support a newer codec.

Because QUIC uses connections for both streams and datagrams, we are reusing two session- and media-level SDP attributes from {{SDP-attribute-name}} that were defined in {{RFC4145}} for use with TCP: setup and connection.

This example SDP offer might be included in a SIP Invite.

# IANA Considerations {#iana}

This document registers these protocols in the proto registry ({{SDP-parameters}}).

* QUIC ({{quic}})
* QUIC/RTP/AVP ({{avp}})
* QUIC/RTP/AVPF ({{avpf}})

## Proto Registrations

IANA is requested to add these protocols to the Session Description Protocol (SDP) Parameters proto registry ({{SDP-parameters}}).

| Type | SDP Name | Reference |
| proto | QUIC | RFCXXXX |
| proto | QUIC/RTP/AVP | RFCXXXX |
| proto | QUIC/RTP/AVPF | RFCXXXX |

**Note to the RFC Editor**

Please replace "RFCXXXX" with the assigned RFC number, when that is available, and remove this note.

# Security Considerations

Security considerations for the QUIC protocol are described in the corresponding section in {{RFC9000}}.

Security considerations for the TLS handshake used to secure QUIC are described in {{RFC9001}}.

Security considerations for SDP are described in the corresponding section in {{RFC8866}}.

Security considerations for SDP offer/answer are described in the cooresponding section in {{RFC3264}}.

# Acknowledgments

My appreciation to the authors of {{RFC4145}}, which served as a model for the initial structure of this document.

Thanks to these folks for helping to improve this draft:

* Colin Perkins
* Justin Uberi

(Your name also could appear here. Please comment and contribute, as per {{contrib}}).
