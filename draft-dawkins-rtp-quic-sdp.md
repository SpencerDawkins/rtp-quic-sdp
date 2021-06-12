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
  email: spencerdawkins.ietf@gmail.com

normative:

  RFC3264:
  RFC8866:
  RFC9000:
  RFC9001:

informative:
   
--- abstract

Abstract goes here.

--- middle

# Introduction {#intro}

## Notes for Readers {#readernotes}

This document is an informational Internet-Draft, not adopted by any IETF working group, and does not carry any special status within the IETF.

## Terminology

## Contribution and Discussion Venues for this draft. {#contrib}

(Note to RFC Editor - if this document ever reaches you, please remove this section)

This document is under development in the Github repository at https://github.com/SpencerDawkins/rtp-quic-sdp.

Readers are invited to open issues and send pull requests with contributed text for this document, or to send them to the author via email.

#Background for this document {#background}

In discussions in the QUIC working group and AVTCORE working group, various proposals have been submitted, but these have not targeted the use of SDP Offer/Answer, as would be common for RTP applications in common use (for example, SIP).

This document describes a new SDP "proto" attribute value, "UDP/QUIC/RTP", and describes how SDP Offer/Answer can be used to set up an RTP connection using QUIC as a transport protocol. 

#Examples

##An UDP/QUIC/RTP Offer

~~~~~~
    m=video 49170 RTP/AVP 98
    a=rtpmap:98 H266/90000
    a=fmtp:98 profile-id=1; sprop-vps=<video parameter sets data>
~~~~~~

##An UDP/QUIC/RTP Answer



# IANA Considerations

This document does not make any request to IANA.

# Security Considerations

Security considerations for the QUIC protocol are described in the corresponding section in {{RFC9000}}.

Security considerations for the TLS handshake used to secure QUIC are described in {{RFC9001}}.

Security considerations for SDP are described in the corresponding section in {{RFC8866}}, 

Security considerations for offer/answer are described in the cooresponding section in {{RFC3264}}.

Furthermore, when using DTLS over UDP, the generic offer/answer considerations defined in **RFC8842** MUST be followed.

The generic security considerations associated with SDP attributes are defined in {{RFC3264}}. While the attributes defined in this specification do not reveal information about the content of individual RTP media streams BFCP-controlled media streams, they do reveal which media streams will be BFCP controlled.

# Acknowledgments

Your name could appear here. Please comment and contribute, as per {{contrib}}. 