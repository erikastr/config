function repo() {
  if [ -z "$1" ] || [ "$1" = "." ]; then
    # local dir=$(basename -s .git `git config --get remote.origin.url` 2>/dev/null)
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

