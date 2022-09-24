#!/usr/bin/env sh

DST_ROOT_PATH="/app"
DST_INSTALL_PATH="${DST_INSTALL_PATH:-dst_server}"
DST_CLUSTER_NAME="${DST_CLUSTER_NAME:-Cluster_1}"

function fail()
{
	echo Error: "$@" >&2
	exit 1
}

function check_for_file()
{
	if [ ! -e "$1" ]; then
		fail "Missing file: $1"
	fi
}

steamcmd +force_install_dir "$DST_INSTALL_PATH" +login anonymous +app_update 343050 validate

check_for_file "$DST_INSTALL_PATH/bin"

cd "$DST_INSTALL_PATH/bin" || fail

run_shared=(./dontstarve_dedicated_server_nullrenderer)
run_shared+=(-console)
run_shared+=(-cluster "$cluster_name")
run_shared+=(-persistent_storage_root $DST_USER_ROOT_PATH)
run_shared+=(-ugc_directory $DST_USER_ROOT_PATH/ugc)
run_shared+=(-monitor_parent_process $$)

"${run_shared[@]}" -shard Caves  | sed 's/^/Caves:  /' &
"${run_shared[@]}" -shard Master | sed 's/^/Master: /'
