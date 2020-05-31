##
## gemini.kak by lenormf
##

# https://gemini.circumlunar.space/docs/spec-spec.txt
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .+\.(gmi|gemini) %{
    set-option buffer filetype gemini
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook global WinSetOption filetype=gemini %{
    require-module gemini
    add-highlighter window/gemini ref gemini
}
hook global WinSetOption filetype=(?!gemini).* %{
    remove-highlighter window/gemini
}

provide-module gemini %[

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter shared/gemini regions

add-highlighter shared/gemini/preformatted region ^``` ^```(?S).* group
add-highlighter shared/gemini/preformatted/ fill mono
add-highlighter shared/gemini/preformatted/not_rendered regex ^```(?S)(.+) 1:Error

add-highlighter shared/gemini/text default-region group
add-highlighter shared/gemini/text/url regex ^(=>)\h*(?<url>\S+)(\h+(?S)(?<url_name>.+))? 1:link url:link url_name:comment
add-highlighter shared/gemini/text/header regex ^(#{1,3}\h*(?S).+) 0:header
add-highlighter shared/gemini/text/list_item regex ^(?<bullet>\*)\h*(?<item>(?S).+) bullet:bullet item:list

]
