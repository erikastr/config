function knifectx() {
  if [ $# -eq 0 ]; then
    knife config list-profiles
  else
    export CHEF_PROFILE="$1"
  fi
}
