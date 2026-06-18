function repo() {
  if [ -z "$1" ] || [ "$1" = "." ]; then
    local remote=$(git remote get-url origin | sed 's|git@github.com:|https://github.com/|' 2>/dev/null)

    if [ -z "$remote" ]; then
      echo "Error: Unable to determine repository name."
      return 1
    fi
    xdg-open "$remote"
  else
    xdg-open https://github.com/"$1"
  fi
}

