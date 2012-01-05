---
layout: post
title: Honeypot Passwords file for Dropbox and Mac OSX
type: post
source: null
---

[Download the Honeypot][Passwords.zip]

[Passwords.zip]: /files/Passwords.zip

A while back, I wrote a small applescript that could be attached to a folder action inside Dropbox that would (upon a trigger, which in this case, was any file being added to a specific folder) record the users IP address (via a `curl -sS http://whatismyip.com` command, which no longer seems to work), and snap a picture with the iSight camera (using Axel Bauer's [isightCapture][] CLI (Command Line Interface)), and save the whole thing back into Dropbox so that you can see them on your other computers, or on the web.

[isightCapture]: http://www.intergalactic.de/pages/iSight.html

But it had one major flaw. It took a bit of work to set it all up (needed the CLI to be installed into the Applications directory, needed to set up the folder action), which rendered it useless if (like most people) you only decided to look for a solution _after_ the laptop was stolen. So I let the link die, and decided not to follow up on it anymore.

However I have been contacted about it a few times. And each time I've had to explain that if the laptop was already gone, there wasn't much you could do. At least not with my script. Huge bummer for me. This morning, I was asked again,and I had an idea. What if I bundled the iSight CLI into an Applescript Application, changed the icon to an Excel document, and created a honeypot? Instead of needing the Folder action to work as the trigger[^1], You could simply drop this bundle into the root of your dropbox _after_ the laptop was stolen, and the thief's own curiosity would do the rest.

[^1]: Holy shit, has anyone been able to get Folder Actions to work reliably? And why the hell do they always pull focus before firing? What an awful implementation.

So I rewrote it a bit to point to a bundled version of the iSight CLI, and also to dump everything into the Dropbox Public folder, which would give Dropbox a bit of time to upload it to the servers before the thief would be able to figure out what was going on. I think it's pretty neat.

So here's the new install procedure:

1. Download [Passwords.zip][Passwords.zip]
2. Unzip, and put the fake Excel file (called "Passwords") somewhere super obvious in your Dropbox. Like the root. Basically, put it anywhere in your Dropbox folder _except_ the public folder[^2]. This can (obviously) be done from any computer hooked up to the same Dropbox account, or you can even upload the file via the Dropbox Website.
3. You're done.

[^2]: Theoretically, you could put it in your public folder, and it will work. But the script dumps the image and IP address into the public folder, so if that's where the script is, it will be pretty obvious what is going on, and the thief may have a better chance of stopping it.

This can be done after the thief already has your laptop. As long as Dropbox is still syncing, the passwords file will get to them, and their curiosity will take over. Once they get the file, here's what will happen:

1. The thief tries to open the "Excel" document
2. The script logs the IP address by doing `curl http://icanhazip.com`
3. A folder is created inside the Dropbox Public directory with the name of the IP address
4. The script snaps a photo with the iSight CLI, and saves it inside the same IP directory, and names it with the current date
5. Dropbox then syncs that data to the DB servers, and also back to your computer

Hypothetically, it may look to the thief like Excel is simply crashing, which may even cause him/her to attempt to launch it again, increasing your chances of getting a useable picture.

## DISCLAIMERS

It should be noted that using this script in no way guarantees that you will be able to find your stolen laptop, and I make no claims as such. Also, please note that there are a number of ways a semi-smart thief could foil this script:

1. If the laptop never connects to the internet, Dropbox cannot sync. So the Honeypot app won't be downloaded, and the image and containing folder won't be able to sync.
2. If the thief knows about Dropbox, they may be smart enough to go up to the web client and permanently  delete the picture from Dropbox's servers
3. There is a chance that the thief may never attempt to open the honeypot at all
4. There is also a chance that the thief will be able to catch and delete the image before Dropbox gets to upload it. I have tried to minimize this by placing it in the Public directory (And therefor, out of sight). But the chance is always there.
5. There is also no way to know how the image will come out. Theoretically, if the thief is trying to open your passwords file, they would be staring right at the screen, and therefor, the picture would be great. But there's really no way to know for sure.

## CODE

I'm making the (extremely) basic code for the Applescript portion of this app available as a [Gist on GitHub][gist]. I do not have access to the iSightCapture CLI source, and will not be releasing it as a standalone product, just embedded into the app. If you want the actual iSightCapture CLI, you will have to download it from [it's project page][isightCapture].

[gist]: https://gist.github.com/922003