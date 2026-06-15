# Ubuntu Autoinstaller Config

Hi, this a cloud-init config for ubuntu autoiinstaller, just boot and the installer will do rest without you lifting a finger


## Problem it solved
I built it to automate the process of installing ubuntu on many systems at once, cool thing is the user-data file on live on a local web server and just you can deploy ubuntu on hundreds of machines using pixie boot. Best part is, if you .deb packages you want to install, you can easily automate it via script thus saving you the hassle of manually downloading the packages in each system and installing them each time. 


## How it works
I made it to just boot and forget it and come back to a complete ubuntu installtion. It has a config which you use to generate your custom ubuntu ISO and boot from it. All information required for installtion are pre-written in the config file itself. The deb packages are also bundled inside the ISO itself. 

## Requirements
- Distro: Any Ubuntu distro from 20.04LTS to 24.04 LTS
- A flash drive
- ISO burner tool like rufus or balena etcher. Although can be done via terminal in Linux

## Usage 



## What I learned



## Known issues
