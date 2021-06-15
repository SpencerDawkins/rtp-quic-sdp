---
title: SDP Offer/Answer for RTP over QUIC
abbrev: SDP O/A for RTP over QUIC
docname: draft-dawkins-rtp-quic-sdp-latest
date:
category: info

ipr: trust200902
area: transport
workgroup: QUIC Working Group
keyword: Internet-Draft

coding: us-ascii
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
  RFC3264:
  RFC8174:
  RFC8866:
  RFC9000:
  RFC9001:

informative:
   
  I-D.ietf-avtcore-rtp-vvc:
  RFC4145:
  
--- abstract

This document describes two new SDP "proto" attribute values, "QUIC/RTP/AVPF", and describes how SDP Offer/Answer can be used to set up an RTP connection using QUIC as a transport protocol. 

--- middle

# Introduction {#intro}

This document describes a new SDP "proto" attribute value, "QUIC/RTP/AVPF", and describes how SDP Offer/Answer can be used to set up an RTP connection using QUIC as a transport protocol. 

This would be necessary for the use of QUIC as an underlying transport protocol for RTP, in addition to 

## Notes for Readers {#readernotes}

This document is an informational Internet-Draft, not adopted by any IETF working group, and does not carry any special status within the IETF.

## Terminology

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "NOT RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in BCP 14 {{RFC2119}} {{RFC8174}} when, and only when, they appear in all capitals, as shown here.

## Contribution and Discussion Venues for this draft. {#contrib}

(Note to RFC Editor - if this document ever reaches you, please remove this section)

This document is under development in the Github repository at https://github.com/SpencerDawkins/rtp-quic-sdp.

Readers are invited to open issues and send pull requests with contributed text for this document, or to send them to the author via email.

##Background for this document {#background}

In discussions in the QUIC working group and AVTCORE working group, various proposals for "RTP over QUIC" have been submitted, but these have not targeted the use of SDP Offer/Answer, as would be common for RTP applications in common use (for example, SIP).

#To-Do

Need to figure out

   * full offer/answer for "open"
   * QUIC connection open/close/migration
   * define framing for RTP in QUIC
   * Whether to support QUIC streams, QUIC datagrams, or both (suggested answer: if you're happy with QUIC streams, you may be using HTTP/3 instead of SDP anyway, so only QUIC datagrams)
   * Whether to support RTP/RTCP multiplexing
   * Whether to support multiple RTP media in a single QUIC connection (I THINK this works, just need to make sure whether it requires bundling)
   * requirement for ICE and NAT traversal
   * definition of the fmt namespace for QUIC in IANA considerations
   * what else is needed?

#Identifiers and Attributes

As much as possible, these are reused from other specifications, with references to the original definitions.

##Protocol Identifiers

###QUIC as an addition to the proto registry

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

The 'QUIC' protocol identifier is similar to the 'UDP' and 'TCP' protocol identifiers in that it only describes the transport protocol, and not the upper-layer protocol.  An 'm' line that specifies 'QUIC' MUST further qualify the application-layer protocol using an fmt identifier, such as "QUIC/RTP/AVPF".  Media described using an 'm' line containing the 'QUIC' protocol identifier are carried using QUIC {{RFC9000}}.

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

  * QUESTION: what protos should we register in https://www.iana.org/assignments/sdp-parameters/sdp-parameters.xhtml#sdp-parameters-2? "QUIC/RTP/AVPF" seems like a good start. Is there any reason to register "QUIC/RTP", or "QUIC/RTP/SAVPF"? I note that anyone who doesn't need immediate feedback (RTP/AVPF) probably doesn't need QUIC at all, and QUIC already provides encryption beyond what RTP/SAVP can provide (because all of RTP and RCTP are encrypted in the QUIC payload). 

##A QUIC/RTP/AVPF Offer

A complete example of an SDP offer using QUIC/RTP/AVPF would be: 

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
|a=setup:passive|will wait for QUIC handshake|
|a=connection:new|don't want to reuse an existing QUIC connection|
|c=IN IP6 2001:db8::2 |Same as {{RFC8866}}|
|a=rtpmap:99 h266/90000 |H.266 VVC codec {{I-D.ietf-avtcore-rtp-vvc}}|

(this example is taken from {{RFC8866}}, Section 5, but is using QUIC/RTP/AVPF to support a newer codec)

This example might be included in a SIP Invite. 

##An UDP/QUIC/RTP Answer



# IANA Considerations

We would be registering QUIC and QUIC/RTP/AVPF in the proto registry, in https://www.iana.org/assignments/sdp-parameters/sdp-parameters.xhtml#sdp-parameters-2. Do we need to define any other RTP profile variants? 

We are reusing two session- and media-level SDP attributes that were defined {{RFC4145}}: setup and connection. I don't think we need to say anything about this in the IANA considerations, but am not sure. 

# Security Considerations

Security considerations for the QUIC protocol are described in the corresponding section in {{RFC9000}}.

Security considerations for the TLS handshake used to secure QUIC are described in {{RFC9001}}.

Security considerations for SDP are described in the corresponding section in {{RFC8866}}, 

Security considerations for offer/answer are described in the cooresponding section in {{RFC3264}}.

Furthermore, when using DTLS over UDP, the generic offer/answer considerations defined in **RFC8842** MUST be followed.

The generic security considerations associated with SDP attributes are defined in {{RFC3264}}. While the attributes defined in this specification do not reveal information about the content of individual RTP media streams BFCP-controlled media streams, they do reveal which media streams will be BFCP controlled.

# Acknowledgments

My appreciation to the authors of {{RFC4145}}, which served as a model for the structure of this document. 

Your name could appear here. Please comment and contribute, as per {{contrib}}. 