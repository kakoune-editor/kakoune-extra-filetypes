# https://git.sr.ht/~sircmpwn/scdoc
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .+\.scd %{
	set-option buffer filetype scdoc
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook -group scdoc-highlight global WinSetOption filetype=scdoc %{
	require-module scdoc

	add-highlighter window/scdoc ref scdoc
	hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/scdoc}
}


provide-module scdoc %{

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter shared/scdoc group

add-highlighter shared/scdoc/ regex '(?<!# )((?<!\\)|\\\\)\*(\n?[^\n])*?((?<!\\)|\\\\)\*' 0:+b
add-highlighter shared/scdoc/ regex '(?<!# )((?<!\\)|\\\\)\b_((\n?[^\n])*?)((?<!\\)|\\\\)_\b' 2:+u
# Let’s break this down:
# (?<!# ) Tretead literally in headings
# ((?<!\\)|\\\\) Treated literally after \ but not after \\
# (\n?[^\n]) Line break is allowed but not a paragraph break

# TODO: foo \\_bar_ is correctly highlighted but
#		foo\\_bar_ is wrongly highlighted

add-highlighter shared/scdoc/ regex '^; [^\n]*' 0:comment
add-highlighter shared/scdoc/ regex '^##? [^\n]*' 0:header
add-highlighter shared/scdoc/ regex '\\.' 0:meta

add-highlighter shared/scdoc/block regions
add-highlighter shared/scdoc/block/literal region -match-capture (^\t?```$) (^\t?```$) fill meta
}
