# draft-dawkins-avtcore-sdp-rtp-quic
# draft-dawkins-avtcore-sdp-rtp-quic-00
versioned:
	@mkdir -p $@
.INTERMEDIATE: versioned/draft-dawkins-avtcore-sdp-rtp-quic-00.md
.SECONDARY: versioned/draft-dawkins-avtcore-sdp-rtp-quic-00.xml
versioned/draft-dawkins-avtcore-sdp-rtp-quic-00.md: | versioned
	git show "draft-dawkins-avtcore-sdp-rtp-quic-00:draft-dawkins-avtcore-sdp-rtp-quic.md" | sed -e 's/draft-dawkins-avtcore-sdp-rtp-quic-latest/draft-dawkins-avtcore-sdp-rtp-quic-00/g' >$@
.INTERMEDIATE: versioned/draft-dawkins-avtcore-sdp-rtp-quic-01.md
versioned/draft-dawkins-avtcore-sdp-rtp-quic-01.md: draft-dawkins-avtcore-sdp-rtp-quic.md | versioned
	sed -e 's/draft-dawkins-avtcore-sdp-rtp-quic-latest/draft-dawkins-avtcore-sdp-rtp-quic-01/g' $< >$@
diff-draft-dawkins-avtcore-sdp-rtp-quic.html: versioned/draft-dawkins-avtcore-sdp-rtp-quic-00.txt versioned/draft-dawkins-avtcore-sdp-rtp-quic-01.txt
	-$(iddiff) $^ > $@
