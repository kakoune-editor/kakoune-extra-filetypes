##
## django-template.kak by lenormf
##

# https://docs.djangoproject.com/en/stable/ref/templates/language/
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# Detection
# ‾‾‾‾‾‾‾‾‾

hook global WinSetOption filetype=html %[
    try %[
        execute-keys -draft \%s \{%|\{\{ <ret>
        require-module jinja
        add-highlighter window/jinja ref jinja
        hook -always -once window WinSetOption filetype=(?!html).* 'remove-highlighter window/jinja'
    ]
]
