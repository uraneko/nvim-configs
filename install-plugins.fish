set -l plugins (bat plugins.json)
set -l plgn_dirs (echo $plugins | jq keys[])
set -l plgn_path pack/plugins

function reset_plugin_dirs
	echo "Are you sure you wish to remove your pack dir (your plugins will be gone) [y,n]?"
	read -p "" -l proceed
	if test $proceed != "y" -a $proceed != "yes"
		echo quitting...
		exit
	end
	if test argv[1] = "--record-old-plugins"
		record-plugins.fish old-plugins.json &> /dev/null
	end
	rm pack -rf
	mkdir -p $plgn_path/{start, themes, opt}
end

function install_dir_plugins 
	pushd $plgn_path/$argv[1]
	# set -l kvpairs (echo $plugins | jq .$argv[1] | jq -r 'keys[] as $k | "\($k)::\(.[$k])"')
	set -l repos (echo $plugins | jq .$argv[1] | jq values[])
	for p in $repos 
		git clone $p
	end
	popd
end

reset_plugin_dirs $argv[1]
for d in $plgn_dirs 
	install_dir_plugins $d
end

