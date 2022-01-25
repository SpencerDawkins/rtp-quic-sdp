# SDP Offer/Answer for RTP using QUIC as Transport

This repository is used for a draft defining SDP usage for RTP with QUIC as its underlying transport protocol. The draft is draft-dawkins-avtcore-rtp-quic-sdp.

* [Editor's Copy](https://SpencerDawkins.github.io/sdp-rtp-quic/#go.draft-dawkins-avtcore-sdp-rtp-quic.html)
* [Datatracker Page](https://datatracker.ietf.org/doc/draft-dawkins-avtcore-sdp-rtp-quic)
* [Individual Draft](https://datatracker.ietf.org/doc/html/draft-dawkins-avtcore-sdp-rtp-quic)
* [Compare Editor's Copy to Individual Draft](https://SpencerDawkins.github.io/sdp-rtp-quic/#go.draft-dawkins-avtcore-sdp-rtp-quic.diff)

Issues and pull requests are welcomed here. 

From the Abstract:

This document describes these new SDP "proto" attribute values: "QUIC", "QUIC/RTP/SAVP", "QUIC/RTP/AVPF", and "QUIC/RTP/SAVPF", and describes how SDP Offer/Answer can be used to set up an RTP connection using QUIC as a transport protocol.

These proto values are necessary to allow the use of QUIC as an underlying transport protocol for applications such as SIP and WebRTC that commonly use SDP as a session signaling protocol to set up RTP connections. 