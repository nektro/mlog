---
title: "Find and Install Missing Firmware on Debian"
date: 2021-03-11T20:47:16-08:00
---

Run

```sh
$ sudo dmesg | grep 'firmware load for' | grep 'failed with error'
```

This will search your diagnostic kernel logs for failed firmware loads and will produce lines that look similar to the following

```
[   53.168802] bluetooth hci0: Direct firmware load for qca/rampatch_usb_00000200.bin failed with error -2
```

Take that file name and pass it to

```sh
$ sudo apt-file search qca/rampatch_usb_00000200.bin
```

Which in this case will yield

```
firmware-atheros: /lib/firmware/qca/rampatch_usb_00000200.bin
```

Finally, run

```sh
$ sudo apt install firmware-atheros
```

and reboot!
