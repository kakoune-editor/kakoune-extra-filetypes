# http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# Text that overflows the following limits will be highlighted:
#   - title (first line of the commit text): 50 characters
#   - body (lines that are not the title, or part of the diff): 72 characters

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook -group git-commit-highlight global WinSetOption filetype=git-commit %{
    require-module git-commit-overflow

    add-highlighter window/git-commit-overflow ref git-commit-overflow
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/git-commit-overflow }
}

provide-module git-commit-overflow %{

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter shared/git-commit-overflow group

# Commit message/body
add-highlighter shared/git-commit-overflow/ regex ^\h*[^#@+-][^\n]{71}(?<overflow>[^\n]+) overflow:Error
# Commit title/summary
add-highlighter shared/git-commit-overflow/ regex \A\n*[^\n]{50}(?<overflow>[^\n]+) overflow:Error
# Line following the title/summary, should be empty
add-highlighter shared/git-commit-overflow/ regex \A[^\n]*\n([^\n]+) 1:Error

}
