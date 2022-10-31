# GIT bash integration
if [[ -e /usr/lib/git-core/git-sh-prompt ]]; then

        source /usr/lib/git-core/git-sh-prompt

        export GIT_PS1_SHOWCOLORHINTS=true
        export GIT_PS1_SHOWDIRTYSTATE=true
        export GIT_PS1_SHOWUNTRACKEDFILES=true
        export GIT_PS1_SHOWUPSTREAM="auto"
        # PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'

        # use existing PS1 settings
        PROMPT_COMMAND=$(sed -r 's|^(.+)(\\\$\s*)$|__git_ps1 "\1" "\2"|' <<< $PS1)

fi
