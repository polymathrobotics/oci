#!/bin/bash
set -euo pipefail

# Usage: gather_rosdeps.sh <dest> <path1> <path2> ...
# Writes a script to file <dest> with commands to install all rosdep dependencies for packages in <path1> <path2> ...

DEST=$1
shift

initial=$(
  PIP_BREAK_SYSTEM_PACKAGES=1 \
  rosdep install \
  --from-paths "$@" \
  --ignore-src \
  --skip-keys "${SKIP_KEYS:-""}" \
  --rosdistro "$ROS_DISTRO" \
  --default-yes \
  --simulate)

# Combine all apt-get install lines into a single command
# This makes there be only a single "reading package lists", which can take nontrivial time
# and so allows for a significant speedup when there are many "apt-get install" commands,
# especially when an earlier package installs a package that is later installed manually,
# which is a noop that takes multiple seconds per package

# Finds lines with "apt-get install", extracts the last word (package name), then sorts
apt_deps=$(echo "$initial" | grep "apt-get install" | sed 's/'\''\(apt-get install -y\)\(.*\)'\'' .*/\1\2/g' | awk '{print $NF}' | sort | tr '\n' ' ') || echo ''
if [ -n "${apt_deps}" ]; then
  apt_statement="apt-get install -y --no-install-recommends -q ${apt_deps}"
else
  apt_statement=""
fi

# Combine all pip install lines into a single command
pip_deps=$(echo "$initial" | grep "pip3 install" | awk '{print $NF}' | sort | tr '\n' ' ') || echo ''
if [ -n "${pip_deps}" ]; then
  pip_statement="PIP_BREAK_SYSTEM_PACKAGES=1 python3 -m pip install ${pip_deps}"
else
  pip_statement=""
fi

cat << EOF > "$DEST"
#!/bin/bash
set -euxo pipefail
${apt_statement}
${pip_statement}
EOF
chmod +x "$DEST"

echo "Success!"
