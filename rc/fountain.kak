# https://fountain.io/
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .+\.fountain %{
    set-option buffer filetype fountain
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook -group fountain-highlight global WinSetOption filetype=fountain %{
    require-module fountain

    add-highlighter window/fountain ref fountain
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/fountain }
}

provide-module fountain %{

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter shared/fountain group

add-highlighter shared/fountain/ regex ^([A-Z][\w\h_-]+:)[^\n]+ 1:mono
add-highlighter shared/fountain/ regex ^\h*={3,}\n 0:bullet
add-highlighter shared/fountain/ regex ^\h*(?<lyric_op>~)([^\n]+) lyric_op:bullet 2:block
add-highlighter shared/fountain/ regex ^\h*(?<center_op_open>>)[^\n]+?(?<center_op_close><)$ center_op_open:bullet center_op_close:bullet

add-highlighter shared/fountain/ regex (?<!\*)(\*([^\s*]|([^\s*](\n?[^\n*])*[^\s*]))\*)(?!\*) 1:+i
add-highlighter shared/fountain/ regex (?<!\*)(\*\*([^\s*]|([^\s*](\n?[^\n*])*[^\s*]))\*\*)(?!\*) 1:+b
add-highlighter shared/fountain/ regex (?<!_)(_([^\s_]|([^\s_](\n?[^\n_])*[^\s_]))_)(?!_) 1:+u
add-highlighter shared/fountain/ regex (?<!\*)(\*\*\*([^\s*]|([^\s*](\n?[^\n*])*[^\s*]))\*\*\*)(?!\*) 1:+ib

add-highlighter shared/fountain/ regex ^\n\h*(?<scene_heading>((?i)(INT|EXT|EST|INT\./EXT|INT/EXT|I/E)\b)[^\n]*?)(?<scene_number>#[^#\n]+#)?\n(?=\n) scene_heading:title scene_number:value
add-highlighter shared/fountain/ regex ^\n\h*(?<scene_heading_op>\.)(?<scene_heading>[^\n]*?)(?<scene_number>#[^#\n]+#)?\n(?=\n) scene_heading_op:bullet scene_heading:title scene_number:value
# FIXME: doesn't highlight the dual dialog sign as a bullet
add-highlighter shared/fountain/ regex ^\n\h*(?<character>[A-Z][^a-z\n]+?|(?<character_op>@)[^\n]+?)(\h*(?<character_ext>\([^\n]*?\))|(?<dual_dialog>^))?\n(?=[^\n]) character_op:bullet character:header character_ext:+i dual_dialog:bullet
add-highlighter shared/fountain/ regex ^\n\h*(?<action_op>!)[A-Z] action_op:bullet
add-highlighter shared/fountain/ regex ^\n\h*(?<transition>([A-Z\h]+:|FADE\h+(IN|OUT|TO\h+BLACK)))\n(?=\n) transition:link
add-highlighter shared/fountain/ regex ^\n\h*(?<transition_op>>)\h*(?<transition>[^\n]+?[^<\n])\h*\n(?=\n) transition_op:bullet transition:link
add-highlighter shared/fountain/ regex ^\h*\([^\n]+?\) 0:+i

add-highlighter shared/fountain/ regex \[\[.+?\]\] 0:comment
add-highlighter shared/fountain/ regex /\*.+?\*/ 0:comment
add-highlighter shared/fountain/ regex ^\h*(=[^=\n][^\n]*) 1:comment

}
