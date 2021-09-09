TARGETS_DRAFTS := draft-dawkins-sdp-rtp-quic 
TARGETS_TAGS := 
draft-dawkins-sdp-rtp-quic-00.md: draft-dawkins-sdp-rtp-quic.md
	sed -e 's/draft-dawkins-sdp-rtp-quic-latest/draft-dawkins-sdp-rtp-quic-00/g' $< >$@
