# http://www.mutt.org/
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook global BufCreate .*/mutt-.+ %{
    set-option buffer filetype mail
}
