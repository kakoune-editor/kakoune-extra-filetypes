# https://docs.makotemplates.org/en/latest/syntax.html
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .+\.mako %{
    set-option buffer filetype mako
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook global WinSetOption filetype=mako %{
    require-module html
    require-module python
    require-module mako

    add-highlighter window/mako ref mako
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/mako }
}

provide-module mako %{

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter shared/mako regions
add-highlighter shared/mako/code default-region group
add-highlighter shared/mako/code/ ref html

add-highlighter shared/mako/inline_python region '^\h*%(?!%)' $ group
add-highlighter shared/mako/inline_python/ ref python
add-highlighter shared/mako/inline_python/ regex ^\h*(%)\h*(?:(end(?:if|for)))? 1:meta 2:keyword

add-highlighter shared/mako/block_python region '^\h*<%$' '^%>\h*$' group
add-highlighter shared/mako/block_python/ ref python
add-highlighter shared/mako/block_python/ regex ^\h*(<%)|(%>)\h*$ 1:meta 2:meta

add-highlighter shared/mako/code/block_tags regex (</?%)(block|call|def|nsname|text)\b(>)? 1:meta 2:builtin 3:meta
add-highlighter shared/mako/code/inline_tags regex (<%)(include|inherit|namespace|page)\b 1:meta 2:builtin

add-highlighter shared/mako/expression region '\$\{' '\}' group
add-highlighter shared/mako/expression/ ref python
add-highlighter shared/mako/expression/ regex \$\{|\} 0:value

add-highlighter shared/mako/block_comment region ^<%doc> </%doc>$ group
add-highlighter shared/mako/block_comment/ fill documentation
add-highlighter shared/mako/code/inline_comment regex ^\h*##[^\n]* 0:comment

}
