set -l plgn_dirs start themes opt
set -l plgn_path pack/plugins

set -l bad_clr  "\x1b[1;4;2;219;24;24m"
set -l good_clr "\x1b[1;4;2;213;23;23m"
set -l note_clr "\x1b[1;2;25;25;232m"
set -l ntrlz_clr "\x1b[0m"

set json "{🍔"

function record_plugins
	for p in (ls)
		pushd $p 
		echo -e $good_clr recording plugin -- $p -- $ntrlz_clr
		set -l repo (git remote get-url --all origin)
		set -a json 🍖🥙$p🥙: 🥙$repo🥙,🍔
		popd
	end
end

function record_plugin_dir
	set -a json "🍕"🥙$argv[1]🥙: 🍟🍔
	record_plugins
	set -a json " "🍤,🍔
end

for d in $plgn_dirs 
	pushd $plgn_path/$d
	echo -e $note_clr moving to plugins directory -- $d -- $ntrlz_clr
	record_plugin_dir $d
	popd
end 

set -a json "}"

echo $json | xargs \
		   | string replace -a "🍕" " " \
		   | string replace -a "🍖" "	" \
		   | string replace -a "{🍔" "{
" \
		   | string replace "🍤,🍔 }" "🍤
}" \
		   | string replace ",🍔 🍤" "🍤" -a \
		   | string replace -a "🍟🍔 🍤" "🍟🍤" \
		   | string replace -a ",🍔 " ",
"\
		   | string replace -a "🥙" "\"" \
		   | string replace -a "🍟🍔 " "🍟
"\
		   | string replace -a "🍤" "}" \
		   | string replace -a "🍟" "{" > plugins.json


