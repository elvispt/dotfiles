# Most of these commands will work on most shells but they where tested and used on zsh

# docker helper command
dps() {
  t=$1

  case $t in
    "-a")
      docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | sort
    ;;
    "--ip")
      docker ps -q | xargs docker inspect --format '{{ .Id }} - {{ .Name }} - {{ .NetworkSettings.IPAddress }}'
    ;;
    "--help")
      echo "Docker helper commands:"
      echo "dps         Simplified list of **running** containers"
      echo "dps -a      Simplified list of all containers"
      echo "dps --ip    Show running containers with their assigned ips"
    ;;
    *)
      docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | sort
  esac
}

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

alias weather='curl wttr.in'
