#!/bin/bash
alias npm="docker-compose run --rm npm"
alias bower="docker-compose run --rm bower"
ember() {
  if [[ $@ == "server" ]]; then
    command docker-compose up server
  else
    command docker-compose run --rm ember "$@"
  fi
}
