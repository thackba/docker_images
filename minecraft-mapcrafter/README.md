This is a dockerized Minecraft [Mapcrafter](https://mapcrafter.org/index).

*Volumes*

- /data/input - The input folder. This should be the folder minecraft is installed in.
- /data/output - The output folder. In this folder the html data will be created.

*Sample*

```
docker run --rm -it -v <minecraft-server-folder>:/data/input \
                    -v <webserver-folder>:/data/output \
                    thackba/minecraft-mapcrafter:latest \
                    -c /data/input/render.conf

```

In this sample the config file is stored in the minecraft server folder.

*Sample configuration*

```
output_dir = /data/output
 
[global:map]
world = world
render_view = isometric
render_mode = daylight
rotations = top-left bottom-right
texture_size = 12
 
[world:world]
input_dir = /data/input/world
 
[map:world_isometric_day]
name = World
render_mode = daylight
```
