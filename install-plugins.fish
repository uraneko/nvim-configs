set plugins (bat plugins.json)
set plgn_dirs (echo $plugins | jq keys[])
set plgn_path "pack/plugins"

function reset_plugin_dirs
	echo "Are you sure you wish to remove your pack dir (your plugins will be gone) [y,n]?"
	read -p "" -l proceed
	if test $proceed != "y" -a $proceed != "yes"
		echo aborting...
		exit
	end
	if test $argv[1] = "--track-old"
		fish record-plugins.fish old-plugins.json &> /dev/null
	end
	set -l diff (diff plugins.json old-plugins.json | wc -l)
	if test $diff = 0
		echo desired plugins are already installed, aborting...
		exit
	end
	rm pack -rf
	mkdir -p $plgn_path/{start, themes, opt}
end

function install_dir_plugins 
	pushd $plgn_path/(echo $argv[1] | string replace -a '"' "")
	# set -l kvpairs (echo $plugins | jq .$argv[1] | jq -r 'keys[] as $k | "\($k)::\(.[$k])"')
	set -l repos (echo $plugins | jq .$argv[1] | jq values[])
	for p in $repos 
		echo cloning -- $p -- repo
		git clone (echo $p | string replace '"' '' -a)
	end
	popd
end

reset_plugin_dirs $argv[1]
for d in $plgn_dirs 
	install_dir_plugins $d
end


