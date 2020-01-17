# http://bottlepy.org/docs/stable/stpl.html
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
# NOTE: Bottle.py intends STPL to be used over HTML markup,
#       so the following code assumes exactly that, despite
#       it being usable over virtually any language

# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .+\.s?tpl %{
    set-option buffer filetype simple-template
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook global WinSetOption filetype=simple-template %{
    require-module html
    require-module python
    require-module simple-template

    add-highlighter window/simple-template ref simple-template
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/simple-template }
}

provide-module simple-template %{

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter shared/simple-template regions
add-highlighter shared/simple-template/ default-region ref html

add-highlighter shared/simple-template/inline_python region '^\h*%' $ group
add-highlighter shared/simple-template/inline_python/ ref python
add-highlighter shared/simple-template/inline_python/ regex ^\h*(%)\h*(?:\b(?:(end)\b|(include|rebase|defined|get|setdefault)\h*\())? 1:meta 2:keyword 3:builtin

add-highlighter shared/simple-template/block_python region '^\h*<%' '%>\h*$' group
add-highlighter shared/simple-template/block_python/ ref python
add-highlighter shared/simple-template/block_python/ regex ^\h*(<%)|(%>)\h*$ 1:meta 2:meta

add-highlighter shared/simple-template/expression region '\{\{' '\}\}' group
add-highlighter shared/simple-template/expression/ ref python
add-highlighter shared/simple-template/expression/ regex \{\{|\}\} 0:value

}
