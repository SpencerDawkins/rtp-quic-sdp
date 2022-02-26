TARGETS_DRAFTS := draft-dawkins-rtp-quic-sdp 
TARGETS_TAGS := 
draft-dawkins-rtp-quic-sdp-00.md: draft-dawkins-rtp-quic-sdp.md
	sed -e 's/draft-dawkins-rtp-quic-sdp-latest/draft-dawkins-rtp-quic-sdp-00/g' $< >$@
