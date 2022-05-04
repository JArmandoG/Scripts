# Backing up user settings & User extensions

To-Do: Linux & Windows settings 
---

## 1: Backup user settings:
MacOS: `cat $HOME/Library/Application\ Support/Code/User/settings.json >> vscode-settings.json && \
    cat vscode-settings.json`

To recover: `cmd/ctrl + shift + P` inside VSCode open `"OPEN settings (JSON)"` and rewrite

## 2: Backup user extensions:
`code --list-extensions >> vscode-my-extensions.txt`
Recover user extensions: `cat vscode-my-extensions.txt | xargs -n 1 code --install-extension`