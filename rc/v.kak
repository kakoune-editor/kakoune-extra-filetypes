##
## v.kak by Conscat
##

# https://vlang.io
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .+\.(v|vv|vsh) %{
    set-option buffer filetype v
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook global WinSetOption filetype=v %{
    require-module v
    set-option window static_words %opt{v_static_words}
    add-highlighter window/v ref v
}

hook global WinSetOption filetype=(?!v).* %{
    remove-highlighter window/v
}

decl str comment_line
hook global BufSetOption filetype=v %{
    set-option buffer comment_line '//'
}

provide-module v %§

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter shared/v regions
add-highlighter shared/v/code default-region group

add-highlighter shared/v/back_string region '`' '`' fill string
add-highlighter shared/v/double_string region '"' (?<!\\)(\\\\)*" fill string
add-highlighter shared/v/single_string region "'" (?<!\\)(\\\\)*' fill string
add-highlighter shared/v/comment region -recurse /\* /\* \*/ fill comment
add-highlighter shared/v/comment_line region '//' $ fill comment

add-highlighter shared/v/code/ regex %{-?([0-9]*\.(?!0[xX]))?\b([0-9_]+|0[xX][0-9a-fA-F]+)\.?([eE][+-]?[0-9]+)?\.*\b|(none|true|false)\b} 0:value

add-highlighter shared/v/code/ regex (<|>|=|\+|-|\*|/|%|~|&|\|||\^|!|\?|:=) 0:operator

evaluate-commands %sh{
	keywords='if as asm assert atomic break const continue else embed enum fn for go import in interface is lock match module mut or pub return rlock select shared sizeof static struct type typeof union __offsetof free unsafe strlen strncmp malloc goto defer'
	attributes='deprecated inline heap manualfree live direct_array_access typedef windows_stdcall console json: raw required export if keep_args_alive unsafe'
	comptime='if else for'
	types='chan err i8 u8 byte i16 u16 int u32 i64 u64 f32 f64 ptr voidptr size_t map rune string bool'
	functions='print println eprint eprintln exit panic print_backtrace dump'

	join() { sep=$2; eval set -- $1; IFS="$sep"; echo "$*"; }

	# Add the language's grammar to the static completion list
	printf %s\\n "declare-option str-list v_static_words $(join "${keywords} ${attributes} ${comptime} ${types} ${functions}" ' ')"

	# Highlight keywords
	printf %s "
		add-highlighter shared/v/code/ regex (\b((?<![@])($(join "${keywords}" '|')))\b|(\[($(join "${attributes}" '|')([^\]|(^\n)]*))\])|([\$]($(join "${comptime}" '|')))(?:(?![\s+|\{|\}]))*) 0:keyword
		add-highlighter shared/v/code/ regex \b($(join "${types}" '|'))\b 0:type
		add-highlighter shared/v/code/ regex \b($(join "${functions}" '|'))\b 0:builtin
	"
}

§
