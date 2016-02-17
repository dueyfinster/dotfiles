alias d="docker"
alias di='docker images'
alias dps='docker ps'
alias dim='docker images'
alias dka='docker kill $(docker ps -q --no-trunc)'
alias dsta='docker stop $(docker ps -q --no-trunc)'
alias drmae='docker rm $(docker ps -qa --no-trunc --filter "status=exited")'
alias drmiad='docker rmi $(docker images --filter "dangling=true" -q --no-trunc)'
alias dr='docker run'
alias dritrm='docker run -it --rm'
#alias dr='docker run -it --rm'
alias dpsa='docker ps -a'
alias din='docker inspect'

function d(){
  docker "$@"
}
