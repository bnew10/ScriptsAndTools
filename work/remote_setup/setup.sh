#!/usr/bin/env bash

set -e

# if no argument is given, give usage info
if [ $# -eq 0 ]; then
  echo "Usage: $0 <ssh-destination>"
  echo "Example: $0 user@hostname"
  exit 1
fi

yellow="\033[33m"
cyan="\033[36m"
red="\033[31m"
green="\033[32m"
nc="\033[0m"

for remote in "$@"; do

  echo -e "$green$remote setup:$nc"

  # local path to remote path mapping
  declare -A src_to_dst=(
    ["./cleanup+installation"]="/var/local/tmp"
    ["./aliases"]="/root/.aliases"
    ["./inputrc"]="/root/.inputrc"
    ["./tmux.conf"]="/root/.tmux.conf"
    ["./vimrc"]="/root/.vimrc"
    ["./ntfy"]="/usr/local/bin/ntfy"
  )

  # scp each local file to their remote dst path
  for src in "${!src_to_dst[@]}"; do
    dst="${src_to_dst[$src]}"
    echo -e "=== Copying $yellow$src$nc to $cyan$remote:$dst$nc"
    scp -rO "$src" "$remote:$dst"
  done

  src_aliases="source\ /root/.aliases"
  config_bin="export\ PATH=\\\"/usr/share/vcinity/configuration/bin:\\\$PATH\\\""
  tmux_esc="export\ TMUX_ESC=1"
  lines=("$src_aliases" "$config_bin" "$tmux_esc")
  bashrc="/root/.bashrc"
  symlink="/root/cleanup+installation"
  realpath="/var/local/tmp/cleanup+installation"
  port=4444
  proxy="http://localhost:${port}"
  cmds=$(
    cat <<-CMD
    # if remote's .bashrc doesn't contain config lines, append them
    for line in ${lines[@]}; do
      if ! grep "\$line" "$bashrc" >/dev/null; then
        echo -e "=== Appending \"$yellow\$line$nc\" to $cyan$bashrc$nc"
        echo -e "\n\$line" >>"$bashrc"
      fi
    done

    # if home directory symlink doesn't exist, create it
    if [ ! -h "$symlink" ]; then
      echo -e "=== Creating symlink to $yellow$realpath$nc in home directory"
      ln -s "$realpath" "$symlink"
    fi
    
    # vim setup
    echo "=== Installing vim plugins"
    export http_proxy="${proxy}"
    export https_proxy="${proxy}"
    vim "+PlugInstall --sync" +qa

    # tmux setup
    echo "=== Upgrading tmux"
    source /etc/os-release
    version="\$(cut -f 5 -d ':' <<<"\$CPE_NAME")"
    echo "Installing tmux for RHEL \$version"
    if ! dnf -y install "http://galaxy4.net/repo/galaxy4-release-\${version}-current.noarch.rpm"; then
      echo -e "${red}Error${nc}: Failed to set up tmux repo"
      exit 0
    fi
    
    if ! dnf -y install tmux; then
      echo -e "${red}Error${nc}: Failed to install tmux"
      exit 0
    fi
CMD
  )

  tinyproxy 2>&1 | sed 's/^/[tinyproxy] /'
  ssh -R $port:localhost:8888 -t "$remote" "$cmds"
  kill -9 $(pgrep tinyproxy)
  echo "[tinyproxy] Shutdown successful"
done
