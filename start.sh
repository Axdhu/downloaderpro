#bin #!bash

###### Adding Files ######
wget -O /app/tobrot/aria2/dht.dat https://github.com/P3TERX/aria2.conf/raw/master/dht.dat
wget -O /app/tobrot/aria2/dht6.dat https://github.com/P3TERX/aria2.conf/raw/master/dht6.dat
TRACKER=`curl -Ns https://raw.githubusercontent.com/XIU2/TrackersListCollection/master/all.txt -: https://ngosang.github.io/trackerslist/trackers_all_http.txt -: https://newtrackon.com/api/all -: https://raw.githubusercontent.com/DeSireFire/animeTrackerList/master/AT_all.txt -: https://torrends.to/torrent-tracker-list/?download=latest | awk '$1' | tr '\n' ',' | cat`
ran=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)
###### Done Addding Files ######


if [[ -n $RCLONE_CONFIG_URL ]]; then
  echo "Rclone config detected 📁📁"
  wget -q $RCLONE_CONFIG_URL -O /app/rclone.conf
fi

if [[ -n $CONFIG_ENV_URL ]]; then
  echo " Found config.env File 📁📁 "
	wget -q $CONFIG_ENV_URL -O /app/config.env
fi

update_and_install_packages () {
    apt -qq update -y
    apt -qq install -y --no-install-recommends \
        git \
        ffmpeg \
        mediainfo \
        unzip \
        wget \
        gifsicle 
  }
  
# Thanks To Userge For The Chrome Version Hecks  
install_helper_packages () {
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && apt -fqqy install ./google-chrome-stable_current_amd64.deb && rm google-chrome-stable_current_amd64.deb
    wget https://chromedriver.storage.googleapis.com/$(curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE)/chromedriver_linux64.zip && unzip chromedriver_linux64.zip && chmod +x chromedriver && mv -f chromedriver /usr/bin/ && rm chromedriver_linux64.zip
    wget -O opencv.zip https://github.com/opencv/opencv/archive/master.zip && unzip opencv.zip && mv -f opencv-master /usr/bin/ && rm opencv.zip
    wget https://people.eecs.berkeley.edu/~rich.zhang/projects/2016_colorization/files/demo_v2/colorization_release_v2.caffemodel -P ./bot_utils_files/ai_helpers/
}

_run_all () {
    update_and_install_packages
    install_helper_packages
    pip3 install –upgrade pip
    pip3 install --no-cache-dir -r requirements.txt
    ech_final
}

_run_all

echo "Starting Your Bot... 👾👾"
python3 -m tobrot
