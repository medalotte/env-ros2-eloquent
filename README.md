# env-ros2-eloquent
Environment of ROS2 Eloquent with Docker using Docker Compose

## Usage
### 1. set pkgs to `ws/src`

```shell
$ git clone https://github.com/medalotte/env-ros2-eloquent.git
$ cp -R [pkgs] [top of this repository]/ws/src
```

### 2. build docker image

```shell
$ cd [top of this repository]
$ docker-compose build # process of dependencies installation included
```

### 3. run container and build pkgs

```shell
$ docker-compose run --rm docker-eloquent
$ colcon build
```
