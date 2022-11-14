# my-toolbox
Useful scripts and configs

## Bash aliases
path: ~/.bashrc
```
alias ga='git add '
alias gaa='git add .'
alias gc='git commit -v'
alias gca='git commit --amend'
alias gcadate='git commit --amend --date="$(date -R)"'
alias gco='git checkout '
alias gcp='git cherry-pick '
alias gcpc='git cherry-pick --continue'
alias gcu='git commit --amend --no-edit'
alias gd='git diff '
alias gdt='git difftool '
alias gf='git fetch '
alias gl='git log --oneline'
alias glf='git log --format="%ai %C(yellow)%h%Creset %s %Cgreen%b"'
alias glr='git log --reverse --oneline'
alias gpr='git pull --rebase'
alias gra='git rebase --abort '
alias grc='git rebase --continue '
alias grh='git reset --hard head'
alias gri='git rebase -i '
alias gs='git status'
alias gsta='git stash apply '
alias gstl='git stash list'
alias npp="/c/Program\ Files/Notepad++/notepad++.exe"
alias vah='vagrant halt'
alias vas='vagrant ssh'
alias vau='vagrant up'
```

## .gitconfig
```
[core]
	autocrlf = true
#	editor = 'C:/Program Files/Notepad++/notepad++.exe' -multiInst -notabbar -nosession -noPlugin
	editor = code --wait

[diff]
    tool = winmerge
	
[difftool "winmerge"]
	cmd = 'C:/Program Files (x86)/WinMerge/WinMergeU.exe' \"$LOCAL\" \"$REMOTE\"
		   
[mergetool "winmerge"]
	cmd = 'C:/Program Files (x86)/WinMerge/WinMergeU.exe' -e -u -dl \"Base\" -dr \"Mine\" $LOCAL $REMOTE\"
	trustExitCode = true
	prompt = false
	keepBackup = false
	keepTemporaries = false
```

## PowerShell
* Group rename files removing part of the filename (NLog)  
`get-childitem *.txt | foreach { rename-item $_ $_.Name.Replace("NLog", "") }`


## Tools
### SourceTree: custom action - file history
* Tools - Options - Custom Actions - Add. Menu caption: File history. Check 'Open in a separate window'  
* Script to run: `"C:\Program Files (x86)\GitExtensions\GitEx.cmd"`
* Parameters:   `filehistory $REPO\$FILE`

