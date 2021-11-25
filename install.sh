#!/bin/bash
# Disclaimer: This dirty hacky script was written by my Guineapig. Do not apply this script to users who do not want to mess up the system.


sudo add-apt-repository ppa:rvm/smplayer 
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get update 
sudo apt-get install libpython3.8 smplayer smplayer-themes vlc g++ make autoconf automake libtool pkg-config nasm git cython3 python-is-python3 mediainfo python3-pip libfreetype-dev libfontconfig-dev libfribidi-dev libssl-dev libluajit-5.1-dev libx264-dev xorg-dev libegl1-mesa-dev libharfbuzz-dev libx265-dev libqt5concurrent5 libqt5svg5 libarchive-dev libbluray-dev librubberband-dev liblcms2-utils ffmpeg libavutil-dev libavformat-dev libswscale-dev libavfilter-dev libswresample-dev libsixel-dev libplacebo-dev libcaca-dev libva-dev libvdpau-dev wayland-protocols libass-dev libwebp-dev libxvidcore-dev libzmq3-dev libopenal-dev opencl-dev libxcb-shape0-dev libxcb-shm0-dev libxcb-xfixes0-dev libxcb-util-dev
# Vapoursynth requires Cython
pip3 install Cython


# Vapoursynth
## zimg library
git clone https://github.com/sekrit-twc/zimg.git
cd zimg   
./autogen.sh
./configure
make -j4
sudo make install
git clone --branch R52 https://github.com/vapoursynth/vapoursynth.git
cd vapoursynth
./autogen.sh
./configure
make -j4
sudo make install
cd ..

sudo ln -s /usr/local/lib/python3.8/site-packages/vapoursynth.so /usr/lib/python3.8/lib-dynload/vapoursynth.so

#build and install MPV

git clone https://github.com/mpv-player/mpv-build.git
cd mpv-build
rm ffmpeg_options
rm mpv_options

echo --enable-libx264 >> ffmpeg_options
echo --enable-libx265 >> ffmpeg_options
# echo --enable-libxavs >> ffmpeg_options
# echo --enable-libxavs2 >> ffmpeg_options
echo --enable-libxcb >> ffmpeg_options
echo --enable-libxcb-shm >> ffmpeg_options
echo --enable-libxcb-xfixes >> ffmpeg_options
echo --enable-libxcb-shape >> ffmpeg_options
echo --enable-libxvid >> ffmpeg_options
echo --enable-libxml2 >> ffmpeg_options
echo --enable-libwebp >> ffmpeg_options
# echo --enable-libvpx >> ffmpeg_options
echo --enable-libzimg >> ffmpeg_options
echo --enable-libzmq >> ffmpeg_options
# echo --enable-libzvbi >> ffmpeg_options
echo --enable-openal >> ffmpeg_options
echo --enable-opencl >> ffmpeg_options
echo --enable-opengl >> ffmpeg_options
echo --enable-gpl >> ffmpeg_options
echo --enable-nonfree >> ffmpeg_options

echo --enable-vapoursynth >> mpv_options
echo --enable-libmpv-shared >> mpv_options

wget http://archive.ubuntu.com/ubuntu/pool/universe/m/mujs/mujs_1.0.7-2_amd64.deb
sudo apt install ./mujs_1.0.7-2_amd64.deb
rm ./mujs_1.0.7-2_amd64.deb


~/zimg/mpv-build/mpv/waf configure

./rebuild -j4
sudo ./install
cd ..


sudo chmod 777 /usr/lib/x86_64-linux-gnu/vlc/plugins/video_filter
sudo ln -s /usr/local/lib/libzimg.so.2 /usr/lib/libzimg.so.2

sudo ln -s $HOME/zimg/vapoursynth/.libs/libvapoursynth-script.so.0 /usr/lib/libvapoursynth-script.so.0
