# http://www.clearsilver.net/
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .+\.cst %{
    set-option buffer filetype clearsilver
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook global WinSetOption filetype=clearsilver %{
    require-module html
    require-module clearsilver

    add-highlighter window/clearsilver ref clearsilver
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/clearsilver }
}

provide-module clearsilver %{

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter shared/clearsilver regions
add-highlighter shared/clearsilver/code default-region group
add-highlighter shared/clearsilver/inline_cs region '<\?cs\b' '\?>' regions
add-highlighter shared/clearsilver/inline_cs/code default-region group

add-highlighter shared/clearsilver/code/ ref html

add-highlighter shared/clearsilver/inline_cs/string_double region '"' (?<!\\)(\\\\)*" fill string
add-highlighter shared/clearsilver/inline_cs/string_simple region "'" "'" fill string

add-highlighter shared/clearsilver/inline_cs/code/ regex '(<\?cs\b)|(\?>)' 0:module
add-highlighter shared/clearsilver/inline_cs/code/ regex \b[+-]?(0x\w+|#?\d+)\b 0:value
add-highlighter shared/clearsilver/inline_cs/code/ regex \b(subcount|name|first|last|abs|max|min|string.slice|string.find|string.length|_)\( 1:builtin
add-highlighter shared/clearsilver/inline_cs/code/ regex \b(var|evar|lvar|include|linclude|set|name|if|else|elif|alt|each|loop|with|def|call): 1:keyword
add-highlighter shared/clearsilver/inline_cs/code/ regex /(if|alt)\b 0:keyword

}
