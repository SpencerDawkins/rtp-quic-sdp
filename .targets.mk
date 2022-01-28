TARGETS_DRAFTS := draft-dawkins-avtcore-sdp-rtp-quic 
TARGETS_TAGS := 
draft-dawkins-avtcore-sdp-rtp-quic-00.md: draft-dawkins-avtcore-sdp-rtp-quic.md
	sed -e 's/draft-dawkins-avtcore-sdp-rtp-quic-latest/draft-dawkins-avtcore-sdp-rtp-quic-00/g' $< >$@
