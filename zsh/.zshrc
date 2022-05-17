export DOTFILES=$HOME/.dotfiles
export ANDROID_SDK=$HOME/Android/Sdk
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export GPG_TTY=$(tty)

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Volta

# Load Antigen
source $HOME/antigen.zsh

# Load Antigen configurations
antigen init $HOME/.antigenrc

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source $HOME/.zsh_profile
export PATH=$PATH:~/.composer/vendor/bin
export PATH="$HOME/Library/Python/3.9/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.local/share/neovim/bin"
export PATH="$PATH:$HOME/.local/share/flutter/bin"
export PATH="$PATH:$ANDROID_SDK/platform-tools"
export PATH="$PATH:$ANDROID_SDK/cmdline-tools/latest/bin"
export PATH="$PATH:$ANDROID_SDK/emulator"
export PATH="$PATH:$ANDROID_SDK/tools"
export PATH="$PATH:$JAVA_HOME/bin"
export PATH="$PATH:/Users/Erik.Simon/Library/Application Support/neovim/bin"

# To customize prompt, run `p10k configure` or edit ~/.dotfiles/zsh/.p10k.zsh.
[[ ! -f ~/.dotfiles/zsh/.p10k.zsh ]] || source ~/.dotfiles/zsh/.p10k.zsh

alias luamake=/home/stx/language-servers/lua-language-server/3rd/luamake/luamake
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
