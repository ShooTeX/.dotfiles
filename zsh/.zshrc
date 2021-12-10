export DOTFILES=$HOME/.dotfiles

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
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export PATH=$PATH:~/.composer/vendor/bin
export PATH="$HOME/Library/Python/3.9/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin
export PATH="$PATH:$HOME/go/bin"

# To customize prompt, run `p10k configure` or edit ~/.dotfiles/zsh/.p10k.zsh.
[[ ! -f ~/.dotfiles/zsh/.p10k.zsh ]] || source ~/.dotfiles/zsh/.p10k.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/Erik.Simon/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/Erik.Simon/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/Erik.Simon/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/Erik.Simon/google-cloud-sdk/completion.zsh.inc'; fi
