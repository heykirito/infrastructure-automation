# Powershell Automation

Hey, here I'm working on powershell scripts to automate windows for boring task I had to do multiple times.

## Problem it solved:
In my office, I occasionally had to setup user profiles on Windows, which was repetitive and boring, so I decided to automate it using powershell scripts.

## How it works:
Currently there are two ps1 scripts in this folder, one is pre-user configuration and other is post user configuration. It's like setting up a system for a new user, you run the initial script, which creates the new user and adjust some options as per requirements, then you log into new user, run the final config, which does the remaining work.

## Limitation:
I went ahead with two configs instead of a single file because currently windows doesn't allow logging in and out with a script, so we have to do this part manually. 

## Requirements:
- Windows 10 or 11
- A usb to keep the scripts
- A windows installation with at least one account already configured to launch the script from. 

