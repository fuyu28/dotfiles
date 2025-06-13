#### 1. PATH設定 ####
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.rbenv/bin:$HOME/.local/share/mise/installs/node/24.2.0/bin:/usr/local/sbin:/usr/local/bin:$PATH"

#### 2. Zinit起動 ####
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing ZDHARMA-CONTINUUM Zinit…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
unalias zi 2>/dev/null
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

#### 3. 補完系（高速化） ####
autoload -Uz compinit
compinit -C

#### 4. zinitプラグイン管理 ####
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light Aloxaf/fzf-tab
zinit light ajeetdsouza/zoxide
eval "$(zoxide init zsh)"

#### 5. starshipプロンプト ####
eval "$(starship init zsh)"

#### 6. 履歴設定 ####
export HISTSIZE=1000
export HISTFILESIZE=2000
setopt hist_ignore_dups share_history

#### 7. nvm ####
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

#### 8. rbenv ####
eval "$(rbenv init -)"

#### 9. cargo環境変数 ####
source "$HOME/.cargo/env"

#### 10. mise ####
eval "$(mise activate zsh)"

#### 11. 基本alias ####
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias cat='bat'
alias ls='eza --icons'
alias ll='eza -l --icons --git'
alias la='eza -la --icons --git'

alias ..='cd ..'
alias ...='cd ../..'

alias ip='ip -c a'
alias ports='ss -tulwn'
alias ping='ping -c 5'

alias gs='git status'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias lg='lazygit'

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history | tail -n1 | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//\'')"'

#### 12. fzf履歴検索 (Ctrl+R強化) ####
if [[ $- == *i* ]]; then
  fzf-history-widget() {
    # -l=リスト表示, -n=番号をつけない, 1=最古の履歴から
    local selection
    selection=$(fc -ln 1 | fzf --tac +s +m --query "$LBUFFER") || return
    BUFFER=$selection
    CURSOR=${#BUFFER}
    zle reset-prompt
  }
  zle -N fzf-history-widget
  bindkey '^R' fzf-history-widget
fi

#### 13. 実用関数系 ####
# 爆速cd (fzf + fd)
unalias cdf 2>/dev/null
cdf() {
  cd "$(fd -H --type d . | fzf)"
}

# ripgrep検索 + fzf + batプレビュー
rgfz() {
  rg --color=always --line-number "$1" | \
    fzf --ansi --delimiter : --preview 'bat --style=numbers --color=always {1} --line-range {2}:'
}

# zoxideのfzf拡張版
alias zf='zoxide query -l | fzf --tac --preview "eza -l --color=always {}" | xargs -r cd'

# fzf + ghq
function ghq-fzf() {
  local src=$(ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf
bindkey '^g' ghq-fzf
