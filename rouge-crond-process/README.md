# Finding a malicious CronD task in my server:

An automated notification from GoDaddy about high server utilization quickly turned into a Cryptominer infection and Storage exhaustion issue. 

**Date:** 15th June 2026
**Status:** Resolved

## Summary

I received a notification from GoDaddy that my Disk utilization was really high. I logged in and checked and the first thing I noticed was that my CPU was capped out. It was at 100% utilization for past 2 days, I quickly logged in WHM and started investigating. 

Here's how I troudbleshooted everything alongside commands:

## The Cryptominer

1. Check which task is taking up most resource using 
```bash
top
```
You'll see all the current process and the amount of system resources they are using. In my case, a single task, crond was taking up 99% of the CPU. 

2. Usually, the top command only shows the parent processes, not the child ones, check the child processes using following command:
```bash
pstree -p $(psgrep crond)
```

In case, this command doesn't make things clear, use the following command, it will give you the location of the scripts from where that particular pid process is running. 
```bash
lsof -p <pid>
```

You can also use this command to pinpoint the script using the name of the process itself:
```bash
ps -ef | grep crond
```

