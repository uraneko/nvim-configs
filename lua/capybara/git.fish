echo $(git status --porcelain | string trim | string replace -r " .*" "")
