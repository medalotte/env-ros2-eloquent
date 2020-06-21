FROM ubuntu:18.04
ENV DEBIAN_FRONTEND noninteractive
ENV ROS_DISTRO eloquent

RUN apt update && apt install -y \
    locales && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN dpkg-reconfigure locales && \
    locale-gen ja_JP ja_JP.UTF-8 && \
    update-locale LC_ALL=ja_JP.UTF-8 LANG=ja_JP.UTF-8
ENV LC_ALL   ja_JP.UTF-8
ENV LANG     ja_JP.UTF-8
ENV LANGUAGE ja_JP.UTF-8

RUN apt update && apt install -y \
    curl \
    gnupg2 \
    emacs \
    tmux \
    lsb-release && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl http://repo.ros2.org/repos.key | apt-key add - && \
    sh -c 'echo "deb [arch=amd64,arm64] http://packages.ros.org/ros2/ubuntu \
    `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'

RUN apt update && apt install -y \
    ros-$ROS_DISTRO-desktop \
    # ros-$ROS_DISTRO-turtlebot3* \ # https://github.com/ros-planning/navigation2/issues/1618, https://github.com/ROBOTIS-GIT/turtlebot3/issues/561
    ros-$ROS_DISTRO-navigation2 \
    ros-$ROS_DISTRO-nav2-bringup \
    ros-$ROS_DISTRO-slam-toolbox \
    python3-colcon-common-extensions \
    python3-rosdep \
    python3-argcomplete && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN rosdep init && rosdep update
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc

COPY ws/src /tmp/src/
RUN . /opt/ros/$ROS_DISTRO/setup.sh && \
    apt update && rosdep install -q -y \
    --from-paths /tmp/src \
    --ignore-src && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
