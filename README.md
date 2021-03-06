![logo](logo.png)

Google Music Manager - Docker Image (Multiarch)
===============================================

[![latest release](https://img.shields.io/github/release/jaymoulin/docker-google-musicmanager.svg "latest release")](http://github.com/jaymoulin/docker-google-musicmanager/releases)
[![Docker Pulls](https://img.shields.io/docker/pulls/jaymoulin/google-musicmanager.svg)](https://hub.docker.com/r/jaymoulin/google-musicmanager/)
[![Docker stars](https://img.shields.io/docker/stars/jaymoulin/google-musicmanager.svg)](https://hub.docker.com/r/jaymoulin/google-musicmanager/)
[![Bitcoin donation](https://github.com/jaymoulin/jaymoulin.github.io/raw/master/btc.png "Bitcoin donation")](https://m.freewallet.org/id/374ad82e/btc)
[![Litecoin donation](https://github.com/jaymoulin/jaymoulin.github.io/raw/master/ltc.png "Litecoin donation")](https://m.freewallet.org/id/374ad82e/ltc)
[![PayPal donation](https://github.com/jaymoulin/jaymoulin.github.io/raw/master/ppl.png "PayPal donation")](https://www.paypal.me/jaymoulin)

This image allows you to download and upload your Google Music Library to/from a selected folder.
This image is based on [Google MusicManager](https://github.com/jaymoulin/google-music-manager)

Installation
---

```
docker run -d --restart=always -v /path/to/your/upload/library:/media/library/upload -v /path/to/your/download/library:/media/library/download --name googlemusicmanager jaymoulin/google-musicmanager
```

You must define your path to your upload library in a volume to `/media/library/upload`
You must define your path to your download library in a volume to `/media/library/download`

You can also mount a folder to `/root/oauth` to keep or reuse your key

See environment variables to tweak some behaviour

Environment variables
---------------------

These environment variable will produce a different behaviour

* `REMOVE` : Remove file on successful upload (boolean, (default: false)) - pass to true if you want to delete files
* `ONESHOT` : Execute only once without listening to folder events (boolean, (default: false)) - pass to true if you want to execute only once (also remove `--restart=always` from docker parameters)  
* `UPLOADER_ID` : Identity of your uploader, must be your MAC address in uppercase 
    (default: false, which means your actual MAC address) - Change this value only if you know what you are doing and had `MAX_PER_MACHINE_USERS_EXCEEDED` error
* `DOWNLOAD` : Enable/Disable downloading from Google Music (boolean, (default: true)) - pass false if you do not want to download files
* `UPLOAD` : Enable/Disable uploading from Google Music (boolean, (default: true)) - pass false if you do not want to upload files


### Example

```
docker run -d --restart=always -v /path/to/your/upload/library:/media/library/upload -v /path/to/your/download/library:/media/library/download -e REMOVE=true --name googlemusicmanager jaymoulin/rpi-google-musicmanager
```

will not delete files after successful upload

Configuration
---
First, you have to allow the container to access your Google Music account
```
docker exec -ti googlemusicmanager auth
```
Then follow prompted instructions.

You will be asked to go to a Google URL to allow the connection:

```
Visit the following url:
 https://accounts.google.com/o/oauth2/v2/auth?client_id=XXXXXXXXXXX.apps.googleusercontent.com&access_type=offline&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fmusicmanager&response_type=code&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob
Follow the prompts, then paste the auth code here and hit enter:
```

Once done, restart the container to start downloading your library
```
docker restart googlemusicmanager
```

Appendixes
---

### Install Docker

If you don't have Docker installed yet, you can do it easily in one line using this command
 
```
curl -sSL "https://gist.githubusercontent.com/jaymoulin/e749a189511cd965f45919f2f99e45f3/raw/0e650b38fde684c4ac534b254099d6d5543375f1/ARM%2520(Raspberry%2520PI)%2520Docker%2520Install" | sudo sh && sudo usermod -aG docker $USER
```
