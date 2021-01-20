# Most of these commands will work on most shells but they where tested and used on zsh

# list of alias/helper commands commands
als() {
  echo "dps \t\t: Simplified list of **running** containers. Check --help for more dps commands."
  echo "cext \t\t: Number of files, of the given extension, inside the current directory, recursively"
  echo "ip -p \t\t: Show public ipv4"
  echo "ssh-hosts \t: Show hosts set on ssh config file"
  echo "weather \t: Show local weather"
  echo "ls is aliased to list files with directories first"
}

# docker helper command
dps() {
  t=$1

  case $t in
    "-a")
      docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | sort
    ;;
    "-af")
      docker ps -a --no-trunc --format \
      "{{.Names}}\n\t \
      ContainerID: {{.ID}}\n\t \
      Image: {{.Image}}\n\t \
      Command: {{.Command}}\n\t \
      Ports: {{.Ports}}\n\t \
      Networks: {{.Networks}}\n\t \
      Size: {{.Size}}\n\t \
      CreatedAt: {{.CreatedAt}}\n\t \
      RunningFor: {{.RunningFor}}\n\t \
      Status: {{.Status}}\n"
    ;;
    # Mounts: {{.Mounts}}\n\t \
    "--ip")
      docker ps -q | xargs docker inspect --format '{{ .Id }} - {{ .Name }} - {{ .NetworkSettings.IPAddress }}'
    ;;
    "--rmid")
      docker rmi $(docker images -f "dangling=true" -q)
    ;;
    "--stop")
      docker stop $(docker ps -a -q)
    ;;
    "ctop")
      docker run --rm -ti -v /var/run/docker.sock:/var/run/docker.sock quay.io/vektorlab/ctop:latest
    ;;
    "--help")
      echo "Docker helper commands:"
      echo "dps         Show Simplified list of **running** containers"
      echo "dps -a      Show Simplified list of all containers"
      echo "dps -af     Show list of all containers with many details"
      echo "dps ctop    Show docker containers using ctop (inits a docker container)"
      echo "dps --ip    Show running containers with their assigned ips"
      echo "dps --stop  Stop all running container"
      echo "dps --rmid  Delete all dangling images. \e[41mDESTRUCTIVE\e[49m"
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

# Show hosts set on ssh config file
alias 'ssh-hosts'='grep -w -i "Host" ~/.ssh/config | sed "s/Host//"'
alias 'ls'='ls -lah --group-directories-first'

alias weather='curl wttr.in'
