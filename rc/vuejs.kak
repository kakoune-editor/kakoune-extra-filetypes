# https://vue-loader.vuejs.org/
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .+\.vue %{
    set-option buffer filetype vuejs
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

define-command -hidden -params 3 vuejs-detect-lang %{
    try %{
        execute-keys -draft <percent> s "^<%arg{1}\b.+?\blang=""%arg{2}""" <ret>
        require-module %arg{3}
    }
}

hook global WinSetOption filetype=vuejs %{
    require-module html
    require-module css
    require-module javascript

    vuejs-detect-lang "template" "pug" "pug"
    vuejs-detect-lang "script" "ts" "typescript"
    vuejs-detect-lang "style" "scss" "scss"
    vuejs-detect-lang "style" "stylus" "css"

    require-module vuejs

    add-highlighter window/vuejs ref vuejs
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/vuejs }
}

provide-module vuejs %{

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter shared/vuejs regions

add-highlighter shared/vuejs/template_vue region '^<template\b' '^</template>$' ref html
add-highlighter shared/vuejs/template_pug region '^<template\b.+?\blang="pug"' '^</template>$' ref pug

add-highlighter shared/vuejs/script_javascript region '^<script\b' '^</script>$' ref javascript
add-highlighter shared/vuejs/script_typescript region '^<script\b.+?\blang="ts">$' '^</script>$' ref typescript

add-highlighter shared/vuejs/style_css region '^<style\b' '^</style>$' ref css
add-highlighter shared/vuejs/style_scss region '^<style\b.+?\blang="scss"' '^</style>$' ref scss
add-highlighter shared/vuejs/style_stylus region '^<style\b.+?\blang="stylus"' '^</style>$' ref css

}
