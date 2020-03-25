# https://docs.bazel.build/versions/master/skylark/build-style.html
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾ 

# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .*/BUILD %{
    set-option buffer filetype bazel_build
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook -group bazel-highlight global WinSetOption filetype=bazel_build %{
    require-module bazel

    add-highlighter window/bazel_build ref bazel_build
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/bazel_build }
}

provide-module bazel %{

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter shared/bazel_build regions
add-highlighter shared/bazel_build/code default-region group
add-highlighter shared/bazel_build/comment region '#' '$' fill comment
add-highlighter shared/bazel_build/string region '"' '"' fill string

add-highlighter shared/bazel_build/code/function regex ([\d\w_]+)\( 1:function
add-highlighter shared/bazel_build/code/operator regex ([=+,()[\]]) 0:operator
add-highlighter shared/bazel_build/code/variable regex ([\w_][\w\d_]*)\s*= 1:variable
add-highlighter shared/bazel_build/code/keyword regex (True|False) 1:keyword

}
