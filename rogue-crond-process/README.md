# Finding a malicious CronD task in my server:

An automated notification from GoDaddy about high server utilization quickly turned into a Cryptominer infection and Storage exhaustion issue. 

**Date:** 15th June 2026
**Status:** Resolved

## Summary

I received a notification from GoDaddy that my Disk utilization was really high. I logged in and checked and the first thing I noticed was that my CPU was capped out. It was at 100% utilization for past 2 days, I quickly logged in WHM and started investigating. 

Here's how I troubleshot everything alongside commands:

## The Cryptominer

1. Check which task is taking up most resource using 
```bash
top
```
You'll see all the current process and the amount of system resources they are using. In my case, a single task, crond was taking up 99% of the CPU. 

2. Usually, the top command only shows the parent processes, not the child ones, check the child processes using following command:
```bash
pstree -p $(psgrep <*process-name*>)
```

In case, this command doesn't make things clear, use the following command, it will give you the location of the scripts from where that particular pid process is running. 
```bash
lsof -p <*pid*>
```

You can also use this command to pinpoint the script using the name of the process itself:
```bash
ps -ef | grep <*process-name*>
```

3. After getting the path, usually malware or virus never run outside of system paths, they will be hidden in plain sight but under a disguise, mine was inside /root/.configrc7/a/crond directory, notice how it looks similar to /.config directory

Turns out it wasn't a single task, but multiple ones scheduled to run the miner even when the server reboots or if someone killed the process, here'e the out of crontab -e
```bash
5 6 */2 * 0 /root/.configrc7/a/upd>/dev/null 2>&1
@reboot /root/.configrc7/a/upd>/dev/null 2>&1
5 8 * * 0 /root/.configrc7/b/sync>/dev/null 2>&1
@reboot /root/.configrc7/b/sync>/dev/null 2>&1
0 0 */3 * * /dev/shm/.rsync/c/aptitude>/dev/null 2>&1
```

- @reboot enssured the malware run the second server boots up.
- /root/.configrc7/...: It relaunches the scripts from the directory.
- /dev/shm/.rsync/...: It's a temporary, in-memory filesystem. Really fast and leaves fewer to none traces. 

4. After confirming everything, I took following actions:
- Find all the malicious process from the script itself, using following command and killed them using kill -9
```bash
ps -ef | grep -E "upd|sync|aptitude"
kill -9 *<PID>*
```

- Cleared the entires in crontab, open it using crontab -e, delete all the lines and save the cron file.
- Deleted the fake directories:
```bash
rm -rf /dev/shm/.rsync
rm -rf /root/configrc7
```

5. Funny part, the malware was designed to delete other cryptominer as you can tell from this line in the script:
```bash
#    (crontab -l | grep -v 'redtail') | crontab - && rm -ff ~/.redtail && rm -rf /tmp/.redtail
```

It changed the write permissions for /usr/bin and created fake binaries at /usr/bin/systemtd
Yes, systemtd not systemd 
Also, it edited the hugepages and MSR register to maximize the mining speed. 

6. Fixing the system:
- Fixing the /usr/bin 
```bash
chmod +w /usr/bin
rm -f /usr/bin/systemtd
```

Fixing HugePages configurations:
```bash
sysctl -w vm.nr_hugepages=0
```


## The storage exhaustion
The disk space was 100% full, here's how you can find what's eating up your space

```bash
cd / && du -sh * 2>/dev/null | sort -rh | head -n 15
```

This command will check the root and find out the biggest 15 folders and print them in order of largest to shortest. 

- du -sh: Disk usage summary
- * : Check everything
- 2>/dev/null: hide disk errors
- sort -rh: sort the list largest to shortest
- head -n 15: print top 15 results 

Rest keep going in the largest folders, in my case it was years old weekly backups eating up all space, I deleted the really old ones and kept most recent ones. 
