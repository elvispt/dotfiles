# Most of these commands will work on most shells but they where tested and used on zsh

# Simplified list of containers, both running and stopped
alias 'dockerps'='docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'

# Git flow related scripts
featureStart() {
  git flow feature start $1
}
featurePublish() {
  git flow feature publish $1
  success=$?
  if test $success -eq 0;
  then
    git checkout develop
  else
    echo -e "\e[91mDid not publish!"
  fi
}
alias fstart='featureStart'
alias fpub='featurePublish'

# Allows finding a string on command history file.
# Uses ripgrep https://github.com/BurntSushi/ripgrep) instead of grep.
# Replace rg for grep if dont want it.
findInHistory() {
  cat ~/.zsh_history | rg $1
}
alias fh='findInHistory'

# shortcuts to common locations
function gt() {
  target=$1;

  case $target in
    "code")
      cd ~/Documents/code/ && ls
    ;;
    *)
      cd ~ && ls
  esac
}
alias 'gt'='gt'

# scon application definition
connectTo() {
  t=$1

  case $t in
    "sa")
      ssh -i <KEYPATH1> <USER1>@<DOMAIN|IP2>
    ;;
    "eu")
      ssh -i <KEYPATH2> <USER2>@<DOMAIN|IP2>
    ;;
    *)
      echo -e "\e[33m scon sa \e[0m - <DESCRIPTION1>"
      echo -e "\e[33m scon eu \e[0m - <DESCRIPTION2>"
    ;;
  esac
}
alias scon='connectTo'
