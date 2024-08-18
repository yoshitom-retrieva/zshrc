
(){
  local BasePath="${HOME}/repos/private/zshrcs"
  # source ~/.zshrcs/.zshrc*
  source ${BasePath}/.zshrc.core
  if [[ $(uname) = "Darwin" ]]; then
      for ZSHRC in $( ls -A ${BasePath}/.zshrc.mac.* | grep -vE "sw.$"); do
          source $ZSHRC
      done
  elif [[ $(uname -r | grep -i microsoft) ]]; then
      for ZSHRC in $( ls -A ${BasePath}/.zshrc.win.* | grep -vE "sw.$"); do
          source $ZSHRC
      done
  else
      for ZSHRC in $( ls -A ${BasePath}/.zshrc.linux.* | grep -vE "sw.$"); do
          source $ZSHRC
      done
  fi
  for ZSHRC in $( ls -A ${BasePath}/.zshrc.common.* | grep -vE "sw.$"); do
      source $ZSHRC
  done
}
