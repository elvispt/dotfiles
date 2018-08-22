# Most of these commands will work on most shells but they where tested and used on zsh

# Simplified list of containers, both running and stopped
alias 'dockerps'='docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'
# Show a list of running containers with ID - NAME - IP
#alias 'dockerip'="docker ps -q | xargs docker inspect --format '{{ .Id }} - {{ .Name }} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"
alias 'dockerip'="docker ps -q | xargs docker inspect --format '{{ .Id }} - {{ .Name }} - {{ .NetworkSettings.IPAddress }}'"

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

# Show hosts set on ssh config file
alias 'ssh-hosts'='grep -w -i "Host" ~/.ssh/config | sed "s/Host//"'

# A simple cli documentation generator
# Idea from: https://news.ycombinator.com/item?id=17797355
umedit() { mkdir -p ~/notes; vim ~/notes/"$1.md"; }
um() { less ~/notes/"$1.md"; }
umlist() { ls -1t ~/notes/ | sed 's/\..*$//'; }

