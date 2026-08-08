# hello kody. 
#
#
#
#  i  t     i s    t  i   m   e      t  o      t   r    a  n  s   c   e  n  d  . .  . . .
#========================================================================
# init
#========================================================================

# # pywal (cat ~/.cache/wal/sequences &) pfetch
fastfetch --logo small
#rich "$(gh api user -q .login) | switch with ghs" -p -a heavy

# Github - Display Current
# echo "$(gh api user -q .login) | switch with ghs"

#========================================================================
# Music Player Daemon (mpd)
#========================================================================
alias mpd_start="pgrep -x mpd > /dev/null || mpd ~/.config/mpd/mpd/mpd.conf &> /dev/null"
mpd_start

#========================================================================
# Fuzzy File Search (fzf)
#========================================================================
eval "$(fzf --zsh)"

# ruby env
if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
  export PATH=/opt/homebrew/opt/ruby/bin:$PATH
  export PATH=`gem environment gemdir`/bin:$PATH
fi


# # gh cli 
# eval "$(~/.local/bin/mise activate zsh)"
# eval "$(mise activate zsh)"
# eval "$(gh copilot alias -- zsh)"

# starship prompt
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# macOS
if [[ "$(uname)" == "Darwin" ]]; then
  # zsh
  source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
  source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
  source ~/.python3/bin/activate
fi

#========================================================================
# alias
#========================================================================

# general
alias conf="cd ~/Developer/kody/dotfiles/config/; nvim ."
alias h="history"
alias cd="z"
alias ci="zi"
alias ls='lsd -lah --color=always --group-directories-first'
alias ll="ls"
alias src="source ~/.zshrc"
alias nvim="nvim"
alias p="pfetch"
alias pp="neofetch"
alias tt="smassh"
alias xwal="/opt/xcwal/; python3 xcwal.py"
alias bonsai="cbonsai --seed 119 --live"
alias fixaudio="sudo killall coreaudiod; killall mpd; mpd_start"
alias ip-address="ipconfig getifaddr en0"
alias xmacros="defaults write com.apple.dt.Xcode IDEPackageEnablePrebuilts YES"

# apps
alias gg="lazygit"
alias wals="cd /Users/kodydeda/Library/Mobile\ Documents/com~apple~CloudDocs/Photos/Wallpapers; r"
alias notes="cd /Users/kodydeda/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/iCloud; nvim ."
alias ff="clear && fastfetch --logo small"
alias mm="~/.cargo/bin/rmpc"
alias speed="speedtest-cli --simple"
alias music="rmpc"
alias mus="rmpc"

# Download Music

# alias youtube-dl="youtube-dl"
alias youtube-music-dl="ytmdl"
alias tidal-dl="cd; tidal-dl"
alias tidal-dl-converter="~/Developer/kody/dotfiles/scripts/tidal-dl-converter"


# git
alias ghs="gh auth switch"

## cd alias
alias dev="cd ~/Developer; r"
alias kody="cd ~/Developer/kody; r"
alias pr="cd ~/Developer/pocketradar; r"
alias site="cd /Users/kodydeda/Developer/kody/web/nextjs-kodydeda; r"
alias sw="cd ~/Developer/kody/swift; r"
alias web="cd ~/Developer/kody/web; r"

## scripts
alias sss="~/Developer/kody/dotfiles/scripts/sss"
alias fpr="~/Developer/kody/dotfiles/scripts/fpr"
alias xcm="~/Developer/kody/dotfiles/scripts/xcm"
alias icons="sudo -H ~/Developer/kody/dotfiles/scripts/icons"

#========================================================================
# zoxide
#========================================================================
eval "$(zoxide init zsh)"

#========================================================================
# yazi
#========================================================================

export EDITOR="nvim"

function r() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}


#========================================================================
# youtube-dl
#========================================================================

youtube-dl() {
  yt-dlp -f bestaudio \
    --extract-audio --audio-format m4a --audio-quality 0 \
    --embed-metadata --embed-thumbnail --convert-thumbnails jpg \
    -o "$HOME/Music/kodydeda/Music/Downloads/youtube-dl/%(playlist_title,NA)s/%(track_number,00)02d - %(title)s.%(ext)s" "$1"
}

# Youtube Download Example:
# Download 
# yt-dlp --download-sections "*18:31-18:48" "https://www.youtube.com/watch?v=l84U8QFKIF0"

#========================================================================
# tmux
#========================================================================

if [ -z "$TMUX" ]; then
  tmux attach || tmux new-session
fi

#========================================================================
# powerline
#========================================================================

eval "$(starship init zsh)"
export SPACESHIP_PROMPT_ASYNC=0
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/lib/ruby/gems/3.4.0/bin:$PATH"



