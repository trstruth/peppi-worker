MELEE_ISO_PATH=/home/trstruth/Work/isos/Super\ Smash\ Bros.\ Melee.iso

docker run -d \
	   -e DISPLAY \
	   --device /dev/dri:/dev/dri \
	   --gpus all \
	   --volume="/tmp/.X11-unix:/tmp/.X11-unix" \
	   --volume="$MELEE_ISO_PATH:/iso/Super Smash Bros. Melee.iso" \
	   --volume="$PWD/Replays:/Replays" \
	   --volume="$PWD/Comm:/Comm" \
	   --volume="$PWD/Dump:/Slippi-FM-r18/playback/User/Dump" \
	   peppi-worker:latest
