# Most of these commands will work on most shells but they where tested and used on zsh

# Simplified list of containers, both running and stopped
alias 'dockerps'='docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'
# Show a list of running containers with ID - NAME - IP
alias 'dockerip'="docker ps -q | xargs docker inspect --format '{{ .Id }} - {{ .Name }} - {{ .NetworkSettings.IPAddress }}'"

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
    "down")
      cd ~/Downloads && ls
    ;;
    *)
      cd ~ && ls
  esac
}
alias 'gt'='gt'

# Count number of files with the given extension
function countFilesByExtension() {
  ext=$1
  if [ -z "$ext" ]
  then
    echo "Counts the number of files, of the given extension, inside the current directory, recursively."
    echo "Usage: cext <EXTENSION>"
    return
  fi
  ls -lR | grep -cE "^-.*\.$ext$"
}
alias cext='countFilesByExtension'

# scon application definition
connectTo() {
  t=$1

  case $t in
    "sa")
      ssh -i ~/.keys/nearsoftkey.pem ubuntu@ec2-52-67-110-103.sa-east-1.compute.amazonaws.com
    ;;
    "eu")
      ssh -i ~/.keys/nearsoft2.pem ubuntu@ec2-52-19-94-82.eu-west-1.compute.amazonaws.com
    ;;
    *)
      echo -e "\e[33m scon sa \e[0m - São Paulo: Digitalgrow System"
      echo -e "\e[33m scon eu \e[0m - Ireland: Development Server"
    ;;
  esac
}
alias scon='connectTo'

# get local ip and public ip
ip() {
  t=$1

  case $t in
    "-p")
      curl ipecho.net/plain ; echo
    ;;
    "--help")
      echo -e "\e[33m ip \e[0m - Show local ip address"
      echo -e "\e[33m ip -p \e[0m - Show public ip address"
    ;;
    *)
      ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}'
  esac
}
alias ip='ip'

