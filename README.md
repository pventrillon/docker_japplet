# docker_japplet
docker to run java applets

docker to run a java applet - even an unsighed java applet that requiresprivileges. It is based on firefox 52 esr and openjdk.

I use it to access applets embedded in my Lexmark printer.

How I use it :

    xhost + 127.0.0.1
    docker run --mount type=bind,source="$(pwd)"/scan,target=/scan --network host -it --rm -e DISPLAY=127.0.0.1:0 pventrillon/japplet http://192.168.0.7

Options : --mount type=bind,source="$(pwd)"/scan,target=/scan : enables the docker to save files in host system. Files created in container /scan directory are available in $pwd/scan directory of host system after container is ended.

--network host : container shares IP network with host system.

-e DISPLAY=127.0.0.1:0 : container has this env var set.

http://192.168.0.7 : base URL of hte applet to authorise.

