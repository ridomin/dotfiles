#!/bin/bash


# Check for various OS openers. Quit as soon as we find one that works.
for opener in browser-exec xdg-open cmd.exe cygstart "start" open; do
	if command -v $opener >/dev/null 2>&1; then
		if [[ "$opener" == "cmd.exe" ]]; then
			# shellcheck disable=SC2139
			alias open="$opener /c start";
		else
			# shellcheck disable=SC2139
			alias open="$opener";
		fi
		break;
	fi
done

# Linux specific aliases, work on both MacOS and Linux.
pbcopy() {
	stdin=$(</dev/stdin);
	pbcopy="$(which pbcopy)";
	if [[ -n "$pbcopy" ]]; then
		echo "$stdin" | "$pbcopy"
	else
		echo "$stdin" | xclip -selection clipboard
	fi
}
pbpaste() {
	pbpaste="$(which pbpaste)";
	if [[ -n "$pbpaste" ]]; then
		"$pbpaste"
	else
		xclip -selection clipboard
	fi
}

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

# Shortcuts
alias k=kubectl


# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color"
else # OS X `ls`
	colorflag="-G"
fi

# List all files colorized in long format
# shellcheck disable=SC2139
alias l="ls -lhF ${colorflag}"

# List all files colorized in long format, including dot files
# shellcheck disable=SC2139
alias la="ls -lahF ${colorflag}"

# List only directories
# shellcheck disable=SC2139
alias lsd="ls -lhF ${colorflag} | grep --color=never '^d'"

# Always use color output for `ls`
# shellcheck disable=SC2139
alias ls="command ls ${colorflag}"
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

# Always enable colored `grep` output
alias grep='grep --color=auto '

# Enable aliases to be sudo’ed
alias sudo='sudo '


# IP addresses
alias pubip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="sudo ifconfig | grep -Eo 'inet (addr:)?([0-9]*\\.){3}[0-9]*' | grep -Eo '([0-9]*\\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias ips="sudo ifconfig -a | grep -o 'inet6\\? \\(addr:\\)\\?\\s\\?\\(\\(\\([0-9]\\+\\.\\)\\{3\\}[0-9]\\+\\)\\|[a-fA-F0-9:]\\+\\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
	# shellcheck disable=SC2139,SC2140
	alias "$method"="lwp-request -m \"$method\""
done

# untar
alias untar='tar xvf'

# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_ed25519.pub | xclip -selection clipboard | echo '=> Public key copied to pasteboard.'"

# Pipe my private key to my clipboard.
alias prikey="more ~/.ssh/id_ed25519 | xclip -selection clipboard | echo '=> Private key copied to pasteboard.'"

#openssl shortcuts
alias viewcert='openssl x509 -noout -nocert -subject -issuer -fingerprint -dates -in '
alias sha256='openssl x509 -noout -fingerprint -sha256 -inform pem -in '
alias dps-key='az iot dps enrollment-group compute-device-key --eid sas -n rido --rid '