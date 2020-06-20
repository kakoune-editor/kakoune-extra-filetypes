# Syntax highlighting for p4
# p4.org
hook global BufCreate .*\.p4 %{
    set-option buffer filetype p4
}

# Regions definition are the same between c++ and objective-c
evaluate-commands %sh{
    ft="p4"
    maybe_at=''

    printf %s\\n '
            add-highlighter shared/FT regions
            add-highlighter shared/FT/code default-region group
            add-highlighter shared/FT/string region %{MAYBEAT(?<!QUOTE)(?<!QUOTE\\)"} %{(?<!\\)(?:\\\\)*"} fill string
            add-highlighter shared/FT/raw_string region %{R"([^(]*)\(} %{\)([^")]*)"} fill string
            add-highlighter shared/FT/comment region /\* \*/ group
            add-highlighter shared/FT/line_comment region // $ fill comment
            add-highlighter shared/FT/disabled region -recurse "#\h*if(?:def)?" ^\h*?#\h*if\h+(?:0|FALSE)\b "#\h*(?:else|elif|endif)" fill rgb:666666
            add-highlighter shared/FT/macro region %{^\h*?\K#} %{(?<!\\)\n} group

            add-highlighter shared/FT/macro/ fill meta
            add-highlighter shared/FT/macro/ regex ^\h*#include\h+(\S*) 1:module
        ' | sed -e "s/FT/${ft}/g; s/QUOTE/'/g; s/MAYBEAT/${maybe_at}/;"
}


add-highlighter shared/p4/code/ regex %{\b(lpm|exact|ternary|range|true|false|null)\b} 0:value
add-highlighter shared/p4/code/ regex %{\b(bit|bool|int|varbit|void|error)\b} 0:type
add-highlighter shared/p4/code/ regex "\b(tuple|extern|enum|action|apply|control|default|exit|header|header_union|match_kind|package|parser|state|struct|switch|size|table|transition|typedef|verify|if|else)\b" 0:keyword
add-highlighter shared/p4/code/ regex "\b(key|actions||default_action|entries|implementation|const|in|out|inout)\b" 0:attribute
add-highlighter shared/p4/code/ regex "\b(update_checksum|(is|set)Valid)\b" 0:function
add-highlighter shared/p4/code/ regex "(apply)\(" 1:function
add-highlighter shared/p4/code/ regex "@(name|tableonly|defaultonly|globalname|atomic|hidden)" 0:meta
add-highlighter shared/p4/code/ regex %{\b(_|NoError|PacketTooShort|NoMatch|StackOutOfBounds|OverwritingHeader|HeaderTooShort|ParserTiimeout)\b} 0:builtin

add-highlighter shared/p4/comment/ fill comment
add-highlighter shared/p4/comment/ regex "(?<!\w)@\w+\b" 0:green

# integer literals
evaluate-commands %sh{ 
    prefix="(\\\d+[ws])?"
    printf %s\\n '
        add-highlighter shared/p4/code/ regex %{\bPREFIX[0-9][0-9_]*\b} 0:value  
        add-highlighter shared/p4/code/ regex %{\bPREFIX0[Xx][0-9a-fA-F]+\b} 0:value
        add-highlighter shared/p4/code/ regex %{\bPREFIX0[dD][0-9_]+\b} 0:value
        add-highlighter shared/p4/code/ regex %{\bPREFIX0[oO][0-7_]+\b} 0:value
        add-highlighter shared/p4/code/ regex %{\bPREFIX0[bB][01_]+\b} 0:value
        ' | sed -e "s/PREFIX/${prefix}/g"
}

hook -group p4-highlight global WinSetOption filetype=p4 %{
    add-highlighter window/ ref p4
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/p4 }
}

