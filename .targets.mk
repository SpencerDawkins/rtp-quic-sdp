TARGETS_DRAFTS := draft-dawkins-avtcore-sdp-rtp-quic 
TARGETS_TAGS := draft-dawkins-avtcore-sdp-rtp-quic-00
.INTERMEDIATE: draft-dawkins-avtcore-sdp-rtp-quic-00.md
draft-dawkins-avtcore-sdp-rtp-quic-00.md:
	git show "draft-dawkins-avtcore-sdp-rtp-quic-00:draft-dawkins-avtcore-sdp-rtp-quic.md" | sed -e 's/draft-dawkins-avtcore-sdp-rtp-quic-latest/draft-dawkins-avtcore-sdp-rtp-quic-00/g' >$@
draft-dawkins-avtcore-sdp-rtp-quic-01.md: draft-dawkins-avtcore-sdp-rtp-quic.md
	sed -e 's/draft-dawkins-avtcore-sdp-rtp-quic-latest/draft-dawkins-avtcore-sdp-rtp-quic-01/g' $< >$@
diff-draft-dawkins-avtcore-sdp-rtp-quic.html: draft-dawkins-avtcore-sdp-rtp-quic-00.txt draft-dawkins-avtcore-sdp-rtp-quic-01.txt
	-$(rfcdiff) --html --stdout $^ > $@
