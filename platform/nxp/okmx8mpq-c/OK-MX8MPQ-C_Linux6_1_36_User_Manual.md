# OKMX8MPQ-C_Linux 6.1.36\_User’s Manual_V1.0

Document classification: □ Top secret □ Secret □ Internal information ■ Open

## Copyright

The copyright of this manual belongs to Baoding Folinx Embedded Technology Co., Ltd. Without the written permission of our company, no organizations or individuals have the right to copy, distribute, or reproduce any part of this manual in any form, and violators will be held legally responsible.

Forlinx adheres to copyrights of all graphics and texts used in all publications in original or license-free forms.

The drivers and utilities used for the components are subject to the copyrights of the respective manufacturers. The license conditions of the respective manufacturer are to be adhered to. Related license expenses for the operating system and applications should be calculated/declared separately by the related party or its representatives.

## Overview

This manual is designed to help users quickly familiarize themselves with the product, and understand the interface functions and testing methods. It primarily covers the testing of interface functions on the development board, the methods for flashing images, and troubleshooting procedures for common issues encountered in use. In the process of testing, some commands are annotated to facilitate the user's understanding, mainly for practical use. Please refer to “OK-MX8MPX-C\_Linux\_User’s Compilation Manual” provided by Forlinx for kernel compilation, related application compilation methods and development environment construction.

There are total eight chapters:

+ Chapter 1. provides an overview of the product, briefly introducing the interface resources of the development board, the relevant driver paths in the kernel source code, supported flashing and booting methods, as well as explanations of key sections in the documentation;
+ Chapter 2. is the fast boot/startup of the product, which can adopt two ways of serial port login and network login;
+ Chapter 3. provides function test of product desktop and QT interface;
+ Chapter 4. is the command line operation of the product for functional testing;
+ Chapter 5. is the multimedia test of the product, including the playback test of the camera and the video hardware codec test;
+ Chapter 6. is about the system settings, which include the system logo, self-starting programs, EEPROM settings, etc;
+ Chapter 7. describes the image update for the product, mainly detailing the method of updating the image to the storage device. Users can choose the corresponding flashing method according to their actual situation.
+ Chapter 8. is the instruction for the development and use of the product's MCUXpresso SDK.

A description of some of the symbols and formats associated with this manual:

| Format| **Meaning**|
|:----------:|----------|
| **Note** | Note or information that requires special attention, be sure to read carefully. |
| 📚 | Relevant notes on the test chapters. |
| ️️🛤️ ️ | Indicates the related path.|
| <font style="color:blue;">Blue font on gray background</font>| Refers to commands entered at the command line(Manual input required).|
| <font style="color:black;">Black font</font>| Serial port output message after entering a command. |
| **<font style="color:black;">Bold black</font>**| Key information in the serial port output message. |
| //| Interpretation of input instructions or output information|
| Username@Hostname| forlinx @ ubuntu: Development environment ubuntu account information, which can be used to determine the environment in which the function operates.|

After packaging the file system, you can use the “ls” command to view the generated files.

```plain
root@OK-MX8MPX-C:~# ls /run/media    //List the files in this directory
Boot-mmcblk2p1  boot-mmcblk1p1
```

+ root@OK-MX8MPX-C: The user name is root and the host name is OK-MX8MPX-C, indicating that the root user is used for operations on the development board;
+ //: Explanation of the instruction, no input required;
+ <font style="color:blue;">ls /run/media</font>: Blue font on a gray background indicating the relevant commands that need to be manually entered;
+ **<font style="color:black;">boot-mmcblk1p1</font>**: The black font with gray background is the output information after the command is input, and the bold font is the key information, which indicates the mounting directory of the TF card.

## Application Scope

This manual is mainly applicable to the Linux6.1.36 operating system on the Forlinx OK-MX8MPX-C platform. Other platforms can also refer to it, but there will be differences between different platforms. Please make modifications according to the actual conditions.

## Revision History

| **Date**| **Manual Version**| **SoM Version**| **Carrier Board Version**| **Revision History**|
|:----------:|:----------:|:----------:|:----------:|:----------:|
| 09/02/2025 | V1.0| V2.1| V3.1 and Above| OK-MX8MPQ-C Linux6.1.36 User’s Manual Initial Version|

## 1\. OK- MX8MPX-C Development Board Description

### 1.1 OK-MX8MPX-C Development Board Description

The OK-MX8MPX-C development board uses a SoM + carrier board architecture, designed based on the NXP i.MX 8M Plus industrial-grade processor. It features a quad-core Arm® Cortex®-A53 CPU with an integrated Neural Processing Unit (NPU) delivering up to 2.3 TOPS of performance and a maximum CPU frequency of 1.6GHz. Supports real-time control via Cortex-M7. Features a powerful control network with CAN FD and dual Gigabit Ethernet, supporting Time-Sensitive Networking (TSN).   
The SoM has three specs: 1GB LPDDR4 + 8GB eMMC, 2GB LPDDR4 + 16GB eMMC, and 4GB LPDDR4 + 16GB eMMC, hereinafter referred to as 1+8, 2+16, and 4+16 versions.   
OK-MX8MPX-C development board is rich in interface resources, providing a variety of peripheral interfaces, such as Codec, TF Card, LVDS, MIPI, WIFI, 4G, 5G, PCIE, serial port, CAN and other functional interfaces.

The connection of OK-MX8MPX-C SoM and the carrier board is board-to-board, and the main interfaces are as follows:

**Front**

![](https://cdn.nlark.com/yuque/0/2025/jpeg/50461850/1745908626781-6918661d-e69c-4e6e-9f87-30435731f989.jpeg)

**Back**![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908626905-40e3abd0-4cc4-47dc-bdf7-743d1d729e38.png)

**Note：**

**Hardware parameters are no longer described in this software manual. Before referring to this manual for software development, please read the "OK-MX8MPX-C Hardware Manual” to understand the product naming rules and the hardware configuration information of the product you are using, which will help you to use this product.**

### 1.2 Introduction to Linux 6.1.36 System Software Resources

| **Device**| **Location of driver source code in the kernel**| **Device Name**
|----------|----------|----------
| LCD Backlight Driver| drivers/video/backlight/pwm\_bl.c| /sys/class/backlight
| USB Port| drivers/usb/storage/| 
| USB Mouse| drivers/hid/usbhid/| /dev/input/mice
| Ethernet| drivers/net/ethernet/freescale/fec\_main.c| 
| SD/micro TF card driver| drivers/mmc/host/sdhci-esdhc-imx.c| /dev/block/mmcblk1pX
| EMMC Driver| drivers/mmc/host/sdhci-esdhc-imx.c| /dev/block/mmcblk2pX
| OV5645| drivers/media/i2c/ov5645.c| /dev/videoX
| Lvds| drivers/gpu/drm/panel/panel-lvds.c| 
| Basler-camera| extra\_8mp/kernel-module-isp-vvcam/vvcam/v4l2/sensor/camera-proxy-driver/basler-camera-driver-vvcam/basler-camera-driver-vvcam.c| 
| MIPI DSI| drivers/gpu/drm/panel/panel-forlinx-mipi.c| 
| RTC Real Time Clock Driver| drivers/rtc/rtc-rx8010.c| /dev/rtc0
| serial port| drivers/tty/serial/imx.c| /dev/ttymxcX
| Key Driver| drivers/input/keyboard/gpio\_keys.c| /dev/input/eventX
| LED| drivers/leds/leds-gpio.c| 
| SAI| sound/soc/fsl/fsl\_sai.c| 
| Audio Driver| sound/soc/codecs/wm8960.c| /dev/snd/
| PMIC| drivers/regulator/pca9450-regulator.c| 
| PCIE| drivers/phy/freescale/phy-fsl-imx8m-pcie.c| 
| QSPI| drivers/mtd/spi-nor/fsl-flexspi.c| 
| Watchdog| drivers/watchdog/imx2\_wdt.c| 
| SPI| drivers/spi/spi-imx.c| 
| PWM| drivers/pwm/pwm-imx.c| 

### 1.3 EMMC Memory Partition Table

The following table is the eMMC memory partition information of Linux operating system:

| Partition Index| Name| Offset / block| Size/block| File system| Content
|----------|----------|----------|----------|----------|----------
| 1| boot| 32K| 120M| FAT32| image<br/>OK8MP-C.dtb
| 2| rootfs| 120M| 14G+| EXT4| rootfs

### 1.4 Flashing and Boot Test

The OK - MX8MPX - C supports OTG and TF card flashing. It also supports booting Uboot via eMMC, TF card, and QSPI Flash.   
The startup dial-up code is as follows:

| **BOOT**| **4**| **3**| **2**| **1**
|----------|----------|----------|----------|----------
| FUSES| OFF| OFF| OFF| OFF
| OTG| OFF| OFF| OFF| ON
| eMMC| OFF| OFF| ON| OFF
| TF| OFF| OFF| ON| ON
| QSPI| OFF| ON| ON| OFF

## 2\. Fast Startup

### 2.1 Preparation Before Startup

The OK-MX8MPX-C development board has two system login methods, serial and network login. Hardware preparation before system startup:

+ 12V3A DC power cable
+ Debugging serial cable (Serial Login)

The debug serial port on the development board is a Type-C USB jack, so users can use a USB to Type-C cable to connect the development board to a PC and then check the board's status.

+ Network cable (for network login)
+ According to the development board interface to connect the screen (Based on display needs).

![](https://cdn.nlark.com/yuque/0/2025/jpeg/50461850/1745908628675-0b2af7eb-68d2-411d-8444-1f7fcc4b3106.jpeg)

### 2.2 Debugging Serial Driver Installation

The debugging serial port of the OK-MX8MPX-C - C platform uses a Type - C interface. There is an on - board USB to UART chip, so there's no need to purchase a USB to serial port debugging tool. It is extremely simple and convenient to use.

To install the driver, please use the driver package CP210x \_ VCP \_ Windows \_ XP \_ Vista. Zip provided in the \\ Linux \\ Tools \\ directory of the user profile.

Run CP210xVCPInstaller\_x64.exe directly after unzipping is complete, to ensure the latest driver is installed, please click driver uninstall first, then driver install.

### 2.3 Serial Login

#### 2.3.1 Serial Port Connection Settings

**Note:**

+ **Serial port settings: baud rate 115200, data bit 8, stop bit 1, no parity bit, no flow control**;
+ **Serial terminal login is the root user, and there is no need to enter the password to log in;**
+ **Software requirements: PC Windows system needs to install the super terminal software. Because the terminal software has many types, you can choose your familiar one.**

In the following, we take the putty terminal software as an example to introduce the serial port login method:

Step 1: First, you need to confirm the serial port number of the device connected to the computer. The OK-MX8MPX-C will generate two serial port numbers. Among them, SERIAL-A is the Linux debugging serial port. Check the serial port number in the Device Manager, and the actual port number recognized by the computer shall prevail.

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908628806-971ca6ed-1e5a-4196-b8d8-82b3ddb228cc.png)

Step 2: Open and set up putty, then set the“ line according to the COM port of the computer used, baud rate 115200;

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908628873-baa71895-283e-4a4b-b419-ff88f1316b1a.png)

Step 3: After the setting, input the COM port used by the computer in Saved Sessions. The following figure takes COM3 as an example, save the settings, open the serial port again later, and click on the saved port number;

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908628962-f2db0f80-37be-440b-bfa8-0faed4ebbd44.png)

Step 4: Turn on the power switch of the development board, then there will be a print message output from the serial port (no need to login).

```plain
input-event-daemon: Adding device: /dev/input/event9... input-event-daemon: Start listening on 12 devices... 

done 

root@OK-MX8MPX-C:/# [   37.424104] vbus5v0_typec0: disabling [   37.424151] vbus5v0_typec1: disabling  root@OK-MX8MPX-C:/#
```

#### 2.3.2 Serial Login Common Problems

Common problem troubleshooting points for logging in using the serial port are as follows:

**Case 1: No information is printed after connecting to the serial port:**

1. First, check whether the DIP switch is correct;
2. Re-open the serial port;
3. Change a serial port cable to test it;
4. If all of the above still does not work, check the status of the SoM's LED, if it is not a heartbeat light or does not light up, suspect that the system does not start normally, you need to check the system startup, or rewrite it!

**Case 2: Unable to input commands after connecting to the serial port:**

1. Re-open the serial port;
2. Replace the USB serial port cable with a new USB port on the computer, view the corresponding COM port in the device management, and reopen the serial port;
3. Replace a serial port cable.

**Case 3: Device Manager does not recognize the port:**

1. Serial port driver is not installed. Try to install serial port driver.

### 2.4 Network Login Methods

#### 2.4.1 Network Connection Test

 **Description:**

+ **The factory default configuration of the card is static IP; the IP address is 192.168.0.232. Please refer to "Ethernet Configuration" chapter for the static IP changing method;**
+ **The computer and board should be on the same network segment for testing.**

Before logging into the network, ensure that the direct network connection between the computer and the development board is functioning properly. You can test the connection status via pin command. The specific method is as follows:

1\. Connect the development board's eth0 interface to the computer using an Ethernet cable. Power on the board and boot the kernel. Confirm the blue heartbeat LED is blinking. Check the network card connection, ensuring its LED flashes rapidly. Once confirmed, proceed with testing the network connection;

2\. Close the computer firewall (General computer operations, not described here in detail), then open the computer's run command;

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908629029-aef97609-6a61-491d-b623-a64b29db71ae.png)

3\. Use cmd to open the administrator interface , and the ping command to test the network connection status of the computer and the development board.

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908629111-824b4802-f307-4d2d-9f27-b1f1e88b646c.png)

A data return indicates a normal network connection.

#### 2.4.2 SSH Server

 **Description:**

+ **Default factory account root for SSH login with no password;**
+ **File transfers can be performed with SCP or SFTP.**

1\. Log in to the development board with SSH, insert the network cable into the carrier board network port, and obtain the IP;

```plain
root@OK-MX8MPX-C:~# ifconfig eth1 
eth1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.1.3  netmask 255.255.255.0  broadcast 192.168.1.255
        inet6 fe80::acae:f7ff:fe61:201f  prefixlen 64  scopeid 0x20<link>
        ether ae:ae:f7:61:20:1f  txqueuelen 1000  (Ethernet)
        RX packets 10115  bytes 1090141 (1.0 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 10023  bytes 1090141 (1.0 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
root@OK-MX8MPX-C:~# 
```

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908629185-af08a7dd-e19b-430b-b898-5cc41bca3a95.png)

2\. Click "Open", the following dialog box will appear, click "Accept" to enter the login interface.

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908629320-934dd0cc-11a0-478f-b5cf-d46e540c63a7.png)

```plain
Login as：root //No password required for root login                      
root@OK-MX8MPX-C:~# 
```

#### 2.4.3 SFTP

Path: OK-MX8MPX-C-C (Linux) user profile\\tool\\FileZilla\*

The OK-MX8MPX-C development board supports SFTP service and it is automatically enabled at startup, so it can be used as an SFTP server after setting the IP address. The following describes how to utilize the FTP tool for file transfer.

Install the FileZilla tool on Windows and follow the steps shown in the image below to configure it. Use "forlinx" as both the username and password.

Open the FileZilla tool, click on File and select Site Manager.

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908629401-8a3ce9de-f9d5-48f0-b2d3-0d733333294b.png)

After successful login, you can upload and download.

### 2.5 Screen Switching

The OK-MX8MPX-C supports multiple screen interfaces such as MIPI DSI, HDMI, and LVDS, and can display different content on three screens simultaneously. Currently, there are three ways to control screen switching: dynamic control through the U-Boot menu; specification in the kernel device tree; and switching control via the Weston service in the system.

The OK-MX8MPX-C has three display controllers, namely MIPI DSI, HDMI, and LVDS, and supports a maximum of three screens to display simultaneously.

#### 2.5.1 Dynamic Control of Uboot Menu

##### **2.5.1.1 Display Type Setting**

This method switches screens without recompiling and flashing in existing supported screens.

During the uboot self-boot process, press the space bar at the serial terminal to bring up the control options:

```plain
Hit key to stop autoboot('Spacebar'):  

1: shell 
2: boot linux 
3: Display select 

0: reboot uboot
```

Enter 3 at the terminal to access the Screen Control sub-menu:

```plain
1: mipi is on 
2: lvds is on 
3: hdmi is on 

0: return 
```

Set the screen to use or close according to the options in the menu.

#### 2.5.2 Kernel Device Tree Specification

This method does not require the connection of a serial terminal, and the system image defaults to the desired configuration selection, which is suitable for mass production. However, we need to manually modify the device tree and regenerate the system image once again

**Note: This method has higher priority than the uboot screen selection, and the uboot selection will not take effect after the device tree is modified.**

Device tree path: OK-MX8-linux-kernel/arch/arm64/boot/dts/freescale/OK8MP-C.dts

In the kernel source code, open the device dtsi file and find the following node:

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908629483-9167d46f-797b-4045-b931-0fb4ef02dbc6.png)

The node has a default disabled state and needs to be changed to an okay enabled node. Change according to screen requirements.

**Note: When modifying the device tree, you need to follow the annotation rules to avoid using conflicts. The driver does not detect whether the forlinx-control configuration conforms to the rules. An error in the setting will cause abnormal display.**

**For the display interface set to "OFF", blocking, deleting, or retaining is possible.**

### 2.6 System Partition

#### 2.6.1 EMMC Memory

The following table shows the EMMC memory partition information for the OK-MX8MPX-C-C platform:

| Partition Index| Name| Offset / block| Size/block| File system| Content
|----------|----------|----------|----------|----------|----------
| 1| boot| 32K| 120M| FAT32| image OK8MP-C.dtb
| 2| rootfs| 120M| 14G+| EXT4| rootfs

Use the df command to view the disk usage on the system. The following figure shows the factory default disk partition usage:

```plain
root@OK-MX8MPX-C:~# df -Th 
Filesystem   type   Size  Used Avail Use% Mounted on
/dev/root  ext4   6.7G  5.4G  919M   86% /
devtmpfs  devtmpfs  182M  4.0K  183M  1% /dev
tmpfs     tmpfs  170M  10M  160M  6% /run
tmpfs     tmpfs  4.0M   0  4.0M   1% /sys/fs/cgroup
tmpfs     tmpfs  424M  108K  424M  1% /tmp
tmpfs     tmpfs  424M  228K  424M  1% /var/volatile
/dev/mmcblk2p1  vfat   120M  31M  89M  26% /run/media/Boot-mmcblk2p1
tmpfs     tmpfs  85M  8.0K  85M   1% /run/user/0
root@OK-MX8MPX-C:~# 

```

#### 2.6.2 DDR Memory

Use the free command to view the system memory usage. The following figure shows the factory default memory usage (1 + 8 version):

```plain
root@OK-MX8MPX-C:~# free -m
              total        used        free      shared  buff/cache   available
Mem:           847        405        116        24        441        441
Swap:          0        0        0
root@OK-MX8MPX-C:~# 
```

### 2.7 System Shutdown

In general, the power can be turned off directly. If there is data storage, function use, or other operations, avoid turning off the power arbitrarily during operation to prevent irreversible damage to the file. In such cases, only re-flashing the firmware can resolve the issue. To ensure that data is not completely written, enter the sync command to complete data synchronization before turning off the power.

Note: For products designed based on the SoM, if there are scenarios where accidental power loss causes the system to shut down unexpectedly, measures such as adding power-loss protection can be incorporated into the design.

## 3\. Desktop Function Test

**Note:**

+ **Users should follow this section when using the screen with the QT file system, but can skip it for non-QT operations;**
+ **This chapter details QT functions. With the default device and driver working normally, it's advisable to test interface functions after command line tests;**
+ **QT test program source code path: appsrc/forlinx-qt/;**
+ **Path to the test program in the development board file system: /usr/bin/fltest\_qt\_\*.**

OK-MX8MPX-C platform has excellent support for Qt, especially for multimedia-related classes, such as video decoding and playback, camera, video recording, etc. can all be combined with hardware codecs and OpenGL to achieve the best results.

This chapter mainly explains the usage of the expansion interfaces on the development board in QT interface. The testing program is only for reference, and users need to make adjustments based on their actual situations when using it.

### 3.1 Introduction to Interface Function

The desktop is displayed as follows after the board booting:

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908630898-0ce73d2e-8b84-4c31-a099-0c78cae419fb.png)

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908630975-afcec349-50c2-41d1-932a-4b8af85b1334.png)

**Note: Icon order may vary.**

### 3.2 Network Configuration Test

**Description:**

+ **By default, only the eth0 network interface (GBE1 port on the carrier board) is set to STATIC mode;**
+ **The set IP and other information will be saved to the relevant configuration file (/etc/systemd/network directory) of the system, so the network information set this time will be used every time the system is restarted.**

Icon：

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908631090-8a712dac-0c30-4a03-85a5-accb861a7f51.png)

Clicking on the network configuration icon will open a interface program that supports two modes: STATIC and DHCP.

#### 3.2.1 STATIC Mode

After clicking on the network configuration icon, select the STATIC mode as shown in the figure. You can then configure the IP address, subnet mask, gateway, and DNS settings. Once you have set the parameters, click on "Apply and Restart Network".

| Options| Description
|----------|----------
| interface| Select the network card device to be configured
| ip| Input the IP address
| netmask| Input Subnet mask:
| gateway| Input Gateway:
| dns| Input the DNS address
| Apply and Restart Network| Apply and restart the network

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908631177-7b49aa9e-fa11-4e9e-b474-161c9d1c2297.png)

#### 3.2.2 DHCP Mode

Check DHCP, select the NIC device needing to be configured, and click “Apply and Restart Network” at the bottom of the interface to restart the network and get the ip automatically.

Note: The test must be performed on a router that can automatically assign IP.

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908631274-96dc36bd-9cd3-4f99-b303-a48f83af2de8.png)

Restart the development board, and you can see that the network configuration is in effect.

### 3.3 OpenGL Test

OK-MX8MPX-C supports OpenGL ES3.2, click the desktop icon for OpenGL test.

Icon：

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908631397-5581bef3-94d5-4a7a-89f9-533c9617f5da.png)

OK-MX8MPX-C supports EGL 1.5，OpenGL ES2.0.   
Click the icon to enter the OpenGL test interface.

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908631497-4f3ed29c-f0e7-4fbd-a0d1-aa5f62c37324.png)

### 3.4 4G/5G Test

Icon：

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908631813-2be48c1b-ead5-4ca6-a227-1a7c4a5e0b8b.png)

The 4G test procedure is used to test the OK-MX8MPX-C external 4G module (EM05-CE) and 5G module (RM500Q-GL). Before the test, please power off the development board, connect the module, insert the SIM card (pay attention to the direction of the SIM card), toggle the switch (S3) to select the 4G, 5G mode, and start the development board to open the test application. This test takes 4G as an example:

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908632030-3bacd6c5-a315-4327-ae53-2b6a9d5cdc39.png)

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908632133-7d7283ef-3f76-4ec8-8916-e898a41a5743.png)

Click the CONNECT button then the program will automatically enter the dialing process and get the IP to set the DNS, etc. After waiting patiently for a few seconds, click the ping button to test it.

### 3.5 UART Test

Icon：

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908632225-59ce1a94-95c4-4194-ae0a-064a94dccce2.png)

1. Click the UART test icon to enter the test application interface, click the gear icon setting button in the upper left corner, and set the serial port parameters as shown in the figure below:

| Options| Description
|----------|----------
| Select Serial Port| Select the serial port to use
| Baudrate| Select the serial port baud rate
| Data bits| Select data bit
| Parity| Select parity bit
| Stop bits| Select stop bit
| Flow control| Select flow control
| Apply| Application Settings:

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908632318-b7bb2f82-aa89-4e34-afe9-7a019f155bc5.png)

2. After setting the serial port parameters, click the connect button in the upper left corner, then the program can conduct data sending and receiving tests;
3. Run the serial port send test command in the terminal. The received data will be displayed on the screen;

```plain
root@OK-MX8MPX-C:~# fltest_uarttest -d /dev/ttymxc2  -w		tx_0: XEiNKcpIXrzQF4t9PqirDCTqWKgLnKoK									 
```

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908632394-5a69db66-531e-4621-8556-0726d8d759b3.png)

4. Run the serial port receive test command in the terminal. When you click the test interface, a virtual keyboard will appear. After entering 32 consecutive characters, the terminal will print the data sent by QT.

```plain
root@OK-MX8MPX-C:~# fltest_uarttest -d /dev/ttymxc2  -r		rx_0: 12345678901234567890123456789012									 
```

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908632461-a65527bd-415b-4444-8a5b-9d23a100c711.png)

**Note: The data input by the soft keyboard will not be displayed on the test interface until the Enter key is pressed.**

### 3.6 WIFI Test

 **Description:**

+ **The OK - MX8MPX - C SoM is soldered with an AW - CM276NF WiFi chip, and its operating frequency supports 2.4 GHz/5 GHz.**

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908632533-1a0fb928-be88-47b3-a2fb-d311d166c4b4.png)

1. Click the WIFI test icon to enter the test application interface. Select the corresponding module from the drop - down menu. Enter the name of the router you need to connect to via WiFi in the SSID field, and enter the router password in the PAWD field. Then click “connect” to connect to the router via WiFi;

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908632607-4a18a4da-d73c-47aa-99bb-ea43b0c97104.png)

2. After a successful connection, click the ping button to check if the currently used WiFi network is working properly;

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908632681-3a8abb1d-192a-41b1-8c1d-08a5538068ea.png)

### 3.7 RTC Test

**Note: Ensure that button cell batteries are installed on the board and the battery voltage is normal Icon：**

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908632742-835fab74-76c5-4411-ad6e-301f3f18787b.png)

RTC test includes setting time, power cycling, rerunning test software, and verifying RTC sync.   
Run the RTC test software to view and set the current system time with the following interface:

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908632837-8c33abed-d0dc-4035-9085-feba7da0f129.png)

Click “set” to adjust the time settings, then click “save” to finish the settings. After powering off and waiting, reboot and rerun the RTC test software to synchronize and confirm the RTC test is normal.

### 3.8 Watchdog Test

Icon：

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908632914-4afffdf5-7cd7-42cc-b7c2-dc78bb22038f.png)

“WatchDog" tests the functionality of the watchdog feature. Interface as follows:

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908633005-4fd1369a-945e-483b-ac5c-e01942447ec3.png)

Check feed dog and click the open watchdog key, then the watchdog will be activated, the program will carry out the feeding operation, and the system will not reboot under normal circumstances; when unchecking feed dog and clicking open watchdog key, the watchdog function will be activated, the program will not carry out the feeding operation, and the system enters into a reboot after the watchdog is activated for about 10s, which indicates that the watchdog function is normal.

### 3.9 Ping Test

Icon：

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908633087-9e74fa75-046e-46ff-9ede-84a608f0f10f.png)

"Ping" is a graphical tool for network testing, offering a user-friendly interface for ping operations.

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908633156-777ca5ff-ea67-4eab-9c6c-61504ea86d7c.png)

Write the target ip needing ping in the hostname field;  after clicking the ping button, the RESULT column will indicate the result, click stop to end the ping test and clear to clean the information in the result.   
As shown in the figure, the network connection is smooth.

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908633233-f293a788-8298-4acd-a9f1-2a402954d297.png)

### 3.10 Camera Test

Icon：

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908633293-be4e7d27-9f8f-4067-b821-0ba412e9e016.png)

Click the icon to enter the camera test program and insert the USB camera.   
Note: If the CSI ov5645 camera is used, please disconnect the power and plug it; the current test program does not support basler \_ camera.![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908633381-248dc298-466e-4f31-8e6b-daeee9da4e3c.png)

Choose the camera video device node;

Set the camera resolution;

Click "Start" to capture video;

Click "Stop" to end capture;

Click "Picture" to take a photo;

Save the photo with a name and at a chosen path.   
Take the Logitech UVC camera as an example to conduct the camera test.

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908633468-ddec3c6f-ddba-409e-a58f-7fe1c2a9b96f.png)

After Start, click the picture button to take a picture, the file save directory is /home/root/, and the format is jpg, please select the appropriate tool on Windows to view.

### 3.11 Backlight Test

Icon：

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908633569-d1c1e3ac-1b29-4787-a041-8d0557be757d.png)

“BackLight” is a backlight adjustment application. You can adjust the backlight brightness by dragging the progress bar left or right. Here, “dsi” is used to set the brightness of the MIPI - DSI screen, and “lvds” is for setting the brightness of the LVDS screen. After clicking to open it, the interface is as follows:

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908633636-357897b4-2589-434e-898f-576405e10e13.png)

You can set the backlight brightness of the corresponding screen by dragging the slider for that screen on the interface. Level 1 represents the lowest brightness, and 255 represents the highest brightness. Forlinx has made restrictions on this application. It is not allowed to use the QT application to completely turn off the backlight. If you want to completely turn off the backlight, please use the command line program or modify the QT test routine.

### 3.12 Play/Record Test

Icon：

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908633748-e1894519-d98c-4905-8d12-395a8bbe9cd8.png)

Before the recording test, please insert the prepared microphone or earphone with microphone into the 3.5mm interface, and click the icon to enter the recording test application, which can be used to test whether the recording function of the sound card is normal.   
Select the location to save the recording file, press the "Start" button to start recording, press the "Stop" button to stop recording, click the Audio Codec radio box to select "Wave", click the FILE Container radio box to select "Wave File", click the Channels radio box to select 2, and the interface is as follows:

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908633821-a22bfcce-452a-49cc-a0e8-ce480b110b66.png)

Click the Record button to test the recording. The recording file is saved to the/tmp/record \_ \*.wav file in the root directory.

### 3.13 Music Playback Test

Icon：

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908633897-abce7818-1aed-4210-8b05-e8a7824c1c68.png)

"music player" is a simple audio test application that can be used to test the function of the sound card or as a simple audio player. To switch the default playback device before use, click to select the fourth item; open the playback file, click the button in the lower left corner, select test audio/home/forlinx/audio/30s.mp3, and click to play after loading.

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908633973-bafc76d6-9d8d-4bba-94fd-3c9cbe3aaea9.png)

### 3.14 Qml Video Playback Test

Icon：

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908634040-24559968-bbc2-4b81-8504-712576e1f714.png)

Qml Video supports video playback in H264 and H265 formats, with a maximum of 1080p 60fps.   
The qml video test program can play video based on qml. Click the icon to enter the test program interface.

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908634145-dfcb6a62-cea4-47f6-b317-d7fd85205027.png)

Click Select File 1 at the top to select the video file. The path of the test video file is shown in the following figure:

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908634224-bb32c2f6-105e-4636-a215-7f860dd6aca2.png)

Click Full Screen-inverted to start playing the video in full screen.

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908634315-28a314a1-358c-470a-a1a0-6b7572aa8556.png)

### 3.15 Browser Test

Icon：

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908634389-89a34a8a-2b07-4ae5-9486-4b1826841153.png)

**Note: Before testing, check whether the time of the development board is accurate. If the time of the development board is abnormal, it will cause certificate problems. Check the network.**

Click the icon to enter the browser interface and enter the official website of forlinx by default.

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908634478-3eebeac7-ca0d-48dd-a2c1-2bd9c58403f7.png)

## 4\. Command Line Function Test

The OK-MX8MPX-C platform has various built-in command line tools available to users.   
FORLINX test program source code path: OK-MX8-linux-sdk/appsrc/forlinx-cmd

Test program path:/usr/bin

### 4.1 System Information Query

To view kernel and cpu information, enter the following command

```plain
root@OK-MX8MPX-C:~# uname -a
Linux OKMX8MPX-C 6.1.36 #1 SMP PREEMPT Fri Feb 14 10:27:56 CST 2025 aarch64 GNU/Linux
```

View operating system information:

```plain
root@OK-MX8MPX-C:~# cat /etc/issue
|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
||        ||||       ||||         |||||  ||||||||||  |||   |||||  |||   ||||   ||||||||||||||||||
||  |||||||||   |||   |||  |||||   ||||  ||||||||||  |||    ||||  ||||   ||   |||||||||||||||||||
||  |||||||||  |||||  |||  |||||   ||||  ||||||||||  |||  |  |||  |||||      ||||||||||||||||||||
||        |||  |||||  |||         |||||  ||||||||||  |||  ||  ||  ||||||    |||||||||||||||||||||
||  |||||||||  |||||  |||  ||||  ||||||  ||||||||||  |||  |||  |  |||||  ||  ||||||||||||||||||||
||  |||||||||   |||   |||  |||||  |||||  ||||||||||  |||  ||||    ||||   |||  |||||||||||||||||||
||  ||||||||||       ||||  ||||||  ||||        ||||  |||  |||||   |||   ||||   ||||||||||||||||||
|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

Welcome to forlinx OKMX8MPX-C \l

```

To view CPU information:

```plain
root@OK-MX8MPX-C:~# cat /proc/cpuinfo
pprocessor	: 0
BogoMIPS	: 16.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer	: 0x41
CPU architecture: 8
CPU variant	: 0x0
CPU part	: 0xd03
CPU revision	: 4

processor	: 1
BogoMIPS	: 16.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer	: 0x41
CPU architecture: 8
CPU variant	: 0x0
CPU part	: 0xd03
CPU revision	: 4

processor	: 2
BogoMIPS	: 16.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer	: 0x41
CPU architecture: 8
CPU variant	: 0x0
CPU part	: 0xd03
CPU revision	: 4

processor	: 3
BogoMIPS	: 16.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer	: 0x41
CPU architecture: 8
CPU variant	: 0x0
CPU part	: 0xd03
CPU revision	: 4

```

View environment variable information:

```plain
root@OK-MX8MPX-C:~# env
SHELL=/bin/sh
EDITOR=vi
QTWEBENGINE_DISABLE_SANDBOX=1
PWD=/home/root
LOGNAME=root
XDG_SESSION_TYPE=tty
MOTD_SHOWN=pam
HOME=/home/root
LANG=en_US.utf8
WAYLAND_DISPLAY=/run/wayland-0
QT_QPA_PLATFORM=wayland
XDG_SESSION_CLASS=user
TERM=linux
USER=root
SHLVL=1       
XDG_SESSION_ID=c2
XDG_RUNTIME_DIR=/run/user/0
PS1=\u@\h:\w\$ 
LC_ALL=en_US.utf8
HUSHLOGIN=FALSE
PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin
DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/0/bus
MAIL=/var/spool/mail/root
_=/usr/bin/env

```

### 4.2 Frequency Test

**Note: This process changes all CPU cores at the same time.**

1. All cpufreq governor types supported in the current kernel:

```plain
root@OK-MX8MPX-C:~# cat \
/sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors
conservative ondemand userspace powersave performance schedutil
```

The default mode is ondemand. In this mode, the CPU frequency will be adjusted according to the demand. Check the current CPU freq governor type:

The userspace indicates user mode, in which other users' programs can adjust the CPU frequency.

```plain
root@OK-MX8MPX-C:~# cat /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
ondemand
```

2. View the current CPU frequency:

```plain
root@OK-MX8MPX-C:~# cat /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq
1200000
```

3. View the current CPU supported frequency level.

```plain
root@OK-MX8MPX-C:~# cat \
/sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies
1200000 1600000
```

4. Set to user mode and modify the frequency to 1600000：

```plain
root@OK-MX8MPX-C:~# echo userspace > \
/sys/devices/system/cpu/cpufreq/policy0/scaling_governor
root@OK-MX8MPX-C:~# echo 1600000 > \
/sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed
```

View the modified current frequency:

```plain
root@OK-MX8MPX-C:~# cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
1600000
```

### 4.3 Temperature Test

View the temperature value:

```plain
root@OK-MX8MPX-C:~# cat /sys/class/thermal/thermal_zone0/temp
53000
```

The temperature value is 53°C.

### 4.4 DDR Bandwidth Test

```plain
root@OK-MX8MPX-C:~# fltest_memory_bandwidth.sh
L1 cache bandwidth rd test with # process
0.008192 22213.07
0.008192 22213.07
0.008192 22245.45
0.008192 22425.28
0.008192 22193.52
L2 cache bandwidth rd test
0.131072 9658.94
0.131072 9634.51
0.131072 9614.31
0.131072 9633.09
0.131072 9647.43
Main mem bandwidth rd test
52.43 2505.68
52.43 2520.25
52.43 2506.16
52.43 2521.10
52.43 2523.28
L1 cache bandwidth wr test with # process
0.008192 19523.07
0.008192 19521.65
0.008192 19508.88
0.008192 19514.58
0.008192 19512.42
L2 cache bandwidth wr test
0.131072 11418.06
0.131072 11171.86
0.131072 11184.50
0.131072 10466.82
0.131072 11241.37
Main mem bandwidth wr test
52.43 1005.48
52.43 1006.06
52.43 1006.66
52.43 1005.79
52.43 1006.31
```

The lpDDR4 bandwidth of the OK-MX8MPX-C is shown above, with a read bandwidth of about 2500M/s and a write bandwidth of about 1000M/s.

### 4.5 Watchdog Test

Watchdog is a frequently used function in embedded systems, and the device node for the watchdog in OK-MX8MPX-C is /dev/watchdog.

Use fltest\_watchdog to start the watchdog, set the reset time to 10s, and feed the dog regularly. This command will turn on the watchdog and perform the dog-feeding operation, so the system will not reboot.

```plain
root@OK-MX8MPX-C:~# fltest_watchdog -t10 -c
Watchdog Ticking Away!
```

When ctrl + C is used to end the test procedure, the dog feeding is stopped, the watchdog is in the open state, and the system is reset after 10s; If you do not want to reset, please enter the command to close the watchdog within 10 seconds after the end of the program:

```plain
root@OK-MX8MPX-C:~# fltest_watchdog -d                      //Turn off the watchdog
```

Start the watchdog, set the reset time for 10s, and do not feed the dog. This command turns on the watchdog, but does not feed the dog, and the system restarts after 10 seconds.

```plain
root@OK-MX8MPX-C:~# fltest_watchdog -t10 -e
```

### 4.6 RTC Function Test

**Note: Ensure that button cell batteries are installed on the board and the battery voltage is normal.**

OK-MX8MPX-C supports two models of RX8010SJ, PCF8563T RTC chips, with RX8010SJ RTC on-board by default.   
RTC testing is mainly done by using the date and hwclock tools to set the software and hardware time. The test checks if the software clock can read and synchronize with the RTC clock when the development board is powered off and on again (Note: Make sure that the button battery is already installed on the board).

```plain
root@OK-MX8MPX-C:~# date -s "2024-03-22 11:59:30"           // Set the software time
Fri Mar 22 11:59:30 AM CST 2024
root@OK-MX8MPX-C:~# hwclock -w           // Synchronize the software time to the hardware time
root@OK-MX8MPX-C:~# hwclock -r                       // Display the hardware time
2024-03-22 12:00:07.037836+08:00
```

Then power off and power on the development board, read the system time after entering the system, and you can see that the time has been synchronized.

```plain
root@OK-MX8MPX-C:~# date
Fri Mar 22 12:01:22 PM CST 2024
```

### 4.7 RS485 Test

OK8MP platform UART3 is used as RS485. In this section, another mx8mpx-c mainboard is used to connect 485 serial port for transceiver test when testing 485 function.  
![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908635952-b091aa49-1d7b-423a-bae5-0f24929bdbc1.png)

The receiving end prints as follows:

```plain
root@OK-MX8MPX-C:~# fltest_uarttest -d /dev/ttymxc2 -r &
[2]1166
tx_0: wmfUOEUt097eLdSudH1ByJCY67DOP0DL
rx_0: wmfUOEUt097eLdSudH1ByJCY67DOP0DL
[2]+  Done                    fltest_uarttest -d /dev/ttymxc0 -r
```

The sending end prints as follows:

```plain
root@OK-MX8MPX-C:~# fltest_uarttest -d /dev/ttymxc2 -w
tx_0: wmfUOEUt097eLdSudH1ByJCY67DOP0DL
```

### 4.8 PCIE Test

Before powering on the system, insert the PCIE module into the PCIE x 1 card slot on the carrier board. After powering on and starting Linux, you can see that the corresponding device is enumerated successfully through lspci. Taking the Intel 82574L NIC as an example, the successful enumeration is shown below:

```plain
root@OK-MX8MPX-C:~# lspci
00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller
```

Due to the many types of pcie devices, it may not be supported by the kernel by default, so you need to add the corresponding driver for the compiled device by yourself.

### 4.9 TF Card Test

**Note:**

+ **The SD card mount directory is /run/media/ and supports hot-swapping;**
+ **The file system of NTFS format is not supported. If the format of TF card is not clear, it is recommended to format it to FAT32 format before use;**
+ **After inserting the TF card, the device node is "/dev/mmcblk1 \*".**

1\. Insert the TF card into the TF card slot on the carrier board. The printed information is as follows:

```plain
[ 4075.276047] mmc1: host does not support reading read-only switch, assuming write-enable
[ 4075.311963] mmc1: new ultra high speed SDR104 SDHC card at address 5048
[ 4075.328510] mmcblk1: mmc1:5048 SD32G 29.7 GiB 
[ 4075.334519]  mmcblk1: p1
```

2\. Check the mount directory:   
The TF card mount directory is as follows:

```plain
root@OK-MX8MPX-C:~# ls /run/media/               //List files in the/run/media directory
Boot-mmcblk2p1/ mmcblk1p1/
```

3\. Write test:   
**Note: Please ensure that there is enough space in the TF card partition before writing.**

```plain
root@OK-MX8MPX-C:~# dd if=/dev/zero of=/run/media/mmcblk1p1/test.bin \
bs=1M count=200 conv=fsync oflag=direct
200+0 records in
200+0 records out
209715200 bytes (210 MB, 200 MiB) copied, 2.73121 s, 76.8 MB/s
```

4\. Read test:   
**Note: To ensure the accuracy of the data, please restart the development board to test the reading speed.**

```plain
root@OK-MX8MPX-C:~# dd if=/run/media/mmcblk1p1/test.bin of=/dev/null \
bs=1M count=200 iflag=direct
200+0 records in
200+0 records out
209715200 bytes (210 MB, 200 MiB) copied, 2.30143 s, 91.1 MB/s
```

5\. Unstall TF card   
After using the TF card, uninstall it with umount before ejecting it.   
**Note: Plug and unplug the TF card after exiting the TF card mounting path.**

```plain
root@OK-MX8MPX-C:~# umount /run/media/mmcblk1p1
```

### 4.10 EMMC Test

OK-MX8MPX-C platform eMMC runs in HS200 mode 200MHz clock by default. The following is a simple eMMC read/write speed test: taking the read/write ext4 file system as an example.

Write test:

```plain
root@OK-MX8MPX-C:~# dd if=/dev/zero of=/data.img bs=1M count=500 conv=fsync oflag=direct
500+0 records in
500+0 records out
524288000 bytes (524 MB, 500 MiB) copied, 4.43111 s, 118 MB/s
```

Read test:   
**Note: To ensure the accuracy of the data, please restart the development board to test the reading speed.**

```plain
root@OK-MX8MPX-C:~# dd if=/data.img of=/dev/null bs=1M count=500 iflag=direct
500+0 records in
500+0 records out
524288000 bytes (524 MB, 500 MiB) copied, 2.80064 s, 187 MB/s
```

### 4.11 USB3.0 Test

OK-MX8MPX-C supports two USB3.0 Type-A interfaces. You can connect USB mouse, USB keyboard, U disk and other devices on any on-board USB HOST interface, and support hot plug of the above devices. Demonstration with a mounting USB flash drive; the current USB flash drive test support up to 32G, but no test for 32G or above.   
Description**:**

+ **Support hot plug of U disk device;**
+ **If NTFS isn't supported and you're unsure of the USB drive's format, it's best to format it to FAT32 before using it.**

#### 4.11.1  USB Mouse Test

Connect the USB mouse to the USB interface of the OK-MX8MPX-C platform, and the print information of the serial port terminal is as follows:

```plain
[ 4111.459770] usb 3-1.2: new low-speed USB device number 6 using xhci-hcd
[ 4111.536111] input: SiGmaMicro USB Optical Mouse as /devices/platform/soc@0/32f10108.usb/38200000.usb/xhci-hcd.1.auto/usb3/3-1/3-1.2/3-1.2:1.0/0003:1C4F:0057.0001/input/input6
[ 4111.552509] hid-generic 0003:1C4F:0057.0001: input: USB HID v1.10 Mouse [SiGmaMicro USB Optical Mouse] on usb-xhci-hcd.1.auto-1.2/input0
[ 4123.853117] usb 3-1.2: USB disconnect, device number 6
```

At this time, the arrow cursor appears on the screen, the mouse can work normally.   
Next, take the U disk as an example for demonstration.   
The terminal prints information about the USB flash drive, and since many types of USB flash drives exist, the information displayed may vary:

#### 4.11.2  USB U Disk Test

1. After the development board is started, insert the USB disk into the USB2.0 host interface of the development board.   
Serial port information:

```plain
[  343.438673] usb 3-1.1: new hig5h-speed USB device number 4 using xhci-hcd
[  343.547026] usb-storage 3-1.1:1.0: USB Mass Storage device detected
[  343.553832] scsi host0: usb-storage 3-1.1:1.0
[  344.581363] scsi 0:0:0:0: Direct-Access     SCSI     DISK             1.00 PQ: 0 ANSI: 4
[  344.590662] sd 0:0:0:0: [sda] 31223936 512-byte logical blocks: (16.0 GB/14.9 GiB)
[  344.598526] sd 0:0:0:0: [sda] Write Protect is off
[  344.603887] sd 0:0:0:0: [sda] No Caching mode page found
[  344.609236] sd 0:0:0:0: [sda] Assuming drive cache: write through
[  344.617388]  sda: sda1
[  344.620171] sd 0:0:0:0: [sda] Attached SCSI removable disk
```

2. View the mount directory:

```plain
root@OK-MX8MPX-C:~# ls /run/media/
Boot-mmcblk2p1  sda1
```

3. View the contents of the USB flash drive:

```plain
root@OK-MX8MPX-C:~# ls -l /run/media/sda1
total 4096000
-rwxrwx--- 1 root disk 4194304000 Mar 22 16:34 test
```

4. Write test:

```plain
root@OK-MX8MPX-C:~# dd if=/dev/zero of=/run/media/sda1/test bs=100M count=40 \
conv=fsync oflag=direct
40+0 records in
40+0 records out
4194304000 bytes (4.2 GB, 3.9 GiB) copied, 354.351 s, 11.8 MB/s
```

5. Read test:

```plain
root@OK-MX8MPX-C:~# dd if=/run/media/sda1/test of=/dev/null bs=100M iflag=direct
40+0 records in
40+0 records out
4194304000 bytes (4.2 GB, 3.9 GiB) copied, 172.192 s, 24.4 MB/s
```

6. Ustall U disk:

```plain
root@OK-MX8MPX-C:~# umount /run/media/sda1
```

#### 4.11.3 USB to UART Test

The OK-MX8MPX-C board is equipped with a USB-to-UART chip XR21V1414IM48. The board positions P35, P36, P37, and P39 correspond to tty device names /dev/ttyUSB0, /dev/ttyUSB1, /dev/ttyUSB2, and /dev/ttyUSB3, respectively.

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908636034-008700c5-4d87-4b92-8000-fc114dc195fa.png)

Test method: short circuit TXD and RXD.

Serial port information:

```plain
root@OK-MX8MPX-C:~#fltest_uarttest -d /dev/ttyUSB0
tx_0: 0ATU5pD9GsfkEZpBJHmsC4t67A9MdWLd
rx_0: 0ATU5pD9GsfkEZpBJHmsC4t67A9MdWLd
root@OK-MX8MPX-C:~# fltest_uarttest -d /dev/ttyUSB1
tx_0: xbF1XSMlrOp4DGMm5iZKV1RE30Oevywq
rx_0: xbF1XSMlrOp4DGMm5iZKV1RE30Oevywq
root@OK-MX8MPX-C:~# fltest_uarttest -d /dev/ttyUSB2
tx_0: heQlRFobDQQzNzpIJ2S2aVghweqbHXXz
rx_0: heQlRFobDQQzNzpIJ2S2aVghweqbHXXz
root@OK-MX8MPX-C:~# fltest_uarttest -d /dev/ttyUSB3
tx_0: BUhEYVJ6hjUg0TohEb4PrIuiKgDZS55c
rx_0: BUhEYVJ6hjUg0TohEb4PrIuiKgDZS55c
```

#### 4.11.4 OTG Test

The OK-MX8MPX-C includes a OTG-C port, which can be used in Device mode for brushing, and Host mode for plugging in regular USB devices. When connecting the OK8MP-C to a PC using a Micro USB cable, the OK8MP-C will automatically configure the OTG interface as Device mode. Similarly, when connecting a USB flash drive or other devices using an OTG cable, the system will automatically configure the OTG interface as Host mode.

1. Serial port information:

```plain
[  109.407327] usb 1-1: new high-speed USB device number 2 using xhci-hcd
[  109.564425] usb-storage 1-1:1.0: USB Mass Storage device detected
[  109.571876] scsi host0: usb-storage 1-1:1.0
[  110.597987] scsi 0:0:0:0: Direct-Access      USB      SanDisk 3.2Gen1 1.00 PQ: 0 ANSI: 6
[  110.607733] sd 0:0:0:0: [sda] 60125184 512-byte logical blocks: (30.8 GB/28.7 GiB)
[  110.616255] sd 0:0:0:0: [sda] Write Protect is off
[  110.621442] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  110.645161]  sda: sda1
[  110.647846] sd 0:0:0:0: [sda] Attached SCSI removable disk
```

2. View the mount directory:

```plain
root@OK-MX8MPX-C:~# ls /run/media/
Boot-mmcblk2p1  sda1
```

"sda1" represents the first partition of the first USB storage device inserted, and so forth.

3. Write test: Write speeds are limited by the specific storage device:

```plain
root@OK-MX8MPX-C:~# dd if=/dev/zero of=/run/media/sda1/test bs=100M count=40 \
conv=fsync oflag=direct
40+0 records in
40+0 records out
4194304000 bytes (4.2 GB, 3.9 GiB) copied, 283.871 s, 14.8 MB/s
```

4. Read test:

```plain
root@OK-MX8MPX-C:~# dd if=/run/media/sda1/test of=/dev/null bs=100M iflag=direct
40+0 records in
40+0 records out
4194304000 bytes (4.2 GB, 3.9 GiB) copied, 131.639 s, 31.9 MB/s
```

5. Ustall U disk:

```plain
root@OK-MX8MPX-C:~# umount /run/media/sda1
```

The on - board Type - C port can be used as either a host or a device. Connect the Type - C port of the development board to a PC with a suitable USB cable, and then execute the following commands:

```plain
root@OK-MX8MPX-C:~# insmod /lib/modules/`uname -a | awk '{print \
$3}'`/kernel/drivers/usb/gadget/legacy/g_mass_storage.ko removable=1 file=/dev/mmcblk2p1
[   75.704385] Mass Storage Function, version: 2009/09/11
[   75.709558] LUN: removable file: (no medium)
[   75.713949] LUN: removable file: /dev/mmcblk2p1
[   75.718497] Number of LUNs=1
[   75.721498] g_mass_storage gadget.0: Mass Storage Gadget, version: 2009/09/11
[   75.728659] g_mass_storage gadget.0: userspace failed to provide iSerialNumber
[   75.735954] g_mass_storage gadget.0: g_mass_storage ready
```

You will find that the PC will mount the first partition of the eMMC as a USB flash drive.

### 4.12 Network Test

Ethernet Configuration

The OK - MX8MPX - C board is equipped with two Gigabit network cards. When you insert an Ethernet cable to connect to the network, by default, the Gigabit network card for eth0 is configured with a static IP address of 192.168.0.232 at the time of factory shipment. The network card of OK-MX8MPX-C can be configured through the configuration file /etc/systemd/network/10-eth.network.   
**Note: eth0, eth1 are different from the carrier board screen printing. eth0 corresponds to the eth1 port on the carrier board, and eth1 corresponds to the eth2 port.**

#### 4.12.1 Gigabit Network Static IP Configuration

**Description:**

+ **The Gigabit Ethernet cards in the kernel are eth0 and eth1, and the default IP of eth0 is 192.168.0.232. After the development board is powered on and started normally, execute the following command to open the network configuration file/etc/systemd/network/10-eth. network.**

```plain
root@OK-MX8MPX-C:~# vi /etc/systemd/network/10-eth.network
```

Modify the followings:

```plain
[Match]
Name=eth0
KernelCommandLine=!root=/dev/nfs

[Network]
Address=192.168.0.232/24
Gateway=192.168.0.1
DNS=114.114.114.114
```

Parameter Description:

| Parameter| Description
|----------|----------
| Name| NIC: eth0 and eth1
| KernelCommandLine| The kernel parameter !root=/dev/nfs is used to disable NFS (Network File System) mounting. Otherwise, it may cause the network to fail to start.
| Address| Static IP: 192.168.0.232/24
| Gateway| Gateway address: 192.168.0.1
| DNS| DNS Server:114.114.114.114

Save and exit, execute the following command to make the configuration effective:

```plain
root@OK-MX8MPX-C:~# systemctl restart systemd-networkd
```

Execute the ifconfig command to view the IP address of the network card:

```plain
root@OK-MX8MPX-C:~# ifconfig eth0
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.0.232  netmask 255.255.255.0  broadcast 192.168.0.255
        inet6 fe80::21d:9bff:fe8a:7d0c  prefixlen 64  scopeid 0x20<link>
        ether 00:0c:42:a1:0b:58  txqueuelen 1000  (Ethernet)
        RX packets 10202  bytes 1022041 (1.0 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 10061  bytes 1022041 (1.0 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

#### 4.12.2  Internet Speed Test

**Description:**

+ **Test the communication speed between the development board and the computer to ensure that they can communicate properly;**
+ **It is assumed that the iperf3 tool has been installed on Windows for this test. Use the network speed testing tool iperf3 to test the network speed of the eth1 interface on the OK - MX8MPX - C carrier board.** 
Run iperf3 in server mode from the cmd command terminal on Windows:

```plain
D:\iperf-3.1.3-win64\iperf-3.1.3-win64>iperf3.exe -s
```

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908636101-5162ea38-5f80-4fcf-a6cc-97caf4a3b735.png)

Connect the network cable to the eth1 interface. After the system starts, eth1 will automatically obtain an IP address. Then, enter the following command in the OK-MX8MPX-C serial debugging terminal:

```plain
root@OK-MX8MPX-C:~# iperf3 -c 192.168.1.16       //Please fill in the server IP address according to the actual situation
Connecting to host 192.168.1.16, port 5201
[  5] local 192.168.1.19 port 54274 connected to 192.168.1.16 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   114 MBytes   956 Mbits/sec    0    227 KBytes       
[  5]   1.00-2.00   sec   113 MBytes   952 Mbits/sec    0    227 KBytes       
[  5]   2.00-3.00   sec   113 MBytes   949 Mbits/sec    0    227 KBytes       
[  5]   3.00-4.00   sec   113 MBytes   950 Mbits/sec    0    227 KBytes       
[  5]   4.00-5.00   sec   113 MBytes   947 Mbits/sec    0    227 KBytes       
[  5]   5.00-6.00   sec   113 MBytes   950 Mbits/sec    0    227 KBytes       
[  5]   6.00-7.00   sec   113 MBytes   948 Mbits/sec    0    227 KBytes       
[  5]   7.00-8.00   sec   113 MBytes   951 Mbits/sec    0    227 KBytes       
[  5]   8.00-9.00   sec   113 MBytes   949 Mbits/sec    0    227 KBytes       
[  5]   9.00-10.00  sec   113 MBytes   950 Mbits/sec    0    227 KBytes       
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  1.11 GBytes   950 Mbits/sec    0             sender
[  5]   0.00-10.00  sec  1.11 GBytes   949 Mbits/sec                  receiver                 
[root@OK-MX8MPX-C:~# iperf3 -s
-----------------------------------------------------------
Server listening on 5201 (test #1)
-----------------------------------------------------------
Accepted connection from 192.168.1.16, port 50890
[  5] local 192.168.1.19 port 5201 connected to 192.168.1.16 port 50891
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec   111 MBytes   929 Mbits/sec                  
[  5]   1.00-2.00   sec   112 MBytes   942 Mbits/sec                  
[  5]   2.00-3.00   sec   112 MBytes   942 Mbits/sec                  
[  5]   3.00-4.00   sec   112 MBytes   941 Mbits/sec                  
[  5]   4.00-5.00   sec   112 MBytes   942 Mbits/sec                  
[  5]   5.00-6.00   sec   112 MBytes   942 Mbits/sec                  
[  5]   6.00-7.00   sec   112 MBytes   942 Mbits/sec                  
[  5]   7.00-8.00   sec   112 MBytes   942 Mbits/sec                  
[  5]   8.00-9.00   sec   112 MBytes   943 Mbits/sec                  
[  5]   9.00-10.00  sec   112 MBytes   942 Mbits/sec                  
[  5]  10.00-10.02  sec  1.78 MBytes   940 Mbits/sec                  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-10.02  sec  1.10 GBytes   941 Mbits/sec                  receiver
-----------------------------------------------------------
Server listening on 5201 (test #2)
-----------------------------------------------------------
```

The upload bandwidth of the gigabit network of the OK - MX8MPX - C is 950Mbps, and the download bandwidth is 941Mbps. 

### 4.13 Network Test

 **Note: The default IP for eth0 is 192.168.0.232**.

#### 4.13.1 Web Test

**Note: The IP address of the PC needs to be in the same network segment as that of the development board for this function to work properly.**

The OK - MX8MPX - C development board comes pre - installed with the lighttpd web server, and the lighttpd service is automatically started when the system boots. You can browse the web pages on the development board’s web server by entering the IP address of the development board in your browser, as shown in the following figure:![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908636170-8969ca12-fac1-4ecd-828e-49810dcb8396.png)

### 4.14 WiFi/BT Test

#### 4.14.1 WIFI- STA Mode Test

Before using the wifi function, the following steps are required for configuration:   
Step 1: 	  
Assume that the SSID of the Wi - Fi hotspot is “H3C\_708\_5G” and the password is “123456785”.

```plain
root@OK-MX8MPX-C:~# fltest_wifi.sh -i mlan0 -s "H3C_708_5G" -p 123456785.
```

Enter the following command in the terminal of the development board:

In the above command:

-i wlan0 or wlan1. You need to determine which node corresponds to which module before use, and it should be based on the actual situation.

-s is followed by the actual name of the Wi - Fi hotspot to connect to.

-p is followed by the parameter “Password”, which refers to the actual password of the Wi - Fi hotspot to connect to. If the current hotspot has no password, write “NONE” after -p.

The serial port prints the following information:

```plain
root@OK-MX8MPX-C:~# fltest_wifi.sh -i mlan0 -s "H3C_708_5G" -p 123456785.
wifi mlan0
ssid H3C_708_5G
pasw 123456785.
[   73.761070] wlan: mlan0 START SCAN
[   78.059019] wlan: SCAN COMPLETED: scanned AP count=7
[   78.068583] wlan: HostMlme mlan0 send auth to bssid 14:XX:XX:XX:fc:87
[   78.075825] mlan0: 
[   78.075835] wlan: HostMlme Auth received from 14:XX:XX:XX:fc:87
[   78.087861] CMD_RESP: cmd 0x121 error, result=0x2
[   78.092603] IOCTL failed: 00000000d9a07460 id=0x200000, sub_id=0x200024 action=2, status_code=0x3
[   78.101486] Get multi-channel policy failed
[   78.111228] wlan: HostMlme mlan0 Connected to bssid 14:XX:XX:XX:fc:87 successfully
[   78.120878] mlan0: 
[   78.120891] wlan: Send EAPOL pkt to 14:XX:XX:XX:fc:87
[   78.129770] mlan0: 
[   78.129784] wlan: Send EAPOL pkt to 14:XX:XX:XX:fc:87
[   78.138534] IPv6: ADDRCONF(NETDEV_CHANGE): mlan0: link becomes ready
[   78.145865] woal_cfg80211_set_rekey_data return: gtk_rekey_offload is DISABLE
udhcpc: started, v1.36.1
Dropped protocol specifier '.udhcpc' from 'mlan0.udhcpc'. Using 'mlan0' (ifindex=6).
[   79.798744] imx-dwmac 30bf0000.ethernet eth1: FPE workqueue stop
[   79.893164] imx-dwmac 30bf0000.ethernet eth1: yt8521_config_init done, phy addr: 1, chip mode = 0, polling mode = 2
[   79.903659] imx-dwmac 30bf0000.ethernet eth1: PHY [stmmac-0:01] driver [YT8521 Ethernet] (irq=POLL)
[   79.912748] imx-dwmac 30bf0000.ethernet eth1: configuring for phy/rgmii-id link mode
udhcpc: broadcasting discover
udhcpc: broadcasting select for 192.168.1.32, server 192.168.1.1
udhcpc: lease of 192.168.1.32 obtained from 192.168.1.1, lease time 86400
/etc/udhcpc.d/50default: Adding DNS 192.168.1.1
Dropped protocol specifier '.udhcpc' from 'mlan0.udhcpc'. Using 'mlan0' (ifindex=6).
connect ok
bssid=14:51:7e:62:fc:87
freq=5180
ssid=H3C_708_5G
id=0
mode=station
wifi_generation=5
pairwise_cipher=CCMP
group_cipher=TKIP
key_mgmt=WPA2-PSK
wpa_state=COMPLETED
ip_address=192.168.1.32
p2p_device_address=e8:fb:1c:67:0e:c1
address=e8:fb:1c:67:0e:c1
uuid=d9fed321-8e63-5bc8-86f9-ffacf325c743
ieee80211ac=1
```

Test whether the ping network is successful

```plain
root@OK-MX8MPX-C:~# ping 192.168.1.213
PING 192.168.1.213 (192.168.1.213) 56(84) bytes of data.
64 bytes from 192.168.1.213: icmp_seq=1 ttl=64 time=4.30 ms
64 bytes from 192.168.1.213: icmp_seq=2 ttl=64 time=1.48 ms
64 bytes from 192.168.1.213: icmp_seq=3 ttl=64 time=1.44 ms
64 bytes from 192.168.1.213: icmp_seq=4 ttl=64 time=4.39 ms
64 bytes from 192.168.1.213: icmp_seq=5 ttl=64 time=4.66 ms
64 bytes from 192.168.1.213: icmp_seq=6 ttl=64 time=6.11 ms
64 bytes from 192.168.1.213: icmp_seq=7 ttl=64 time=7.06 ms
64 bytes from 192.168.1.213: icmp_seq=8 ttl=64 time=3.93 ms
64 bytes from 192.168.1.213: icmp_seq=9 ttl=64 time=2.87 ms
64 bytes from 192.168.1.213: icmp_seq=10 ttl=64 time=3.78 ms
64 bytes from 192.168.1.213: icmp_seq=11 ttl=64 time=3.81 ms
^C
--- 192.168.1.213 ping statistics ---
11 packets transmitted, 11 received, 0% packet loss, time 10015ms
rtt min/avg/max/mdev = 1.435/3.984/7.063/1.617 ms
```

#### 4.14.2 WIFI- AP Mode Test

Before using the hotspot function, you need to connect and configure the network port to ensure that the gigabit network port eth0 can be connected to the network. Configure the hotspot instructions as follows:

```plain
root@OK-MX8MPX-C:~# fltest_hostapd.sh -B 5g 
hostapd: no process found
udhcpd: no process found
[  130.168122] audit: type=1325 audit(1726645842.844:18): table=nat family=2 entries=0 op=xt_register pid=1117 comm="iptables"
[  130.179333] audit: type=1300 audit(1726645842.844:18): arch=c00000b7 syscall=209 success=yes exit=0 a0=4 a1=0 a2=40 a3=fffff81bb960 items=0 ppid=1108 pid=1117 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=ttymxc1 ses=4294967295 comm="iptables" exe="/usr/sbin/xtables-legacy-multi" key=(null)
rfkill: Cannot open RFKILL control device
[  130.215022] audit: type=1327 audit(1726645842.844:18): proctitle=69707461626C6573002D74006E6174002D4100504F5354524F5554494E47002D6F0065746830002D6A004D415351554552414445
[  130.231080] audit: type=1325 audit(1726645842.852:19): table=nat family=2 entries=5 op=xt_replace pid=1117 comm="iptables"
[  130.242088] wlan: Starting AP
[  130.242214] audit: type=1300 audit(1726645842.852:19): arch=c00000b7 syscall=208 success=yes exit=0 a0=4 a1=0 a2=40 a3=aaaad8eab250 items=0 ppid=1108 pid=1117 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=ttymxc1 ses=4294967295 comm="iptables" exe="/usr/sbin/xtables-legacy-multi" key=(null)
[  130.245948] CMD_RESP: cmd 0x121 error, result=0x2
[  130.273465] audit: type=1327 audit(1726645842.852:19): proctitle=69707461626C6573002D74006E6174002D4100504F5354524F5554494E47002D6F0065746830002D6A004D415351554552414445
[  130.278175] IOCTL failed: 000000003d973d00 id=0x200000, sub_id=0x200024 action=2, status_code=0x2
[  130.278198] Get multi-channel policy failed
[  130.306857] fw doesn't support 11ax
[  130.320005] IPv6: ADDRCONF(NETDEV_CHANGE): uap0: link becomes ready
[  130.327625] wlan: AP started
[  130.331383] wlan: HostMlme uap0 send deauth/disassoc
[  130.336961] Set AC=3, txop=47 cwmin=3, cwmax=7 aifs=1
[  130.344143] Set AC=2, txop=94 cwmin=7, cwmax=15 aifs=1
[  130.353515] Set AC=0, txop=0 cwmin=15, cwmax=63 aifs=3
[  130.360655] Set AC=1, txop=0 cwmin=15, cwmax=1023 aifs=7
uap0: interface state UNINITIALIZED->ENABLED
uap0: AP-ENABLED 
```

You can see the Wi - Fi name “OK8MP\_WIFI\_5G\_AP” on your phone or other devices.

```plain
[  217.923031] uap0: 
[  217.923046] wlan: HostMlme Auth received from f8:XX:XX:XX:f3:91
[  217.931339] wlan: HostMlme uap0 send Auth
uap0: STA f8:9e:94:ac:f3:91 IEEE [  217.938570] uap0: 
802.11: authenticated
[  217.938582] wlan: HostMlme MICRO_AP_STA_ASSOC f8:XX:XX:XX:f3:91
[  217.950448] wlan: UAP/GO add peer station, address =f8:XX:XX:XX:f3:91
[  217.957616] wlan: HostMlme uap0 send assoc/reassoc resp
uap0: STA f8:9e:94:ac:f3:91 IEEE [  217.966052] uap0: 
802.11: associated (aid 1)
[  217.966066] wlan: Send EAPOL pkt to f8:XX:XX:XX:f3:91
[  217.996090] uap0: 
[  217.996103] wlan: Send EAPOL pkt to f8:XX:XX:XX:f3:91
uap0: AP-STA-CONNECTED f8:9e:94:ac:f3:91
uap0: STA f8:9e:94:ac:f3:91 RADIUS: starting accounting session 1AB28D60292A2AEB
uap0: STA f8:9e:94:ac:f3:91 WPA: pairwise key handshake completed (RSN)
uap0: EAPOL-4WAY-HS-COMPLETED f8:9e:94:ac:f3:91
udhcpd: sending OFFER to 192.168.2.2
udhcpd: sending ACK to 192.168.2.2
```

#### 4.14.3  BT Test

Bluetooth Configuration

```plain
root@OK-MX8MPX-C:~# /etc/obexd_init start
root@OK-MX8MPX-C:~# bluetoothctl                  // Open the BlueZ Bluetooth device
Agent registered
[CHG] Controller 1C:CE:51:0D:88:92 Pairable: yes
[bluetooth]# power on          // Enable the Bluetooth device
Changing power on succeeded
[bluetooth]# pairable on       // Set it to the pairable mode
Changing pairable on succeeded
[bluetooth]# discoverable on   // Set it to the discoverable mode
Changing discoverable on succeeded
[CHG] Controller 1C:CE:51:0D:88:92 Discoverable: yes
[bluetooth]# agent on        // Enable the agent
Agent is already registered
[bluetooth]# default-agent    // Set the current agent as the default agent
Default agent request successful
[bluetooth]#
```

1. Passive pairing of the development board

After the above settings, turn on the Bluetooth on your phone and search. A device named “ok - mxmpx - c” will appear. Click on this Bluetooth device to attempt pairing. At the same time, the following information will be printed on the development board. Enter “yes”:

```plain
[CHG] Device 14:16:9E:62:39:BD Connected: yes
Request confirmation
[agent] Confirm passkey 153732 (yes/no): yes
```

Then, tap on Bluetooth on your phone to initiate pairing.

2. View and remove connected devices:

```plain
[bluetooth]# devices Paired                                // View the connected Bluetooth devices
Device 14:16:9E:62:39:BD zzy
[bluetooth]# remove 14:16:9E:62:39:BD                         // Remove the device
[DEL] Device 14:16:9E:62:39:BD zzy
Device has been removed
```

3. Development Board Active: Pairing In addition to passive pairing, you can also send a request for active pairing at the development board terminal.

```plain
[bluetooth]# scan on        //Open the scanning
Discovery started
[CHG] Controller E8:FB:1C:66:FA:A6 Discovering: yes
[NEW] Device 7B:01:59:ED:69:50 7B-01-59-ED-69-50
[NEW] Device 7C:71:13:5F:A3:8F 7C-71-13-5F-A3-8F
[NEW] Device 14:16:9E:62:39:BD zzy  //Discover the paired device
[NEW] Device 2C:DB:07:C7:4F:F6 DESKTOP-VND9V1F
[CHG] Device 14:16:9E:62:39:BD RSSI: -74
[bluetooth]# scan off        //Close the scanning
Discovery stopped
[CHG] Device 2C:DB:07:C7:4F:F6 TxPower is nil
[CHG] Device 2C:DB:07:C7:4F:F6 RSSI is nil
[CHG] Device 14:16:9E:62:39:BD RSSI is nil
[CHG] Device 7C:71:13:5F:A3:8F TxPower is nil
[CHG] Device 7C:71:13:5F:A3:8F RSSI is nil
[CHG] Device 7B:01:59:ED:69:50 RSSI is nil
[CHG] Controller E8:FB:1C:66:FA:A6 Discovering: no
[bluetooth]# pair 14:16:9E:62:39:BD        //Pair with the designated device
Attempting to pair with 14:16:9E:62:39:BD
[CHG] Device 14:16:9E:62:39:BD Connected: yes
Request confirmation
[agent] Confirm passkey 807166 (yes/no): yes        //Confirm passkey
[CHG] Device 14:16:9E:62:39:BD Modalias: bluetooth:v000Fp1200d1436
[CHG] Device 14:16:9E:62:39:BD UUIDs: 00001105-0000-1000-8000-00805f9b34fb
......
[CHG] Device 14:16:9E:62:39:BD UUIDs: fa88c0d0-afac-11de-8a99-0800200c9a67
[CHG] Device 14:16:9E:62:39:BD ServicesResolved: yes
[CHG] Device 14:16:9E:62:39:BD Paired: yes
Pairing successful
[CHG] Device 14:16:9E:62:39:BD ServicesResolved: no
[CHG] Device 14:16:9E:62:39:BD Connected: no
[bluetooth]# 
```

At the same time, the pairing request appears on the mobile phone interface. Click the pairing button, and the board end prints and inputs yes. The pairing on the mobile phone end is successful.

4. Development Board Receives Files                        

After successful pairing, files can be sent from the mobile device to the board via Bluetooth.   
Note that if you want to send and receive files with the PC, when using the ok - mxmpx - c development board to send files, you need to enable the Bluetooth file - receiving function on the PC first. Then start the obexd service on the board.

```plain
root@OK-MX8MPX-C:~# /usr/libexec/bluetooth/obexd -a -r /tmp &
```

By default, received files are saved in the /tmp/ directory.   
When receiving is complete, close obexd.

```plain
root@OK-MX8MPX-C:~# killall obexd 
```

5. Sending Files from Development Board Similarly, you can use the development board to send files to the mobile phone, the test method is as follows:

```plain
root@OK-MX8MPX-C:~# bluetoothctl 
Agent registered
[CHG] Controller 1C:CE:51:0D:88:92 Pairable: yes
[bluetooth]# devices  Paired        //View paired device
Device 14:16:9E:62:39:BD zzy
[bluetooth]# exit
root@OK-MX8MPX-C:~# obexctl 
[NEW] Client /org/bluez/obex 
[obex]# connect   14:16:9E:62:39:BD     //Connect the designated device 
Attempting to connect to 14:16:9E:62:39:BD
[NEW] Session /org/bluez/obex/client/session0 [default]
[NEW] ObjectPush /org/bluez/obex/client/session0 
Connection successful
[14:16:9E:62:39:BD]# send /home/forlinx/logo/logo-1920x1080.bmp  //Send files
Attempting to send /home/forlinx/logo/logo-1920x1080.bmp to /org/bluez/obex/client/session0
[NEW] Transfer /org/bluez/obex/client/session0/transfer0 
Transfer /org/bluez/obex/client/session0/transfer0
        Status: queued
        Name: logo-1920x1080.bmp
        Size: 6220854
        Filename: /home/forlinx/logo/logo-1920x1080.bmp
        Session: /org/bluez/obex/client/session0
[CHG] Transfer /org/bluez/obex/client/session0/transfer0 Status: active
[CHG] Transfer /org/bluez/obex/client/session0/transfer0 Transferred: 65477 (@65KB/s 01:34)
[CHG] Transfer /org/bluez/obex/client/session0/transfer0 Transferred: 131005 (@65KB/s 01:32)
.....
[CHG] Transfer /org/bluez/obex/client/session0/transfer0 Status: complete
[DEL] Transfer /org/bluez/obex/client/session0/transfer0 
[14:16:9E:62:39:BD]# exit
root@OK-MX8MPX-C:~# 
```

The phone will receive the incoming file request, click Accept to transfer the file.

### 4.15 4G/5G Test

 **Note:**

+ **The driver supports 4G module of EM05 and 5G module of RM500Q-GL;**
+ **Before powering on the device, set the S4 dial-up code to be the same as the plug-in module.**

#### 4.15.1  4G Test

Access the module before starting the OK-MX8MPX-C development board, install the antenna, insert the SIM card, set the S4 dial to the 4G end, start the development board, and perform dial-up Internet access. Take 4G as an example..

1. After connecting the module and powering up the development board and the module, you can use the lsusb command to see if the module is recognized.

```plain
root@OK-MX8MPX-C:~# lsusb
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 003: ID 1a86:7523 QinHeng Electronics CH340 serial converter
Bus 003 Device 004: ID 2c7c:0125 Quectel Wireless Solutions Co., Ltd. EC25 LTE modem
Bus 003 Device 002: ID 0424:2517 Microchip Technology, Inc. (formerly SMSC) Hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```

2. After the device is successfully recognized, dial-up Internet access can be tested.

```plain
root@OK-MX8MPX-C:~# fltest_quectel.sh &
```

Serial port printing information is as follow

```plain
[1] 1078
[03-26_12:14:20:191] Quectel_QConnectManager_Linux_V1.6.0.24
[03-26_12:14:20:192] Find /sys/bus/usb/devices/3-1.2 idVendor=0x2c7c idProduct=0x125, bus=0x003, dev=0x004
[03-26_12:14:20:193] Auto find qmichannel = /dev/qcqmi0
[03-26_12:14:20:193] Auto find usbnet_adapter = usb0
[03-26_12:14:20:193] netcard driver = GobiNet, driver version = V1.6.2.14
[03-26_12:14:20:193] Modem works in QMI mode
[03-26_12:14:20:223] Get clientWDS = 7
[03-26_12:14:20:256] Get clientDMS = 8
[03-26_12:14:20:288] Get clientNAS = 9
[03-26_12:14:20:320] Get clientUIM = 10
[03-26_12:14:20:353] Get clientWDA = 11
[03-26_12:14:20:385] requestBaseBandVersion EM05CEFCR06A02M1G_ND
[03-26_12:14:20:513] requestGetSIMStatus SIMStatus: SIM_READY
[03-26_12:14:20:545] requestGetProfile[1] cmnet///0
[03-26_12:14:20:577] requestRegistrationState2 MCC: 460, MNC: 1, PS: Attached, DataCap: LTE
[03-26_12:14:20:609] requestQueryDataCall IPv4ConnectionStatus: DISCONNECTED
[03-26_12:14:20:609] ifconfig usb0 0.0.0.0
[03-26_12:14:20:624] ifconfig usb0 down
[   50.315332] GobiNet 3-1.2:1.4: Runtime PM usage count underflow!
[03-26_12:14:20:705] requestSetupDataCall WdsConnectionIPv4Handle: 0x86d0ee80
[03-26_12:14:20:865] ifconfig usb0 up
[03-26_12:14:20:883] busybox udhcpc -f -n -q -t 5 -i usb0
udhcpc: started, v1.36.1
Dropped protocol specifier '.udhcpc' from 'usb0.udhcpc'. Using 'usb0' (ifindex=9).
[   50.645653] IPv6: ADDRCONF(NETDEV_CHANGE): usb0: link becomes ready
[   50.754730] GobiNet 3-1.2:1.4: Runtime PM usage count underflow!
[   50.776986] audit: type=1334 audit(1711426461.092:18): prog-id=15 op=LOAD
[   50.784633] audit: type=1334 audit(1711426461.100:19): prog-id=16 op=LOAD
udhcpc: broadcasting discover
udhcpc: broadcasting select for 10.223.229.79, server 10.223.229.80
udhcpc: lease of 10.223.229.79 obtained from 10.223.229.80, lease time 7200
[03-26_12:14:21:471] /etc/udhcpc.d/50default: Adding DNS 123.123.123.123
[03-26_12:14:21:471] /etc/udhcpc.d/50default: Adding DNS 123.123.123.124
Dropped protocol specifier '.udhcpc' from 'usb0.udhcpc'. Using 'usb0' (ifindex=9)
```

If the IP can be automatically assigned and the DNS can be added, the dial - up is successful.

3\. After the dial - up is successful, check the network node through the ifconfig command. The network node is usb0 (the node name may vary, and it should be based on the actual situation). Then, test the network status using the ping command:

```plain
root@OK-MX8MPX-C:~# ping -I usb0 www.forlinx.com -c 3
PING s-526319.gotocdn.com (211.149.226.120) from 10.230.5.117 usb0: 56(84) bytes of data.
64 bytes from 211.149.226.120 (211.149.226.120): icmp_seq=1 ttl=51 time=63.5 ms
64 bytes from 211.149.226.120 (211.149.226.120): icmp_seq=2 ttl=51 time=80.5 ms
64 bytes from 211.149.226.120 (211.149.226.120): icmp_seq=3 ttl=51 time=61.9 ms

--- s-526319.gotocdn.com ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2004ms
rtt min/avg/max/mdev = 61.945/68.625/80.452/8.385 ms
```

#### 4.15.2  5G Test

Access the module before starting the OK-MX8MPX-C development board, install the antenna, insert the SIM card, set the S4 dial to the 5G end, start the development board, and perform dial-up Internet access. Take 5G as an example..

1. After connecting the module and powering up the development board and the module, you can use the lsusb command to see if the module is recognized.

```plain
root@OKMX8MPX-C:~# lsusb
Bus 002 Device 003: ID 2c7c:0800 Quectel Wireless Solutions Co., Ltd. RM500Q-GL
Bus 002 Device 002: ID 04b4:6500 Cypress Semiconductor Corp. 
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 004: ID 04e2:1414 Exar Corp. 
Bus 001 Device 003: ID 346d:5678 USB Disk 2.0
Bus 001 Device 002: ID 04b4:6502 Cypress Semiconductor Corp. CY4609
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

```

2. After the device is successfully recognized, dial-up Internet access can be tested.

```plain
root@OKMX8MPX-C:~# fltest_quectel.sh &
```

Serial port printing information is as follow

```plain
[1] 1277
root@OKMX8MPX-C:~# [  125.200278] imx-dwmac 30bf0000.ethernet eth1: FPE workqueue stop
[  125.294463] imx-dwmac 30bf0000.ethernet eth1: yt8521_config_init done, phy addr: 1, chip mode = 0, polling mode = 2
[  125.304958] imx-dwmac 30bf0000.ethernet eth1: PHY [stmmac-0:01] driver [YT8521 Ethernet] (irq=POLL)
[  125.314035] imx-dwmac 30bf0000.ethernet eth1: configuring for phy/rgmii-id link mode
[11-21_15:23:56:470] Quectel_QConnectManager_Linux_V1.6.0.24
[11-21_15:23:56:472] Find /sys/bus/usb/devices/2-1.1 idVendor=0x2c7c idProduct=0x800, bus=0x002, dev=0x003
[11-21_15:23:56:472] Auto find qmichannel = /dev/qcqmi0
[11-21_15:23:56:472] Auto find usbnet_adapter = usb0
[11-21_15:23:56:472] netcard driver = GobiNet, driver version = V1.6.2.14
[11-21_15:23:56:473] qmap_mode = 1, qmap_version = 5, qmap_size = 16384, muxid = 0x81, qmap_netcard = usb0
[11-21_15:23:56:473] Modem works in QMI mode
[11-21_15:23:56:511] Get clientWDS = 7
[11-21_15:23:56:543] Get clientDMS = 8
[11-21_15:23:56:575] Get clientNAS = 9
[11-21_15:23:56:607] Get clientUIM = 10
[11-21_15:23:56:640] requestBaseBandVersion RM500QGLABR11A03M4G
[11-21_15:23:56:767] requestGetSIMStatus SIMStatus: SIM_READY
[11-21_15:23:56:800] requestGetProfile[1] cmnet///0
[11-21_15:23:56:831] requestRegistrationState2 MCC: 460, MNC: 1, PS: Attached, DataCap: 5G_SA
[11-21_15:23:56:864] requestQueryDataCall IPv4ConnectionStatus: DISCONNECTED
[11-21_15:23:56:864] ifconfig usb0 0.0.0.0
[11-21_15:23:56:877] ifconfig usb0 down
[  125.801716] GobiNet 2-1.1:1.4: Runtime PM usage count underflow!
[11-21_15:23:57:408] requestSetupDataCall WdsConnectionIPv4Handle: 0x664ad620
[  126.449491] net usb0: link_state 0x0 -> 0x1
[11-21_15:23:57:540] change mtu 1500 -> 1400
[11-21_15:23:57:540] ifconfig usb0 up
[11-21_15:23:57:556] busybox udhcpc -f -n -q -t 5 -i usb0
udhcpc: started, v1.36.1
Dropped protocol specifier '.udhcpc' from 'usb0.udhcpc'. Using 'usb0' (ifindex=6).
[  126.584822] audit: type=1334 audit(1732173837.668:18): prog-id=15 op=LOAD
[  126.592104] audit: type=1334 audit(1732173837.672:19): prog-id=16 op=LOAD
[  126.705362] GobiNet 2-1.1:1.4: Runtime PM usage count underflow!
udhcpc: broadcasting discover
udhcpc: broadcasting select for 10.216.240.188, server 10.216.240.189
udhcpc: lease of 10.216.240.188 obtained from 10.216.240.189, lease time 7200
RTNETLINK answers: File exists
[11-21_15:23:58:144] /etc/udhcpc.d/50default: Adding DNS 123.123.123.123
[11-21_15:23:58:145] /etc/udhcpc.d/50default: Adding DNS 123.123.123.124
Dropped protocol specifier '.udhcpc' from 'usb0.udhcpc'. Using 'usb0' (ifindex=6).
```

If the IP can be automatically assigned and the DNS can be added, the dial - up is successful.

3\. After the dial - up is successful, check the network node through the ifconfig command. The network node is usb0 (the node name may vary, and it should be based on the actual situation). Then, test the network status using the ping command:

```plain
root@OKMX8MPX-C:~# ping -I usb0 www.forlinx.com -c 3
PING s-526319.gotocdn.com (211.149.226.120) from 10.230.5.117 usb0: 56(84) bytes of data.
64 bytes from 211.149.226.120 (211.149.226.120): icmp_seq=1 ttl=51 time=63.5 ms
64 bytes from 211.149.226.120 (211.149.226.120): icmp_seq=2 ttl=51 time=80.5 ms
64 bytes from 211.149.226.120 (211.149.226.120): icmp_seq=3 ttl=51 time=61.9 ms

--- s-526319.gotocdn.com ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2004ms
rtt min/avg/max/mdev = 61.945/68.625/80.452/8.385 ms
```

### 4.16 Play/Record Audio Test

 **Description: OK-MX8MPX-C provides 1 x 3.5mm audio jack and 2 x PH2.0 speaker connectors. The earphone mic and the carrier board mic correspond to the left and right channels of the recording, respectively. By default, the sound is played by the speakers, and after plugging in the headphones, it is switched to play by the headphones and mute the speakers.**

1. Play the recording test

```plain
root@OK-MX8MPX-C:~# aplay -D hw:3,0 /home/forlinx/audio/30s.wav
```

You can view the current audio device through the command

```plain
root@OKMX8MPX-C:~# pactl list sinks
Sink #0
    State: SUSPENDED
    Name: alsa_output.platform-sound-bt-sco.mono-fallback
...

Sink #1
    State: SUSPENDED
    Name: alsa_output.platform-sound-hdmi.stereo-fallback
...
Sink #2
    State: SUSPENDED
    Name: alsa_output.platform-sound-wm8960.stereo-fallback
    Description: Built-in Audio Stereo
    Driver: module-alsa-card.c
    Sample Specification: s16le 2ch 44100Hz
    Channel Map: front-left,front-right
    Owner Module: 8
    Mute: no
    Volume: front-left: 24163 /  37% / -26.00 dB,   front-right: 24163 /  37% / -26.00 dB
            balance 0.00
    Base Volume: 52057 /  79% / -6.00 dB
    Monitor Source: alsa_output.platform-sound-wm8960.stereo-fallback.monitor
    Latency: 0 usec, configured 0 usec
    Flags: HARDWARE HW_VOLUME_CTRL DECIBEL_VOLUME LATENCY 
    Properties:
        alsa.resolution_bits = "16"
        device.api = "alsa"
        device.class = "sound"
        alsa.class = "generic"
        alsa.subclass = "generic-mix"
        alsa.name = "HiFi wm8960-hifi-0"
        alsa.id = "HiFi wm8960-hifi-0"
        alsa.subdevice = "0"
        alsa.subdevice_name = "subdevice #0"
        alsa.device = "0"
        alsa.card = "3"
        alsa.card_name = "wm8960-audio"
        alsa.long_card_name = "wm8960-audio"
        alsa.driver_name = "snd_soc_fsl_asoc_card"
        device.bus_path = "platform-sound-wm8960"
        sysfs.path = "/devices/platform/sound-wm8960/sound/card3"
        device.form_factor = "internal"
        device.string = "hw:3"
        device.buffering.buffer_size = "17632"
        device.buffering.fragment_size = "4408"
        device.access_mode = "mmap"
        device.profile.name = "stereo-fallback"
        device.profile.description = "Stereo"
        device.description = "Built-in Audio Stereo"
        module-udev-detect.discovered = "1"
        device.icon_name = "audio-card"
    Ports:
        analog-output-speaker: Speakers (type: Speaker, priority: 10000, not available)
        analog-output-headphones: Headphones (type: Headphones, priority: 9900, available)
    Active Port: analog-output-headphones
    Formats:
        pcm

Sink #3
    State: SUSPENDED
    Name: alsa_output.platform-sound-xcvr.iec958-stereo
       Description: Built-in Audio Digital Stereo (IEC958)
    Driver: module-alsa-card.c
    Sample Specification: s16le 2ch 44100Hz
...

```

The wm8960 is the audio processor and is selected as the default output device.

```plain
root@OK-MX8MPX-C:~# pacmd set-default-sink 2   #Set the default output device to headphone
root@OK-MX8MPX-C:~# gst-play-1.0 /home/forlinx/audio/30s.mp3
```

Pressing the up and down keys on the keyboard adjusts the volume level, while the left and right keys control fast-forwarding or rewinding. The spacebar is used to start or pause playback.

2. Record an audio test

```plain
root@OK-MX8MPX-C:~# arecord -D hw:3,0 -c 1 -f cd -r 44100 -t wav test.wav
Recording WAVE 'mic.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo

root@OKMX8MPX-C:~# aplay -D hw:3,0 ./test.wav 
Playing WAVE './test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo

```

### 4.17 Close the Desktop

```plain
root@OK-MX8MPX-C:~# systemctl stop matrix                      //Close the desktop
root@OK-MX8MPX-C:~# systemctl start matrix                      //Start the desktop
```

### 4.18 SQLite3 Database Test

SQLite3 is a lightweight database that is ACID compliant relational database management system with low resource usage. The OK-MX8MPX-C development board is ported with version 3.41.0 of sqlit3.

```plain
root@OK-MX8MPX-C:~# sqlite3
SQLite version 3.41.0 2023-02-21 18:09:37
Enter ".help" for usage hints.
Connected to a transient in-memory database.
Use ".open FILENAME" to reopen on a persistent database.
sqlite> create table tbl1 (one varchar(10), two smallint);         // Create table tbl1
sqlite> insert into tbl1 values('hello!',10);                      // Insert data 'hello!'|10 into table tbl1
sqlite> insert into tbl1 values('goodbye', 20);                  // Insert data 'goodbye'|20 into table tbl1
sqlite> select * from tbl1;                                   // Query the contents of table tbl1
hello!|10
goodbye|20
sqlite> delete from tbl1 where one = 'hello!';                  // Delete data
sqlite> select * from tbl1;                                   // Query the contents of table tbl1
goodbye|20
sqlite> .quit 			                                     // Exit the database (or use the .exit command)
root@OK-MX8MPX-C:~#
```

### 4.19 PWM Test

The OK-MX8MPX-C development board has 2 x PWM, of which PWM1 and PWM2 are used as mipi-dsi and LVDS display backlight respectively.

#### 4.19.1 LVDS Backlight Test

The brightness of the screen backlight is set in the range of (0-255) 255 means the highest brightness and 1 means the backlight is completely off. Enter the system and enter the following command in the terminal to perform the backlight test.

1. View the LVDS screen backlight:

```plain
root@OK-MX8MPX-C:~# cat /sys/class/backlight/lvds1_backlight/brightness
250
```

2. Turn off the LVDS backlight:

```plain
root@OK-MX8MPX-C:~# echo 0 > /sys/class/backlight/lvds1_backlight/brightness
```

3. Turn on the LVDS backlight

```plain
root@OK-MX8MPX-C:~# echo 255 > /sys/class/backlight/lvds1_backlight/brightness
```

#### 4.19.2 MIPI-DSI Screen Backlight Test

The mipi-dsi interface has a brightness setting range of (0-255), with 255 indicating the highest brightness and 1 indicating that the backlight is completely off. After entering the system, enter the following command at the terminal for mipi-dsi test

1. View mipi-dsi backlight:

```plain
root@OK-MX8MPX-C:~# cat /sys/class/backlight/dsi_backlight/brightness
250
```

2. Turn off the mipi-dsi backlight:

```plain
root@OK-MX8MPX-C:~# echo 0 > /sys/class/backlight/dsi_backlight/brightness
```

3. Turn on the mipi-dsi backlight:

```plain
root@OK-MX8MPX-C:~# echo 255 > /sys/class/backlight/dsi_backlight/brightness
```

### 4.20 CAN Test

#### 4.20.1 CAN Bus Test

The OK8MP-C platform has two FlexCAN bus interfaces and connection methods: The “H” terminal of CAN should be connected to the “H” terminal of other CAN devices. The “L” terminal of CAN should be connected to the “L” terminal of other CAN devices.   
![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908636280-babb55b5-9867-41e8-aa10-e90afff6b622.png)Set can service.

```plain
root@OK-MX8MPX-C:~# ip link set can0 up type can bitrate 500000
root@OK-MX8MPX-C:~# ip link set can1 up type can bitrate 500000
```

Set can0 to receive and can1 to send:

```plain
root@OK-MX8MPX-C:~# candump can0 &
[1] 1305
root@OK-MX8MPX-C:~# cangen  can1
  can0  290   [3]  07 7C 1A
  can0  242   [5]  D5 DA F1 05 1B
  can0  46F   [8]  42 12 71 2D 68 14 83 49
  can0  725   [8]  03 E8 6B 02 A5 7A 03 36
  can0  025   [6]  85 55 A3 77 90 32
  can0  5D1   [6]  F3 02 C1 61 D9 67
  can0  078   [0]  
```

Set up the canfd service.

```plain
root@OK-MX8MPX-C:~# ip link set can0 up type can bitrate 500000 dbitrate 2000000 fd on
root@OK-MX8MPX-C:~# ip link set can1 up type can bitrate 500000 dbitrate 2000000 fd on
```

Set can1 to receive and can0 to send:

```plain
root@OK-MX8MPX-C:~# candump can1 &
[1] 1326
root@OK-MX8MPX-C:~# cangen  can0 -f
  can1  1D9  [02]  00 6A
  can1  475  [32]  86 1D 18 43 84 89 76 37 86 1D 18 43 84 89 76 37 86 1D 18 43 84 89 76 37 86 1D 18 43 84 89 76 37
  can1  261  [07]  A9 88 2D 3D BF 8A 31
  can1  606  [06]  37 65 17 0B A2 4D
  can1  0C8  [04]  DF 60 79 3F
  can1  50B  [02]  C4 46
  can1  40A  [16]  71 8F F5 22 51 67 3C 6B 71 8F F5 22 51 67 3C 6B
  can1  29A  [02]  3C 58
  can1  294  [32]  FA DF 4D 02 09 D7 84 31 FA DF 4D 02 09 D7 84 31 FA DF 4D 02 09 D7 84 31 FA DF 4D 02 09 D7 84 31
  can1  16A  [00] 
  can1  537  [06]  8A 4E 51 19 3E 1B
  can1  28D  [01]  E0
```

#### 4.20.2 Other Common Commands

Check can bus status:

```plain
root@OK-MX8MPX-C:~# ip -details -statistics link show can0
4: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP mode DEFAULT group default qlen 10
    link/can  promiscuity 0  allmulti 0 minmtu 0 maxmtu 0 
    can <FD> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0 
          bitrate 500000 sample-point 0.875
          tq 25 prop-seg 37 phase-seg1 32 phase-seg2 10 sjw 1 brp 1
          flexcan: tseg1 2..96 tseg2 2..32 sjw 1..16 brp 1..1024 brp_inc 1
          dbitrate 2000000 dsample-point 0.750
          dtq 25 dprop-seg 7 dphase-seg1 7 dphase-seg2 5 dsjw 1 dbrp 1
          flexcan: dtseg1 2..39 dtseg2 2..8 dsjw 1..4 dbrp 1..1024 dbrp_inc 1
          clock 40000000 
          re-started bus-errors arbit-lost error-warn error-pass bus-off
          0          0          0          0          0          0         numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 parentbus platform parentdev 308c0000.can 
    RX:  bytes packets errors dropped  missed   mcast           
           281      31      0       0       0       0 
    TX:  bytes packets errors dropped carrier collsns           
           174      13      0       0       0       0 
```

Set the bus-off reset time of the can bus:

```plain
root@OK-MX8MPX-C:~# ifconfig can0 down
root@OK-MX8MPX-C:~# ip link set can0 type can restart-ms 100
root@OK-MX8MPX-C:~# ip -details -statistics link show can0
4: can0: <NOARP,ECHO> mtu 72 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 10
    link/can  promiscuity 0  allmulti 0 minmtu 0 maxmtu 0 
    can <FD> state STOPPED (berr-counter tx 0 rx 0) restart-ms 100 
          bitrate 500000 sample-point 0.875
          tq 25 prop-seg 37 phase-seg1 32 phase-seg2 10 sjw 1 brp 1
          flexcan: tseg1 2..96 tseg2 2..32 sjw 1..16 brp 1..1024 brp_inc 1
          dbitrate 2000000 dsample-point 0.750
          dtq 25 dprop-seg 7 dphase-seg1 7 dphase-seg2 5 dsjw 1 dbrp 1
          flexcan: dtseg1 2..39 dtseg2 2..8 dsjw 1..4 dbrp 1..1024 dbrp_inc 1
          clock 40000000 
          re-started bus-errors arbit-lost error-warn error-pass bus-off
          0          0          0          0          0          0         numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 parentbus platform parentdev 308c0000.can 
    RX:  bytes packets errors dropped  missed   mcast           
           281      31      0       0       0       0 
    TX:  bytes packets errors dropped carrier collsns           
           174      13      0       0       0       0 
```

Set send queue length:

```plain
root@OK-MX8MPX-C:~# ip link set dev can0 txqueuelen 100
root@OK-MX8MPX-C:~# ip -details -statistics link show can0
4: can0: <NOARP,ECHO> mtu 72 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 100                                              //设置队列长度为100
    link/can  promiscuity 0  allmulti 0 minmtu 0 maxmtu 0 
    can <FD> state STOPPED (berr-counter tx 0 rx 0) restart-ms 100 
          bitrate 500000 sample-point 0.875
          tq 25 prop-seg 37 phase-seg1 32 phase-seg2 10 sjw 1 brp 1
          flexcan: tseg1 2..96 tseg2 2..32 sjw 1..16 brp 1..1024 brp_inc 1
          dbitrate 2000000 dsample-point 0.750
          dtq 25 dprop-seg 7 dphase-seg1 7 dphase-seg2 5 dsjw 1 dbrp 1
          flexcan: dtseg1 2..39 dtseg2 2..8 dsjw 1..4 dbrp 1..1024 dbrp_inc 1
          clock 40000000 
          re-started bus-errors arbit-lost error-warn error-pass bus-off
          0          0          0          0          0          0         numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 parentbus platform parentdev 308c0000.can 
    RX:  bytes packets errors dropped  missed   mcast           
           281      31      0       0       0       0 
    TX:  bytes packets errors dropped carrier collsns           
           174      13      0       0       0       0 
```

### 4.21 SPI Interface Test

An SPI interface is led out from the OK-MX8MPX-C carrier board, and the default software configures it as spidev for loopback test. When testing, refer to the schematic to short MOSI and MISO, and then use the commands below to test them separately  
![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908636445-dad16c15-7ce5-4457-bf53-f787389c0b41.png)  
Short circuit SPI2\_MOSI and SPI2\_MISO.

```plain
root@OK-MX8MPX-C:~# spidev_test -D /dev/spidev1.0
spi mode: 0x0
bits per word: 8
max speed: 500000 Hz (500 kHz)
root@OK-MX8MPX-C:~# fltest_spidev_test -D /dev/spidev1.0
spi mode: 0
bits per word: 8
max speed: 500000 Hz (500 KHz)

FF FF FF FF FF FF 
40 00 00 00 00 95 
FF FF FF FF FF FF 
FF FF FF FF FF FF 
FF FF FF FF FF FF 
DE AD BE EF BA AD 
F0 0D 
```

### 4.22 GPIO Interface Test

#### 4.22.1  GPIO-LEDS Test

The OK8MP-C SoM has a controllable blue LED, and the OKT507 SoM blue LED blinks when the board is powered up and started. You can turn off this function. Just modify the device tree file arch/arm64/boot/dts/freescale/OK8MP - C.dts and change the attribute state = "on" of the leds node to "off".![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908636558-d80586e5-3825-4299-9a7d-338bab3b6fb4.png)

```plain
leds {
        compatible = "gpio-leds";
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_gpio_led>;

        heartbeat {
            linux,default-trigger = "heartbeat";
            gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
            default-state = "on"; 
        };
        
        led1 {
            linux,default-trigger = "disk-activity";
            gpios = <&gpio5 8 GPIO_ACTIVE_LOW>;
            default-state = "on";
        };
        led2 {
            linux,default-trigger = "timer";  
            led-pattern = <100 500>;
            gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
            default-state = "on";
        };
    };
```

The testing method is as follows:

1\. Check the trigger conditions.

By default, the trigger condition for led1 is disk - activity, and the trigger condition for led2 is timer. You can check the current trigger conditions through the following commands.

```plain
root@OK-MX8MPX-C:~# cat /sys/class/leds/led1/trigger
none bluetooth-power kbd-scrolllock kbd-numlock kbd-capslock kbd-kanalock kbd-shiftlock kbd-altgrlock kbd-ctrllock kbd-altlock kbd-shiftllock kbd-shiftrlock kbd-ctrlllock kbd-ctrlrlock mmc2 timer [disk-activity] disk-read disk-write ide-disk heartbeat cpu cpu0 cpu1 cpu2 cpu3 default-on panic mmc1 mmc0 tcpm-source-psy-2-0022-online hci0-power

root@OKMX8MPX-C:~# cat /sys/class/leds/led2/trigger
none bluetooth-power kbd-scrolllock kbd-numlock kbd-capslock kbd-kanalock kbd-shiftlock kbd-altgrlock kbd-ctrllock kbd-altlock kbd-shiftllock kbd-shiftrlock kbd-ctrlllock kbd-ctrlrlock mmc2 [timer] disk-activity disk-read disk-write ide-disk heartbeat cpu cpu0 cpu1 cpu2 cpu3 default-on panic mmc1 mmc0 tcpm-source-psy-2-0022-online hci0-power

```

2\. User Control                                                                                                        

When the led trigger condition is set to none, you can control the on and off of the led lamp through the command:

```plain
root@OK-MX8MPX-C:~# echo none > /sys/class/leds/led1/trigger
root@OK-MX8MPX-C:~# echo none > /sys/class/leds/led2/trigger
root@OK-MX8MPX-C:~# echo 1 > /sys/class/leds/led1/brightness
root@OK-MX8MPX-C:~# echo 0 > /sys/class/leds/led1/brightness
root@OK-MX8MPX-C:~# echo 1 > /sys/class/leds/led2/brightness
root@OK-MX8MPX-C:~# echo 0 > /sys/class/leds/led2/brightness
```

3\. Change the LED light to heartbeat light

```plain
root@OK-MX8MPX-C:~# echo heartbeat > /sys/class/leds/led1/trigger
root@OK-MX8MPX-C:~# echo heartbeat > /sys/class/leds/led2/trigger
```

#### 4.22.2  GPIO- BUTTON Test

The OK - MX8MPX - C platform uses two GPIO configure buttons GPIO\_UP and GPIO\_DOWN.

```plain
root@OK-MX8MPX-C:~# evtest 
No device specified, trying to scan all of /dev/input/event*
Available devices:
/dev/input/event0:	30370000.snvs:snvs-powerkey
/dev/input/event1:	gpio-keys
/dev/input/event2:	audio-hdmi HDMI Jack
/dev/input/event3:	Goodix Capacitive TouchScreen
Select the device event number [0-3]: 1
Input driver version is 1.0.1
Input device ID: bus 0x19 vendor 0x1 product 0x1 version 0x100
Input device name: "gpio-keys"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 103 (KEY_UP)
    Event code 108 (KEY_DOWN)
Properties:
Testing ... (interrupt to exit)
Event: time 1727083004.664564, type 1 (EV_KEY), code 103 (KEY_UP), value 1
Event: time 1727083004.664564, -------------- SYN_REPORT ------------
Event: time 1727083004.839470, type 1 (EV_KEY), code 103 (KEY_UP), value 0
Event: time 1727083004.839470, -------------- SYN_REPORT ------------
Event: time 1727083004.916875, type 1 (EV_KEY), code 103 (KEY_UP), value 1
Event: time 1727083004.916875, -------------- SYN_REPORT ------------
Event: time 1727083005.128511, type 1 (EV_KEY), code 103 (KEY_UP), value 0
Event: time 1727083005.128511, -------------- SYN_REPORT ------------
Event: time 1727083005.549751, type 1 (EV_KEY), code 108 (KEY_DOWN), value 1
Event: time 1727083005.549751, -------------- SYN_REPORT ------------
Event: time 1727083005.654654, type 1 (EV_KEY), code 108 (KEY_DOWN), value 0
Event: time 1727083005.654654, -------------- SYN_REPORT ------------
Event: time 1727083005.798788, type 1 (EV_KEY), code 108 (KEY_DOWN), value 1
Event: time 1727083005.798788, -------------- SYN_REPORT ------------
Event: time 1727083005.901483, type 1 (EV_KEY), code 108 (KEY_DOWN), value 0
Event: time 1727083005.901483, -------------- SYN_REPORT ------------
```

### 4.23 QSPI Interface Test

The OK - MX8MPX - C platform is configured with the QSPI driver by default. If there are the chip on the carrier board, you can view the partition information after the system starts.

```plain
root@OK-MX8MPX-C:~# cat /proc/mtd 
dev:    size   erasesize  name
mtd0: 01000000 00010000 "qspiflash"
```

2\. There is no file system in the factory QSPI flash chip; you can format the partition into jffs2 format by the following command. (Formatting the NOR Flash is slow.)                                                                 Perform QSPI formatting and read - write tests.

```plain
root@OK-MX8MPX-C:~# flash_erase -j /dev/mtd0 0 0 
Erasing 16384 Kibyte @ 0 -- 100 % complete flash_erase: 0 : Cleanmarker Updated.
flash_erase: 10000 : Cleanmarker Updated.
flash_erase: 20000 : Cleanmarker Updated.
flash_erase: 30000 : Cleanmarker Updated.
flash_erase: 40000 : Cleanmarker Updated.
flash_erase: 50000 : Cleanmarker Updated.
flash_erase: 60000 : Cleanmarker Updated.
flash_erase: 70000 : Cleanmarker Updated.
flash_erase: 80000 : Cleanmarker Updated.
flash_erase: 90000 : Cleanmarker Updated.
flash_erase: a0000 : Cleanmarker Updated.
flash_erase: b0000 : Cleanmarker Updated.
flash_erase: c0000 : Cleanmarker Updated.
flash_erase: d0000 : Cleanmarker Updated.
flash_erase: e0000 : Cleanmarker Updated.
flash_erase: f0000 : Cleanmarker Updated.
...
root@OK-MX8MPX-C:~# mount -t jffs2 /dev/mtdblock0 /mnt/ 
root@OK-MX8MPX-C:~# dd if=/dev/zero of=/dev/mtdblock0 bs=1M count=16 conv=fsync
16+0 records in
16+0 records out
16777216 bytes (17 MB, 16 MiB) copied, 90.6677 s, 185 kB/s
root@OK-MX8MPX-C:~# dd if=/dev/mtdblock0 of=/dev/zero bs=1M count=16
16+0 records in
16+0 records out
16777216 bytes (17 MB, 16 MiB) copied, 1.8449 s, 9.1 MB/s
```

### 4.24 Sleep Wake-up Test

The OK-MX8MPX-C platform supports sleep wake-up, currently supports serial wake-up, supports pwr key wake-up, and supports gpio wake-up   
Enable serial port wake-up:

```plain
root@OK-MX8MPX-C:~# echo enabled > /sys/class/tty/ttymxc1/power/wakeup
```

Sleep Test：

```plain
root@OK-MX8MPX-C:~# echo mem > /sys/power/state 
[12842.317424] PM: suspend entry (deep)
[12842.330144] Filesystems sync: 0.009 seconds
[12842.335039] Freezing user space processes
[12842.340999] Freezing user space processes completed (elapsed 0.001 seconds)
[12842.347997] OOM killer disabled.
[12842.351222] Freezing remaining freezable tasks
[12842.356944] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[12842.364357] printk: Suspending console(s) (use no_console_suspend to debug)
```

Wake-up Test：

```plain
[  903.218278] wlan: Received disassociation request on mlan0, reason: 3
[  903.218289] wlan: REASON: (Deauth) Sending STA is leaving (or has left) IBSS or ESS
[  903.243426] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  903.246522] None of the WOWLAN triggers enabled
[  903.246559] Suspend not allowed and retry again
......
[  907.149034] PM: resume devices took 3.372 seconds
[  907.345797] OOM killer enabled.
[  907.348945] Restarting tasks ... done.
[  907.355540] random: crng reseeded on system resumption
[  907.360827] PM: suspend exit
```

### 4.25 IPV6 Test

The OK-MX8MPX-C platform supports ipv6 on the Ethernet port. The test commands are as follows:

```plain
root@OK-MX8MPX-C:~# ping ipw.cn
PING ipw.cn(2408:8719:3000:a:41::18 (2408:8719:3000:a:41::18)) 56 data bytes
64 bytes from 2408:8719:3000:a:41::18 (2408:8719:3000:a:41::18): icmp_seq=1 ttl=57 time=14.8 ms
64 bytes from 2408:8719:3000:a:41::18 (2408:8719:3000:a:41::18): icmp_seq=2 ttl=57 time=16.0 ms
```

## 5\. OK- MX8MPX-C Platform Multimedia Test

Some application layer software for audio and video on the OK-MX8MPX-C platform uses Gstreamer, which supports hardware codecs. All examples in this section based on the GStreamer command line form. If users need a player with an interface, they can also use qt's multimedia classes, which also support codecs, see the Qt Tests chapter.   
The OK-MX8MPX-C platform has an internal video processing unit, the VPU, which supports hard codecs for video in the following formats:   
Video Decoding: H264, H265, VP8, VP9，maximum support 1080p 60fps  
Video Encoding： H264, H265, up to 1080p 60fps 

OK-MX8MPX-C platform hardware codec parameter table:

| Video Decoder| Format| Profile| Resolution| Frame rate| Bitrate
|----------|----------|----------|----------|----------|----------
| | HEVC| main/main 10| 1920x1080| 60 fps| 160Mbps
| | H.264| HP/MP/BP| 1920x1080| 60 fps| 60Mbps
| | VP9| Profile 0/2| 1920x1080| 60 fps| 100Mbps
| | VP8| \-| 1920x1080| 60 fps| 60Mbps
| Video Encoder| H.264| HP/MP/BP| 1920x1080| 60 fps| 60Mbps
| | H.265| \-| 1920x1080| 60 fps| 60Mbps

### 5.1 Audio and Video Playback

#### 5.1.1 Playing Audio and Video with Gst-play

Gplay is an audio/video player based on GStreamer that can automatically select the right plugin for audio/video play according to the hardware, and it is easy to run.

Set the default playback audio device first.

```plain
root@OK-MX8MPX-C:~# pacmd set-default-sink 2
```

```plain
root@OK-MX8MPX-C:~# gst-play-1.0 /home/forlinx/video/1080p_60fps_h264-30S.mp4
```

#### 5.1.2 Playing Video with Gst-launch

```plain
root@OK-MX8MPX-C:~# gst-launch-1.0 filesrc location=/home/forlinx/video/1080p_60fps_h264-30S.mp4 typefind=true ! \
video/quicktime ! aiurdemux ! queue max-size-time=0 ! vpudec ! imxvideoconvert_g2d ! \
video/x-raw, format=RGB16, width=1024, height=600 ! waylandsink
```

#### 5.1.3 Play ing Audio with Gst-launch

```plain
root@OK-MX8MPX-C:~# gst-launch-1.0 filesrc location=/home/forlinx/audio/30s.mp3 ! id3demux ! queue ! \
mpegaudioparse ! decodebin ! audioconvert ! audioresample ! pulsesink
```

#### 5.1.4 Playing Video and Audio with gst-launch

```plain
root@OK-MX8MPX-C:~#gst-launch-1.0 filesrc location=/home/forlinx/video/1080p_60fps_h264-30S.mp4 typefind=true ! \
video/quicktime ! aiurdemux name=demux demux. ! queue max-size-buffers=0 \
max-size-time=0 ! vpudec !  imxvideoconvert_g2d ! video/x-raw, format=RGB16, width=1024, \
height=600 ! waylandsink demux. ! queue max-size-buffers=0 max-size-time=0 \
! decodebin ! audioconvert ! audioresample ! pulsesink
```

### 5.2 Video Hardware Encoding

OK-MX8MPX-C supports video encoding in H264, H265 formats up to 1080p 60fps.

#### 5.2.1 Video Hardware Encoding H.264

Encode YUV420 format video to H264 format video:

```plain
root@OK-MX8MPX-C:~# gst-launch-1.0 filesrc location=/home/forlinx/yuv/yuv420_p352x288.yuv ! videoparse format=2 \
width=352 height=288 ! video/x-raw,width=352,height=288 ! vpuenc_h264 ! queue ! \
h264parse ! qtmux ! filesink location=yuv2h264.mp4
```

Play encoded H264 video:

```plain
root@OK-MX8MPX-C:~# gst-play-1.0 yuv2h264.mp4 
```

#### 5.2.2 Video Hardware Encoding H.265

Encode YUV420 video to H.265 format video:

```plain
root@OK-MX8MPX-C:~# gst-launch-1.0 filesrc location=/home/forlinx/yuv/yuv420_p352x288.yuv ! videoparse format=2 width=352 height=288 ! video/x-raw,width=352,height=288 ! vpuenc_hevc ! queue ! h265parse ! qtmux ! filesink location=test.mp4 
```

Play encoded H265 video:

```plain
root@OK-MX8MPX-C:~# gst-launch-1.0 filesrc location=test.mp4 ! qtdemux ! queue ! vpudec ! waylandsink 
```

### 5.3 Video Hardware Decoding

OK-MX8MPX-C supports H264, H265, VP8, VP9 video hard decoding up to 1080p 60fps.   
OK-MX8MPX-C uses the vpudec component for video hard decoding. Its output formats are: NV12, I420, YV12.

#### 5.3.1 Decoding and Playing H.264 Format Video

```plain
root@OK-MX8MPX-C:~# gst-launch-1.0 filesrc location=/home/forlinx/video/1080p_60fps_h264-30S.mp4 typefind=true ! video/quicktime ! aiurdemux ! queue max-size-time=0 ! vpudec ! imxvideoconvert_g2d ! video/x-raw, format=RGB16, width=1024, height=600 ! waylandsink 
```

#### 5.3.2 Decoding and Playing H264 Format Video with Audio

```plain
root@OK-MX8MPX-C:~# gst-launch-1.0 filesrc location=/home/forlinx/video/1080p_60fps_h264-30S.mp4 typefind=true ! video/quicktime ! aiurdemux name=demux demux. ! queue max-size-buffers=0 max-size-time=0 ! vpudec ! imxvideoconvert_g2d ! video/x-raw, format=RGB16, width=1024, height=600 ! waylandsink demux. ! queue max-size-buffers=0 max-size-time=0 ! decodebin ! audioconvert ! audioresample ! pulsesink 
```

#### 5.3.3 Decoding and Playing H.265 Format Video

```plain
root@OK-MX8MPX-C:~# gst-launch-1.0 filesrc location=/home/forlinx/video/1080p_30fps_h265-30S.mp4 typefind=true ! video/quicktime ! aiurdemux ! queue max-size-time=0 ! vpudec ! imxvideoconvert_g2d ! video/x-raw, format=RGB16, width=1024, height=600 ! waylandsink 
```

#### 5.3.4 Decoding and Playing H265 Format Video with Audio

```plain
root@OK-MX8MPX-C:~# gst-launch-1.0 filesrc location=/home/forlinx/video/1080p_30fps_h265-30S.mp4 typefind=true ! video/quicktime ! aiurdemux name=demux demux. ! queue max-size-buffers=0 max-size-time=0 ! vpudec ! imxvideoconvert_g2d ! video/x-raw, format=RGB16, width=1024, height=600 ! waylandsink demux. ! queue max-size-buffers=0 max-size-time=0 ! decodebin ! audioconvert ! audioresample ! pulsesink 
```

#### 5.3.5 Decoding and Playing VP9 Format Video

```plain
root@OK-MX8MPX-C:~# gst-launch-1.0 filesrc location=/home/forlinx/video/1080p_30fps_vp9.webm typefind=true ! video/x-matroska ! aiurdemux ! queue max-size-time=0 ! vpudec ! imxvideoconvert_g2d ! video/x-raw, format=RGB16,width=1024, height=600 ! waylandsink 
```

#### 5.3.6 Decoding and Playing VP9 Format Video with Audio

```plain
root@OK-MX8MPX-C:~# gst-launch-1.0 filesrc location=/home/forlinx/video/1080p_30fps_vp9.webm typefind=true ! video/x-matroska ! aiurdemux name=demux demux. ! queue max-size-buffers=0 max-size-time=0 ! vpudec ! imxvideoconvert_g2d ! video/x-raw, format=RGB16,width=1024, height=600 ! waylandsink demux. ! queue max-size-buffers=0 max-size-time=0 ! decodebin ! audioconvert ! audioresample ! pulsesink 
```

#### 5.3.7 Decoding and Playing VP8 Format Video

```plain
root@OK-MX8MPX-C:~# gst-launch-1.0 filesrc location=/home/forlinx/video/1080p_60fps_vp8-30S.webm typefind=true ! video/x-matroska ! aiurdemux ! queue max-size-time=0 ! vpudec ! imxvideoconvert_g2d ! video/x-raw, format=RGB16,width=1024, height=600 ! waylandsink 
```

Gst-launch-1.0 does not currently support playing OPUS audio.

### 5.4 Video Conversion (Color Space Conversion and Rotation Scaling)

The OK-MX8MPX-C provides a video conversion component: imxvideoconvert\_g2d, which supports the following features:

+ **Video color space conversion**
+ **Video scaling**
+ **Video rotation**                                                                                                

**Note: When converting the video color space, imxvideoconvert\_g2d only supports converting videos in other formats to RGB - format videos.**

1. Video color space conversion  
Convert the built-in NV12 format video source of gstreamer to RGB16 format video:

```plain
root@OK-MX8MPX-C:~# gst-launch-1.0 videotestsrc ! video/x-raw,format=NV12 ! imxvideoconvert_g2d ! video/x-raw,format=RGB16 ! waylandsink 
```

2. After decoding the h264 video, use imxvideoconvert \_ g2d to convert it to RGB16 video:

```plain
root@OK-MX8MPX-C:~# gst-launch-1.0 filesrc location=/home/forlinx/video/1080p_60fps_h264-30S.mp4 ! qtdemux ! queue ! h264parse ! vpudec ! imxvideoconvert_g2d ! video/x-raw, format=RGB16, width=1920, height=1080 ! waylandsink 
```

3. Video scaling

Convert the video source in NV12 format with a resolution of 1280×720 provided by GStreamer to a video in RGB16 format with a resolution of 640×480:

```plain
root@OK-MX8MPX-C:~# gst-launch-1.0 videotestsrc ! video/x-raw,format=NV12,width=1280,height=720 ! imxvideoconvert_g2d ! video/x-raw, format=RGB16, width=640, height=480 ! waylandsink 
```

4. Video rotation  
Rotate the built-in video source of gstreamer by 90 degrees:

```plain
root@OK-MX8MPX-C:~# gst-launch-1.0 videotestsrc ! imxvideoconvert_g2d rotation=1 ! waylandsink 
```

5. Rotate the gstreamer's own video source by 180 degrees:

```plain
root@OK-MX8MPX-C:~# gst-launch-1.0 videotestsrc ! imxvideoconvert_g2d rotation=2 ! waylandsink 
```

### 5.5 Video Compositing

OK-MX8MPX-C uses the imxcompositor \_ g2d component for video compositing. It uses hardware acceleration for video compositing. It can only output video in RGB format.

1. Combine two gstreamer's own video sources into one:

```plain
root@OK-MX8MPX-C:~#gst-launch-1.0 imxcompositor_g2d name=comp sink_1::xpos=160 sink_1::ypos=480 ! glimagesink videotestsrc ! comp.sink_0 videotestsrc ! comp.sink_1
```

2. Combine two gstreamer's own video sources into one, using a red background color:

```plain
root@OK-MX8MPX-C:~# gst-launch-1.0 imxcompositor_g2d background=0x000000FF name=comp sink_1::xpos=160 sink_1::ypos=480 ! glimagesink videotestsrc ! comp.sink_0 videotestsrc ! comp.sink_1
```

3. Combine two gstreamer's own video sources into one, using CSC, resize, and rotate:

```plain
root@OK-MX8MPX-C:~# gst-launch-1.0 imxcompositor_g2d name=comp sink_0::width=640 sink_0::height=480 sink_1::xpos=160 sink_1::ypos=500 sink_1::width=640 sink_1::height=480 sink_1::rotate=1 ! video/x-raw,format=RGB16 ! glimagesink videotestsrc ! video/x-raw,format=NV12,width=320,height=240 ! comp.sink_0 videotestsrc ! video/x-raw,format=I420,width=320,height=240 ! comp.sink_1
```

4. Combine three gstreamer native video sources into one, using CSC, resize, rotate, alpha, z-order, and maintaining the aspect ratio:

```plain
root@OK-MX8MPX-C:~# gst-launch-1.0 imxcompositor_g2d name=comp sink_0::width=640 sink_0::height=480 sink_0::alpha=0.5 sink_0::z-order=3 sink_1::alpha=0.8 sink_1::z-order=2 sink_1::xpos=160 sink_1::ypos=120 sink_1::width=640 sink_1::height=480 sink_1::rotate=1 sink_2::xpos=320 sink_2::ypos=240 sink_2::width=500 sink_2::height=500 sink_2::alpha=0.6 sink_2::keep-ratio=true ! video/x-raw,format=RGB16 ! glimagesink videotestsrc ! video/x-raw,format=NV12,width=320,height=240 ! comp.sink_0 videotestsrc ! video/x-raw,format=I420,width=320,height=240 ! comp.sink_1 videotestsrc ! video/x-raw,format=RGB16,width=320,height=240 ! comp.sink_2
```

### 5.6 NPU Test

The OK-MX8MPX-C development board is equipped with an iMX8MPLUS processor, which integrates an NPU with a computing power of up to 2.3 TOPS inside the CPU.

1. TensorFlow Lite testing  
Demo recognizes information such as people, animals, plants, and places in the input image (grace\_copper. bp).![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908638245-145df179-b4b8-4360-9c13-3944425659e4.png)

Run the demo on the CPU.

```plain
root@OK-MX8MPX-C:~# cd /usr/bin/tensorflow-lite-2.11.1/examples/
root@OK-MX8MPX-C:/usr/bin/tensorflow-lite-2.11.1/examples# ./label_image -m mobilenet_v1_1.0_224_quant.tflite -i grace_hopper.bmp -l labels.txt
INFO: Loaded model mobilenet_v1_1.0_224_quant.tflite
INFO: resolved reporter
INFO: invoked
INFO: average time: 44.656 ms
INFO: 0.764706: 653 military uniform
INFO: 0.121569: 907 Windsor tie
INFO: 0.0156863: 458 bow tie
INFO: 0.0117647: 466 bulletproof vest
INFO: 0.00784314: 835 suit
```

NPU test demo

```plain
root@OK-MX8MPX-C:/usr/bin/tensorflow-lite-2.11.1/examples#./label_image -m mobilenet_v1_1.0_224_quant.tflite  -l grace_hopper.bmp  -l labels.txt --external_delegate_path=/usr/lib/libvx_delegate.so
INFO: Loaded model mobilenet_v1_1.0_224_quant.tflite
INFO: resolved reporter
Vx delegate: allowed_cache_mode set to 0.
Vx delegate: device num set to 0.
Vx delegate: allowed_builtin_code set to 0.
Vx delegate: error_during_init set to 0.
Vx delegate: error_during_prepare set to 0.
Vx delegate: error_during_invoke set to 0.
EXTERNAL delegate created.
INFO: Applied EXTERNAL delegate.
W [HandleLayoutInfer:291]Op 162: default layout inference pass.
INFO: invoked
INFO: average time: 2.801 ms
INFO: 0.768627: 653 military uniform
INFO: 0.105882: 907 Windsor tie
INFO: 0.0196078: 458 bow tie
INFO: 0.0117647: 466 bulletproof vest
INFO: 0.00784314: 835 suit
```

In both runs, the recognized classifications were military uniforms, Windsor ties, bow ties, and suits. When running on the CPU, the average time consumption was 44.656 ms. When running on the NPU, the average time consumption was 2.801 ms.

### 5.7 Camera Test

The OK-MX8MPX-C supports the OV13850 MIPI camera as well as the UVC camera. First to test the UVC camera, here to Logitech C270 process test, the USB camera will be inserted into the development board, will automatically install uvc driver.

#### 5.7.1 USB Camera Test

Check whether the UVC Camera device node is identified, as shown in the following figure/dev/video4 node, and check the format and resolution supported by the camera:

```plain
root@OK-MX8MPX-C:~# v4l2-ctl --list-devices
 ():
        /dev/v4l-subdev0
        /dev/v4l-subdev1

 ():
        /dev/v4l-subdev2
        /dev/v4l-subdev3

VIV (platform:viv0):
        /dev/video2

VIV (platform:viv1):
        /dev/video3

vsi_v4l2dec (platform:vsi_v4l2dec):
        /dev/video1

vsi_v4l2enc (platform:vsi_v4l2enc):
        /dev/video0

viv_media (platform:vvcam-video.0):
        /dev/media0

UVC Camera (046d:0825) (usb-xhci-hcd.1.auto-1.1):
        /dev/video4
        /dev/video5
        /dev/media1
root@OK-MX8MPX-C:~# 

root@OK-MX8MPX-C:~# v4l2-ctl --list-formats-ext -d /dev/video4
ioctl: VIDIOC_ENUM_FMT
        Type: Video Capture

        [0]: 'YUYV' (YUYV 4:2:2)
                Size: Discrete 640x480
                        Interval: Discrete 0.033s (30.000 fps)
                        Interval: Discrete 0.040s (25.000 fps)
                        Interval: Discrete 0.050s (20.000 fps)
                        Interval: Discrete 0.067s (15.000 fps)
                        Interval: Discrete 0.100s (10.000 fps)
                        Interval: Discrete 0.200s (5.000 fps)
                Size: Discrete 160x120
                        Interval: Discrete 0.033s (30.000 fps)
                        Interval: Discrete 0.040s (25.000 fps)
                        Interval: Discrete 0.050s (20.000 fps)
                        Interval: Discrete 0.067s (15.000 fps)
                        Interval: Discrete 0.100s (10.000 fps)
                        Interval: Discrete 0.200s (5.000 fps)
                Size: Discrete 176x144
.....
```

1. Camera preview:

```plain
root@OK-MX8MPX-C:~# gst-launch-1.0 v4l2src device=/dev/video4 io-mode=2 ! video/x-raw, format=YUY2, width=640, height=480,framerate=30/1 ! imxvideoconvert_g2d ! queue ! video/x-raw, format=RGB16, width=640, height=480 ! waylandsink
[  608.974755] enter isp_mi_stop
[  609.010524] enter isp_mi_stop
[  609.250587] usb 3-1.1: reset high-speed USB device number 3 using xhci-hcd
Setting pipeline to PAUSED ...
Pipeline is live and does not need PREROLL ...
Pipeline is PREROLLED ...
Setting pipeline to PLAYING ...
New clock: GstSystemClock
Redistribute latency...
^Chandling interrupt.
Interrupt: Stopping pipeline ...
Execution ended after 0:00:06.775960375
Setting pipeline to NULL ...
Total showed frames (141), playing for (0:00:06.775873375), fps (20.809).
Freeing pipeline ...
root@OK-MX8MPX-C:~# 
```

You can see a preview of the camera on the screen. Press CTRL + C at the terminal to stop the preview                                            2. Camera to take photos

```plain
root@OK-MX8MPX-C:~# gst-launch-1.0 v4l2src device=/dev/video4 io-mode=2 num-buffers=10 ! video/x-raw,format=YUY2,width=640,height=480,framerate=30/1 ! jpegenc ! filesink location=usb.jpeg
[  512.810753] enter isp_mi_stop
[  512.842836] enter isp_mi_stop
[  513.090557] usb 3-1.1: reset high-speed USB device number 3 using xhci-hcd
Setting pipeline to PAUSED ...
Pipeline is live and does not need PREROLL ...
Pipeline is PREROLLED ...
Setting pipeline to PLAYING ...
New clock: GstSystemClock
Redistribute latency...
Got EOS from element "pipeline0".
Execution ended after 0:00:02.380040000
Setting pipeline to NULL ...
Freeing pipeline ...
root@OK-MX8MPX-C:~# 
```

After running the relevant commands, a file named usb.jpeg will be generated in the current directory. Copy it to a Windows system and open this file to view the taken photo.                                                                                                      3. Camera recording

```plain
root@OK-MX8MPX-C:~# gst-launch-1.0 v4l2src device=/dev/video4 io-mode=2 ! video/x-raw, format=YUY2, width=640, height=480,framerate=30/1 ! imxvideoconvert_g2d ! tee name=t ! queue ! video/x-raw, format=RGB16, width=640, height=480 ! filesink location=uvc.rgb16 t. ! queue ! waylandsink
[  215.478761] enter isp_mi_stop
[  215.510841] enter isp_mi_stop
[  215.746567] usb 3-1.1: reset high-speed USB device number 3 using xhci-hcd
[  216.258773] enter isp_mi_stop
[  216.290540] enter isp_mi_stop
Setting pipeline to PAUSED ...
Pipeline is live and does not need PREROLL ...
Pipeline is PREROLLED ...
Setting pipeline to PLAYING ...
New clock: GstSystemClock
Redistribute latency...
Redistribute latency...
^Chandling interrupt.
Interrupt: Stopping pipeline ...
Execution ended after 0:00:08.409098000
Setting pipeline to NULL ...
Total showed frames (189), playing for (0:00:08.408987875), fps (22.476).
Freeing pipeline ...
root@OK-MX8MPX-C:~# 
```

After using the above command, turn on the camera preview and recording. After a period of time, press Ctrl + C in the terminal to stop the recording. A file named uvc.rgb16 will be generated in the current directory. Then copy uvc.rgb16 to a Windows system and use yuv.exe to open and play it (the resolution is 640×480).

#### 5.7.2 OV5645 Camera Test

Check whether the OV5645 device node is identified, as shown in the following figure/dev/video2 node, and check the format and resolution supported by the camera:

```plain
root@OK-MX8MPX-C:~# v4l2-ctl --list-devices
 ():
        /dev/v4l-subdev0
        /dev/v4l-subdev3
        /dev/v4l-subdev4

 ():
        /dev/v4l-subdev1
        /dev/v4l-subdev5
        /dev/v4l-subdev6

FSL Capture Media Device (platform:32c00000.bus:camera):
        /dev/media0

mxc-isi-cap (platform:32e00000.isi:cap_devic):
        /dev/video2

VIV (platform:viv0):
        /dev/video3

VIV (platform:viv1):
        /dev/video4

vsi_v4l2dec (platform:vsi_v4l2dec):
        /dev/video1

vsi_v4l2enc (platform:vsi_v4l2enc):
        /dev/video0

viv_media (platform:vvcam-video.0):
        /dev/media1
root@OK-MX8MPX-C:~# 
root@OK-MX8MPX-C:~# v4l2-ctl --list-formats-ext -d /dev/video2
ioctl: VIDIOC_ENUM_FMT
        Type: Video Capture Multiplanar

        [0]: 'RGBP' (16-bit RGB 5-6-5)
                Size: Discrete 1280x960
                Size: Discrete 1920x1080
                Size: Discrete 2592x1944
        [1]: 'RGB3' (24-bit RGB 8-8-8)
                Size: Discrete 1280x960
                Size: Discrete 1920x1080
                Size: Discrete 2592x1944
        [2]: 'BGR3' (24-bit BGR 8-8-8)
                Size: Discrete 1280x960
                Size: Discrete 1920x1080
                Size: Discrete 2592x1944
        [3]: 'YUYV' (YUYV 4:2:2)
                Size: Discrete 1280x960
                Size: Discrete 1920x1080
                Size: Discrete 2592x1944
        [4]: 'YUV4' (32-bit A/XYUV 8-8-8-8)
                Size: Discrete 1280x960
                Size: Discrete 1920x1080
                Size: Discrete 2592x1944
.....
```

1. Camera preview:

```plain
root@OK-MX8MPX-C:~# gst-launch-1.0 v4l2src device=/dev/video2 io-mode=4 ! video/x-raw, format=YUY2, width=1280, height=960,framerate=30/1 ! imxvideoconvert_g2d ! queue ! video/x-raw, format=RGB16, width=1024, height=600 ! waylandsink
[  888.282312] enter isp_mi_stop
[  888.314419] enter isp_mi_stop
[  888.382960] mxc-mipi-csi2.1: mipi_csis_imx8mp_phy_reset, No remote pad found!
Setting pipeline to PAUSED ...
Pipeline is live and does not need PREROLL ...
Pipeline is PREROLLED ...
Setting pipeline to PLAYING ...
New clock: GstSystemClock
[  889.142655] bypass csc
[  889.145029] input fmt YUV4
[  889.147811] output fmt YUYV
Redistribute latency...
0:00:01.8 / 99:99:99.
root@OK-MX8MPX-C:~# 
```

You can see a preview of the camera on the screen. Press CTRL + C at the terminal to stop the preview                                            2. Camera to take photos

```plain
root@OK-MX8MPX-C:~# gst-launch-1.0 v4l2src device=/dev/video2 io-mode=4 num-buffers=10 ! video/x-raw,format=YUY2,width=1280,height=960,framerate=30/1 ! jpegenc ! filesink location=5645.jpeg
[ 1120.986895] enter isp_mi_stop
[ 1121.018716] enter isp_mi_stop
[ 1121.086983] mxc-mipi-csi2.1: mipi_csis_imx8mp_phy_reset, No remote pad found!
Setting pipeline to PAUSED ...
Pipeline is live and does not need PREROLL ...
Pipeline is PREROLLED ...
Setting pipeline to PLAYING ...
New clock: GstSystemClock
[ 1121.605557] bypass csc
[ 1121.607943] input fmt YUV4
[ 1121.610721] output fmt YUYV
Redistribute latency...
Got EOS from element "pipeline0".
Execution ended after 0:00:03.473213875
Setting pipeline to NULL ...
Freeing pipeline ...
root@OK-MX8MPX-C:~# 
```

After running the relevant commands, a file named 5645.jpeg will be generated in the current directory. Copy it to a Windows system and open this file to view the taken photo. 3. Camera to record

```plain
root@OK-MX8MPX-C:~# gst-launch-1.0 v4l2src device=/dev/video2 io-mode=4 ! video/x-raw, format=YUY2, width=1280, height=960,framerate=30/1 ! imxvideoconvert_g2d ! tee name=t ! queue ! video/x-raw, format=RGB16, width=1280, height=720 ! filesink location=5645_video.rgb16 t. ! queue ! waylandsink 
[ 1301.182929] enter isp_mi_stop
[ 1301.215002] enter isp_mi_stop
[ 1301.283265] mxc-mipi-csi2.1: mipi_csis_imx8mp_phy_reset, No remote pad found!
Setting pipeline to PAUSED ...
Pipeline is live and does not need PREROLL ...
Pipeline is PREROLLED ...
Setting pipeline to PLAYING ...
New clock: GstSystemClock
[ 1301.917274] bypass csc
[ 1301.919714] input fmt YUV4
[ 1301.922460] output fmt YUYV
Redistribute latency...
Redistribute latency...
^Chandling interrupt.
Interrupt: Stopping pipeline ...
Execution ended after 0:00:02.858870250
Setting pipeline to NULL ...
Total showed frames (70), playing for (0:00:02.858791875), fps (24.486).
Freeing pipeline ...
root@OK-MX8MPX-C:~# 
```

After using the above command, turn on the camera preview and recording. After a while, you can press Ctrl+C in the terminal to stop the recording. This will generate a file named "5645\_video.rgb16" in the current directory. Next, copy the "5645\_video.rgb16" file to your Windows system and use "yuv.exe" to open and play it (with a resolution of 1280x720).

#### 5.7.3 BASLER Camera Test

 Note: The BASLER CAMERA is a MIPI camera without an ISP.

Check if the BASLER device node is recognized; check the supported formats and resolutions of the camera.

```plain
root@OK-MX8MPX-C:~# v4l2-ctl --list-devices
  ():
        /dev/v4l-subdev0
        /dev/v4l-subdev3
        /dev/v4l-subdev4

 ():
        /dev/v4l-subdev1
        /dev/v4l-subdev5
        /dev/v4l-subdev6

 (csi1):
        /dev/v4l-subdev2

FSL Capture Media Device (platform:32c00000.bus:camera):
        /dev/media0

mxc-isi-cap (platform:32e02000.isi:cap_devic):
        /dev/video3

VIV (platform:viv0):
        /dev/video2

VIV (platform:viv1):
        /dev/video4

vsi_v4l2dec (platform:vsi_v4l2dec):
        /dev/video1

vsi_v4l2enc (platform:vsi_v4l2enc):
        /dev/video0

viv_media (platform:vvcam-video.0):
        /dev/media1
root@OK-MX8MPX-C:~# 
root@OK-MX8MPX-C:~# v4l2-ctl --list-formats-ext -d /dev/video4
ioctl: VIDIOC_ENUM_FMT
        Type: Video Capture

        [0]: 'YUYV' (YUYV 4:2:2)
                Size: Stepwise 176x144 - 4096x3072 with step 16/8
        [1]: 'NV12' (Y/UV 4:2:0)
                Size: Stepwise 176x144 - 4096x3072 with step 16/8
        [2]: 'NV16' (Y/UV 4:2:2)
                Size: Stepwise 176x144 - 4096x3072 with step 16/8
        [3]: 'BA12' (12-bit Bayer GRGR/BGBG)
                Size: Stepwise 176x144 - 4096x3072 with step 16/8
.....        
```

1. Camera preview:

```plain
root@OK-MX8MPX-C:~# gst-launch-1.0 v4l2src device=/dev/video4 ! waylandsink
Setting pipeline to PAUSED ...
Pipeline is live and does not need PREROLL ...
Pipeline is PREROLLED ...
Setting pipeline to PLAYING ...
New clock: GstSystemClock
[  878.071124] enter isp_mi_stop
[  878.701872] enter isp_s_comp
[  878.704811] enter isp_s_comp
[  878.707719] enter isp_s_comp
[  878.727743] enter wdr3_hw_init
[  878.730830] wdr3 res: 1920 1080 
[  878.803248] enter isp_set_stream 1
[  878.818830] enter isp_mi_start
Redistribute latency...
0:00:12.8 / 99:99:99.
root@OK-MX8MPX-C:~#     
```

You can see a preview of the camera on the screen. Press CTRL + C at the terminal to stop the preview                                            2. Camera to take photos

```plain
root@OK-MX8MPX-C:~# gst-launch-1.0 v4l2src device=/dev/video4 io-mode=4 num-buffers=10 ! video/x-raw,format=YUY2,width=1280,height=960,framerate=30/1 ! jpegenc ! filesink location=pic.jpeg
[ 1120.986895] enter isp_mi_stop
[ 1121.018716] enter isp_mi_stop
[ 1121.086983] mxc-mipi-csi2.1: mipi_csis_imx8mp_phy_reset, No remote pad found!
Setting pipeline to PAUSED ...
Pipeline is live and does not need PREROLL ...
Pipeline is PREROLLED ...
Setting pipeline to PLAYING ...
New clock: GstSystemClock
[ 1121.605557] bypass csc
[ 1121.607943] input fmt YUV4
[ 1121.610721] output fmt YUYV
Redistribute latency...
Got EOS from element "pipeline0".
Execution ended after 0:00:03.473213875
Setting pipeline to NULL ...
Freeing pipeline ...
root@OK-MX8MPX-C:~# 
```

After running the relevant commands, a file named pic.jpeg will be generated in the current directory. Copy it to a Windows system and open this file to view the taken photo.  3. Camera to record:

```plain
root@OK-MX8MPX-C:~# gst-launch-1.0 v4l2src device=/dev/video4 io-mode=4 ! video/x-raw, format=YUY2, width=1280, height=960,framerate=30/1 ! imxvideoconvert_g2d ! tee name=t ! queue ! video/x-raw, format=RGB16, width=1280, height=720 ! filesink location=basler_video.rgb16 t. ! queue ! waylandsink 
Setting pipeline to PAUSED ...
Pipeline is live and does not need PREROLL ...
Pipeline is PREROLLED ...
Setting pipeline to [ 1634.870239] mxc-mipi-csi2.1: mipi_csis_get_fmt, call get_fmt of subdev failed!
PLAYING ...
New clock: GstSystemClock
[ 1634.884360] mxc-mipi-csi2.0: mipi_csis_imx8mp_phy_reset, No remote pad found!
[ 1634.906835] enter isp_mi_stop
[ 1635.045872] mxc-mipi-csi2.0: mipi_csis_imx8mp_phy_reset, No remote pad found!
[ 1635.063430] enter isp_mi_stop
[ 1635.395107] enter isp_mi_stop
[ 1636.290352] enter isp_s_comp
[ 1636.293275] enter isp_s_comp
[ 1636.296179] enter isp_s_comp
[ 1636.315757] enter wdr3_hw_init
[ 1636.318847] wdr3 res: 1920 1080 
[ 1636.375021] enter isp_set_stream 1
[ 1636.390353] enter isp_mi_start
Redistribute latency...
Redistribute latency...
^Chandling interrupt.
Interrupt: Stopping pipeline ...
Execution ended after 0:00:11.595195500
Setting pipeline to NULL ...
[ 1646.471376] enter isp_set_stream 0
Total showed frames (560), playing for (0:00:11.595152125), fps (48.296).
[ 1646.501389] enter isp_mi_stop
[ 1646.668158] enter isp_mi_stop
Freeing pipeline .....
root@OK-MX8MPX-C:~# 
```

After using the above command, turn on the camera preview and recording. After a while, you can press Ctrl+C in the terminal to stop the recording. This will generate a file named "basler\_video.rgb16" in the current directory. Then copy the basler \_ video. rgb16 to Windows and open it with yuv.exe to play (resolution is 1280 \* 720).

## 6\. OK-MX8MPX-C System Settings

### 6.1 Updating Logo

OK8MP can display LOGO images on LCD or LVDS in the u-boot stage. If you need to replace the LOGO, please replace the following files:   
OK-MX8-linux-sdk/images/logo-1024x600.bmp  
OK-MX8-linux-sdk/images/logo-1280x800.bmp  
The LCD requires a 24 - bit BMP - format image with a resolution of 1024×600.   
The LVDS requires a 24 - bit BMP - format image with a resolution of 1280×800.

You can also replace by yourself in the system:   
/run/media/Boot-mmcblk2p1/logo-1024x600.bmp  
run/media/Boot-mmcblk2p1/logo-1280x800.bmp

### 6.2 Self-starting Program Settings

Forlinx has preset the boot script/etc/autorun. sh through systemd, and this script will run automatically after booting. Users can modify this script to implement the application boot self-start function.   
Users can also set up a new systemd service to realize the automatic startup function of the application.

### 6.3 System Submission Version Check

In the system, you can view the latest submission version number of the system through the /etc/forlinx file.

## 7\. System Flashing

The OK-MX8MPX-C development board currently supports USB flashing via the UUU tool, and also supports flashing via a TF card. The corresponding flashing tools are provided in the user package.

### 7.1 Image Required for Flashing

Image path: User materials\\Software materials\\2 - Images and source code\\0 - Images

| Image Name| Image Description
|----------|----------
| OK8MP-BOOT.bin| uboot
| okmx8mp-c-linux-fs.sdcard.a\*| The entire file system in eMMC, the file obtained after split.
| ramdisk.img.gz| Virtual file system for TF card flashing
| Image| Kernel image
| OK8MP-C.dtb| Device tree

The specific image files are as shown in the figure.    

 ![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908641443-f01e2c2e-8a3a-4ee5-b542-32d736942d54.png)                                                                                                                        

**Note: **

**Since the OK - MX8MPX - C development board has three different specifications of DDR configurations, please rename the provided uboot firmware OK8MP - BOOT - \*.bin corresponding to the DDR configuration to OK8MP - BOOT.bin according to the actual on - board usage before proceeding with the subsequent programming work. The ramdisk.img has been packaged by Forlinx and contains the built - in programming script update.sh. The file system initialization process will execute this script by default. Users can also make their own ramdsik through tools such as busybox.   
The okmx8mp - c - linux - fs.sdcard is compressed and split into okmx8mp - c - linux - fs.sdcard.a. The purpose is to avoid bugs caused by some file systems not supporting overly large files. By merging okmx8mp - c - linux - fs.sdcard.a\*, you can get the programming firmware okmx8mp - c - linux - fs.sdcard.   
okmx8mp-linux-fs.sdcard is the complete file system from the eMMC. The previously mentioned okmx8mp - c - linux - fs.sdcard is the merged file, and okmx8mp - c - linux - fs.sdcard.a is the split file. Please pay attention to the differences.   
The reference commands for merging okmx8mp-linux-fs. sdcard. a \* under Linux system are as follows:**

```plain
root@5d90dd71f33a:~# cat okmx8mp-c-linux-fs.sdcard.a* > okmx8mp-c-linux-fs.sdcard
```

### 7.2 Flashing Uboot via USB

#### 7.2.1 Flashing Uboot to eMMC

Connect the TypeC - USB port of the development board to the PC using a USB cable, set the startup DIP switch of the development board to USB Serial Download, and then power on the development board.   
The PC side runs the cmd program with administrator privileges. In the cmd program, use uuu.exe to flash U-Boot to the eMMC. The command is as follows:

```plain
D:\work\OK-MX8MPX-C\image>uuu.exe -b emmc OK8MP-BOOT.bin
uuu (Universal Update Utility) for nxp imx chips -- libuuu_1.5.165-0-g7347a80
Success 1    Failure 0

1:334    8/ 8 [Done                                  ] FB: done   
```

It prompts that the boot programming is completed. The uboot is programmed into the boot0 partition of the eMMC.

#### 7.2.2 Flashing Uboot to SD

Connect the TypeC - USB port of the development board to the PC using a USB cable, set the startup DIP switch of the development board to USB Serial Download, and then power on the development board..   
The PC side runs the cmd program with administrator privileges. In the cmd program, use uuu.exe to flash U-Boot to the eMMC. The command is as follows:

```plain
D:\work\OK-MX8MPX-C\image>uuu.exe -b sd OK8MP-BOOT.bin
uuu (Universal Update Utility) for nxp imx chips -- libuuu_1.5.165-0-g7347a80
Success 1    Failure 0

1:334    8/ 8 [Done                                  ] FB: done   
```

It prompts that the boot programming is completed. The uboot is programmed to the 32KB offset of the SD card.

#### 7.2.3 Flashing Uboot to QSPIFLASH

Connect the TypeC - USB port of the development board to the PC using a USB cable, set the startup DIP switch of the development board to USB Serial Download, and then power on the development board..   
The PC side runs the cmd program with administrator privileges. In the cmd program, use uuu.exe to flash U-Boot to the eMMC. The command is as follows:

```plain
D:\work\OK-MX8MPX-C\image>uuu.exe -b qspi OK8MP-BOOT.bin
uuu (Universal Update Utility) for nxp imx chips -- libuuu_1.5.165-0-g7347a80
Success 1    Failure 0

1:334    8/ 8 [Done                                  ] FB: done    
```

It prompts that the boot programming is completed. The uboot is programmed to the 4KB offset of the QSPI flash card.

### 7.3 Flashing the Linux System via USB

Connect the TypeC - USB port of the development board to the PC using a USB cable, set the startup DIP switch of the development board to USB Serial Download, and then power on the development board..   
The PC side runs the cmd program with administrator privileges. In the cmd program, use uuu.exe to flash Uboot and file system to the eMMC. The command is as follows:

```plain
D:\work\OK-MX8MPX-C\image>uuu.exe -b emmc_all OK8MP-BOOT.bin okmx8mp-c-linux-fs-vm.sdcard
uuu (Universal Update Utility) for nxp imx chips -- libuuu_1.5.165-0-g7347a80
Success 1    Failure 0

1:334    8/ 8 [Done                                  ] FB: done   
```

It prompts that the programming is completed.                                             Serial port printing:

```plain
........ wrote 10589184 bytes to 'all'
(NULL udevice *): request 00000000fbf20940 was not queued to ep1in-bulk
(NULL udevice *): request 00000000fbf20940 was not queued to ep1in-bulk
Starting download of 2163768 bytes
(NULL udevice *): request 00000000fbf20940 was not queued to ep1in-bulk
................
downloading of 2163768 bytes finished
```

### 7.4 Flashing Uboot to SPIFLASH

Copy the uboot image to the /home/root/ directory of the development board, and execute the following command to program the uboot image OK8MP - BOOT.bin into the spiflash.

```plain
root@OK-MX8MPX-C:~# dmesg  | grep spi                         
[    1.455837] spi-nor spi0.0: w25q128fw (16384 Kbytes)
[    1.461007] 1 fixed-partitions partitions found on MTD device 30bb0000.spi
[    1.467899] Creating 1 MTD partitions on "30bb0000.spi":
[    1.473221] 0x000000000000-0x000001000000 : "qspiflash"
[    3.245186] spi-nor spi1.0: w25q128fw (16384 Kbytes)
[    3.250336] 1 fixed-partitions partitions found on MTD device spi1.0
[    3.256699] Creating 1 MTD partitions on "spi1.0":
[    3.261498] 0x000000000000-0x000001000000 : "spiflash"
root@OK-MX8MPX-C:~# dd if=OK8MP-BOOT.bin of=/dev/mtdblock1
4225+1 records in
4225+1 records out
2163632 bytes (2.2 MB, 2.1 MiB) copied, 16.7952 s, 129 kB/s
```

The uboot is flashed to spiflash, and no offset.

### 7.5 Flashing via TF Card

#### 7.5.1 Making TF Card

##### 7.5.1.1 Making Steps

Two steps are required to make a flashing card:

1. Re-partition the TF card, reserve enough space for uboot image and environment variables in front of the 0 partition, reserve enough space for flashing image in the 0th partition, and format the 0 partition into vfat format;
2. Program the bootloader image to the position with an offset of 32KB on the TF card. Forlinx provides a script tools/mksdboot.sh for making a programming card. You can also refer to the above steps and scripts to make your own flashing cards.

##### 7.5.1.2 Instructions for Using the “mksdboot.sh” Script

**Note: Since the OK - MX8MPX - C development board has three different specifications of DDR configurations, please rename the provided uboot firmware (OK8MP - BOOT - \*.bin) to OK8MP - BOOT.bin according to the actual on - board usage, and then copy it to the TF card for programming.**

Place OK8MP - BOOT.bin and mksdboot.sh in the same directory. 

The usage of mksdboot.sh is as follows:

```plain
root@OK-MX8MPX-C:~# ./mksdboot.sh /dev/mmcblk1 ./OK8MP-BOOT.bin
Usage: mksdboot.sh <device> [<bin>]
    device:  the path of Udisk or TF, such as /dev/sda, /dev/mmcblk1
    bin:     the path of flash.bin, default is '../images/flash.bin'

    example:
        mksdboot.sh /dev/sda
        mksdboot.sh /dev/mmcblk1 ./test.bin
root@OK-MX8MPX-C:~# ./mksdboot.sh /dev/mmcblk1 
DEVICE=/dev/mmcblk1
IMG_UBOOT=OK8MP-BOOT.bin
10+0 records in
10+0 records out
1048576000 bytes (1.0 GB, 1000 MiB) copied, 100.529 s, 10.4 MB/s

Welcome to fdisk (util-linux 2.39.2).
......
mkfs.fat 4.2 (2021-01-31)
1606+0 records in[ 2112.724865]  mmcblk1: p1

1606+0 records out
1644544 bytes (1.6 MB, 1.6 MiB) copied, 0.428018 s, 3.8 MB/s
end !!!
```

#### 7.5.2 Copying the Images to be Programmed to the TF Card

ramdisk.img.gz is already packaged by Forlinx, with a built-in flash script update.sh, which will be executed by default during the file system initialisation process. You can also make your own ramdsik through tools such as busybox.

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908641521-9e4b4103-6808-4584-873b-6d32a997252e.png)

Copy files such as amdisk.img, okmx8mp-c-linux-fs.sdcard.a\*, Image, OK-8MP-C.dtb, OK8MP-BOOT.bin to the tf card

```plain
update start...
......

2+1 records out
1361018880 bytes (1.3GB) copied, 33.916110 seconds, 38.3MB/s
flash /mnt/sd/okmx8mp-c-linux-fs-vm.sdcard.ad, done
>>>>>>>>>>>>>> Flashing successfully completed <<<<<<<<<<<<<<
[Done] 135s
Please power off and boot from emmc.
```

After flashing is completed, turn off the power of the development board, pull out the TF card, and adjust the DIP switch to start the emmc. Then power on to boot from the emmc.

## 8. MCUXpresso\_SDK Development Board

The OK-MX8MPX-C platform has an internal Cortex M7 core and supports development using the MCUXpresso SDK.   
The MCUXpresso SDK is a collection of microcontroller software support that includes peripheral drivers, RPMSG multicore communication, and FreeRTOS. Check the SDK API documentation for the functions and structures it implements.   
The Forlinx OK8MP - SDK package has integrated the MCUXpresso SDK package and cross - compilation tools.

Path: OK - MX8 - linux - sdk/freertos\_8mp

### 8.1 Compiling the Sample Program with the ARM GCC Compiler

The MCUXpresso SDK is compiled using the GCC tool under Linux environment. The following is an example of the hello\_world demo to illustrate the compilation process.   
First set up a Linux compilation environment:

1. Install cmake.

```plain
sudo apt-get install cmake
cmake --version
```

Note: The version of cmake must be greater than 3.0.x to work properly. If your version of is lower than 3.0, you can follow these steps to update.

```plain
cd /tmp
wget https://cmake.org/files/v3.11/cmake-3.11.0-rc4-Linux-x86_64.tar.gz
tar zxvf cmake-3.11.0-rc4-Linux-x86_64.tar.gz
sudo mv cmake-3.11.0-rc4-Linux-x86_64 /opt/cmake-3.11
sudo ln -sf /opt/cmake-3.11/bin/* /usr/bin/
cmake --version
```

2. Set the FreeRTOS environment variables.

```plain
cd OK-MX8-linux-sdk
export ARMGCC_DIR=/mnt/OK-MX8-linux-sdk/freertos_8mp/tools/gcc-arm-none-eabi-10-2020-q4-major
export PATH=$PATH:$ARMGCC_DIR
```

3. Compilation

```plain
cd /mnt/OK-MX8-linux-sdk/freertos_8mp/boards/evkmimx8mp/demo_apps/hello_world/armgcc
./build_release.sh
```

The compilation output is as follows:  
![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908642928-f210ad13-5ab5-41b5-8ab4-fa7957d39c1f.png)

The hello\_world.bin file generated by compilation is in the release directory.  
![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908643003-4bc150bc-5001-42c2-9119-156bbf0c0dcb.png)

Note: You can also compile other versions here, such as build\_ddr\_release.sh. There will be differences when running. Refer to the next section.

### 8.2 Running the Sample Program with Uboot

You can enter the u-boot command line during the startup of the development board and use u-boot commands to load the hello\_world.bin file into the M7 processor and run it. Below is an example using the hello\_world.bin program to explain the running process.

1. Serial port connection                                                                                        Since the hello\_world program uses uart4 as the debugging serial port output, please connect uart4 to the USB port of the PC using a USB to TTL converter according to the schematic diagram before starting the test. And use the serial port debugging tool to open the corresponding COM port, baud rate and other parameters set and OK8MP Debug port parameters are the same.

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908643077-d152bb26-7aa9-425f-82c5-6b6a4972138c.png)

2. Open the M7 debugging serial port.  
![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908643159-ec1a9f2b-d273-4a60-aa33-18b4633eeb89.png)
3. Copy the compiled hello\_world.bin to the root directory of the SD card (Fat32). Insert the SD card into the development board, restart the development board, press the space bar, select 1, and enter the u - boot command line.  
![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908643267-c680973f-71ee-490b-bd7e-46fa24d984d8.png)
4. Execute the following commands in the u - boot command line:  
For the bin files of the debug/release versions, which run on the TCM, execute the following commands (the mmc loading address may need to be adjusted according to the actual partition situation of the TF card):

```plain
u-boot=>fatload mmc 1:1 0x48000000 hello_world.bin;cp.b 0x48000000 0x7e0000 20000;
u-boot=>bootaux 0x7e0000
```

The output of uart4 is as follows:  
![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908643361-7708b8f8-0ff7-4a78-aba0-4575239ce41b.png)

The output of the hello\_world program running on the M7 is as follows:  
![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908643453-8b0874c0-36cf-4e57-826c-791e5c579142.png)

### 8.3 Heterogeneous Multi-core Communication Test

Cortex A53 communicates with Cortex M7 using RPMsg (Remote Processor Messaging).   
RPMsg is a virtio-based message-passing bus that allows kernel drivers to communicate with remote processors available on the system, such as the Cortex M7. The following figure shows a multi - core communication architecture:  
![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908643534-37372fa3-f9d1-4a0b-9da2-4009aeb1a0f8.png)

The MCUXpresso SDK for OK8MP includes a demo called "rpmsg\_lite\_pingpong\_rtos". This demo implements data transfer between the Cortex A53 and the Cortex M7 using shared memory. Additionally, it runs a FreeRTOS task on the Cortex M7.   
Implement this function on the Cortex A53 side through a kernel module. The code is located at: drivers/rpmsg/imx\_rpmsg\_pingpong.c.

The following illustrates multicore communication by compiling and running it.

1. Compile the rpmsg example program.

```plain
cd /mnt/OK-MX8-linux-sdk/freertos_8mp/boards/evkmimx8mp/multicore_examples/rpmsg_lite_pingpong_rtos/linux_remote/armgcc
./build_release.sh
```

The compilation output is as follows:  
![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908643605-d598837c-9a19-4a4c-857a-4fc924aa14e8.png)

The rpmsg\_lite\_pingpong\_rtos\_linux\_remote.bin file generated by compilation is in the release directory.  


2. Replace the dtb file. **To make the example program run normally, the dtb file needs to be replaced.**

Forlinx has provided a dtb file for the demo, which is located at: OK - MX8 - linux - kernel/arch/arm64/boot/dts/freescale/imx8mp - evk - rpmsg.dtb

Copy the imx8mp - evk - rpmsg.dtb file to the root directory of the SD card (Fat32).

3. Replace and load the dtb file under the uboot command line:   
Before replacing the dtb file, please first copy the dtb file to the SD card or other devices (the mmc loading address may need to be adjusted according to the actual partition situation of the TF card), and continue to use the Image file in the mmc:

```plain
u-boot=>fatload mmc 1:1 0x43000000 imx8mp-evk-rpmsg.dtb
u-boot=>fatload mmc 2:1 0x40400000 Image
```

4\. Copy the bin file rpmsg\_lite\_pingpong\_rtos\_linux\_remote.bin compiled in 1 to the root directory of the SD card (Fat32) as well, and load it in the uboot command line (the mmc loading address may need to be adjusted according to the actual partition situation of the TF card):

```plain
u-boot=>fatload mmc 1:1 0x48000000 rpmsg_lite_pingpong_rtos_linux_remote.bin;cp.b 0x48000000 0x7e0000 20000;
u-boot=>bootaux 0x7e0000
u-boot=>run prepare_mcore
u-boot=>run mmcargs
u-boot=>booti 0x40400000 - 0x43000000
```

After running the bin file, you can see the following output on the serial terminal of uart4:   
![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908643693-3fefe57e-7564-4ab1-a72c-cc8254c79e20.png)  
Then enter “boot” in the A53 U - boot command line to start the kernel. At this time, you can see the following output on the serial terminal of the Cortex M7:  
![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908643781-e2dbc822-076f-4e80-9861-6aab7ccf3696.png)

5\. After the system to start, load the following kernel modules on the serial terminal of the Cortex A53:

```plain
modprobe imx_rpmsg_pingpong
```

After the modules are loaded, the Cortex A53 starts to transmit data with the Cortex M7. At this time, you can see the following output on the serial terminal of the Cortex M7:  
![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908643847-51a6df21-8804-4b7f-8dc7-20ae3bf29751.png)

At this time, you can see the following output on the serial terminal of the Cortex A53:  
![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908644029-9f8b30a4-dffb-4fc4-a251-83377b662a70.png)

### 8.4 FreeRTOS Test

The OK8MP has an internal Cortex M7 core on which FreeRTOS applications can run.   
The following is an example of the freertos\_swtimer demo to test FreeRTOS.

1. Enter the  compilation directory:

```plain
cd /mnt/OK-MX8-linux-sdk/freertos_8mp/boards/evkmimx8mp/freertos_examples/freertos_swtimer/armgcc
./build_release.sh
```

The compilation output is as follows:  
![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908644108-65145d20-6fa9-4b85-85a1-526298833cd7.png)

The freertos\_swtimer.bin file generated by compilation is in the release directory.

2. Copy the compiled bin file freertos\_swtimer.bin to the root directory of the SD card (Fat32). Insert the SD card into the TF interface of the development board and load it in the uboot command line (the mmc loading address may need to be adjusted according to the actual partition situation of the TF card):

```plain
u-boot=>fatload mmc 1:1 0x48000000 freertos_swtimer.bin;cp.b 0x48000000 0x7e0000 20000
bootaux 0x7e0000
```

At this time, you can see the following output on the serial terminal of the Cortex M7:  
![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745908644196-d5d097dc-6dc9-4c5d-be30-982bac7fd514.png)

You can see that the terminal periodically prints out the Tick character, indicating that the timer task in the FreeRTOS application is running.