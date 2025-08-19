#!/bin/bash
set -e

echo "🚀 Start dotfiles setup..."

# -----------------------------
# 0. Homebrew 설치 여부 확인
# -----------------------------
if ! command -v brew &> /dev/null; then
  echo "➡️ Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "✅ Homebrew already installed"
fi

# -----------------------------
# 1. Oh My Zsh 설치
# -----------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "➡️ Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "✅ Oh My Zsh already installed"
fi

# -----------------------------
# 2. 플러그인 설치
# -----------------------------
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

# zsh-autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "➡️ Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

# zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "➡️ Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

# zsh-completions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ]; then
  echo "➡️ Installing zsh-completions..."
  git clone https://github.com/zsh-users/zsh-completions $ZSH_CUSTOM/plugins/zsh-completions
fi

# autojump
if ! brew list autojump &>/dev/null; then
  echo "➡️ Installing autojump..."
  brew install autojump
else
  echo "✅ autojump already installed"
fi

# -----------------------------
# 3. Starship 설치
# -----------------------------
if ! command -v starship &> /dev/null; then
  echo "➡️ Installing Starship..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y
else
  echo "✅ Starship already installed"
fi

# -----------------------------
# 4. 설정 파일 심볼릭 링크
# -----------------------------
echo "➡️ Linking config files..."
ln -sf ~/dotfiles/.zshrc ~/.zshrc
mkdir -p ~/.config
ln -sf ~/dotfiles/starship.toml ~/.config/starship.toml

echo "✅ Setup complete! Restart terminal or run 'source ~/.zshrc'"

