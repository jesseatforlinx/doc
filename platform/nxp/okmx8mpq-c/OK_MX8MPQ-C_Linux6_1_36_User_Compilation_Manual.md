# Linux 6.1.36\_User’s Compilation Manual_V1.0

Document classification: □ Top secret □ Secret □ Internal information ■ Open

## Copyright

The copyright of this manual belongs to Baoding Folinx Embedded Technology Co., Ltd. Without the written permission of our company, no organizations or individuals have the right to copy, distribute, or reproduce any part of this manual in any form, and violators will be held legally responsible.

Forlinx adheres to copyrights of all graphics and texts used in all publications in original or license-free forms.

The drivers and utilities used for the components are subject to the copyrights of the respective manufacturers. The license conditions of the respective manufacturer are to be adhered to. Related license expenses for the operating system and applications should be calculated/declared separately by the related party or its representatives.

## Overview

<font style="color:#333333;">This manual is designed to enable users of the Forlinx Embedded development board to quickly understand the </font><font style="color:#333333;">compilation process</font><font style="color:#333333;">of the products and familiarize themselves with the </font><font style="color:#333333;">compilation </font><font style="color:#333333;">methods </font><font style="color:#333333;">of </font><font style="color:#333333;">Forlinx</font><font style="color:#333333;"> products. The application needs to be cross-compiled on an </font><font style="color:#333333;">ubuntu</font><font style="color:#333333;">host before it can run on the development board. </font>By following the methods provided in the compilation manual and performing practical operations, you will be able to successfully compile your own software code.

The manual will provide instructions for setting up the environment but there may be some unforeseen issues during the environment setup process. For beginners, it is recommended to use the pre-configured development environment provided by us. This will allow you to quickly get started and reduce development time.

Linux systems are typically installed in three ways: dual system on a real machine, single system on a real machine, and virtual machine. Different installation methods have their advantages and disadvantages. This manual only provides methods to build ubuntu in a virtual machine.

Hardware Requirements: It is recommended to have at least<font style="color:black;background-color:#ffffff;">16GB</font><font style="color:black;background-color:#ffffff;"> memory or above.It allows for allocating a sufficient memory to the virtual machine (recommended to allocate</font><font style="color:black;background-color:#ffffff;">10GB</font><font style="color:black;background-color:#ffffff;">or above), while still leaving enough resources for other operations on</font><font style="color:black;background-color:#ffffff;">Windows</font><font style="color:black;background-color:#ffffff;">. Insufficient memory allocation may result in slower performance on</font><font style="color:black;background-color:#ffffff;">Windows.</font>

The manual is mainly divided into four chapters:

+ Chapter 1. Virtual Machine software installation - introduction to downloading and installing Vmware software;
+ Chapter 2. provides the loading of the ubuntu system;
+ Chapter 3. Building, setting up, and installing necessary tools for the Ubuntu system and common issues in development environments;
+ Chapter 4. Compiling the kernel and Linux-related source code.

A description of some of the symbols and formats associated with this manual:

| Format| **Meaning**|
|:----------:|----------|
| **Note** | Note or information that requires special attention, be sure to read carefully. |
| 📚 | Relevant notes on the test chapters. |
| ️️️🛤️ ️ | Indicates the related path.|
| <font style="color:blue;">Blue font on gray background</font>| Refers to commands entered at the command line(Manual input required).|
| <font style="color:black;">Black font</font>| Serial port output message after entering a command. |
| **<font style="color:black;">Bold black</font>**| Key information in the serial port output message. |
| //| Interpretation of input instructions or output information. |
| Username@Hostname| forlinx @ ubuntu: Development environment ubuntu account information, which can be used to determine the environment in which the function operates.|

**Note: Please do not skip this paragraph：   
The development environment is the hardware and software platform that developers need during the development process. The development environment is not a fixed style, here, we explain in detail an embedded Linux development environment to build the method. If you already know a lot about embedded development, you can build the environment according to your needs. If the environment is not the same as this manual and an error occurs, you can resolve it by searching for relevant information from some of the big Linux forums and websites. The development environment introduced in this manual has passed Forlinx’s rigorous testing. If you are not very familiar with embedded development, it is recommended that you set up the environment according to the methods provided by Forlinx to ensure the accuracy and stability of the environment setup.**

**Versions :**

**Operating System: Ubuntu 20.04 64-bit**

**Disk capacity: more than 80G**

**Cross toolchain: aarch64-poky-linux-gcc**

## Application Scope

This manual is mainly applicable to the Linux6.1.36 operating system on the Forlinx OK-MX8MPX-C-C platform. Other platforms can also refer to it, but there will be differences between different platforms. Please make modifications according to the actual conditions.

## Revision History

| **Date**| **Manual Version**| **SoM Version**| **Carrier Board Version**| **Revision History**
|:----------:|:----------:|:----------:|:----------:|----------
| 29/04/2025| V1.0| V2.1| V3.1 and Above| OK-MX8MPQ-C Linux6.1.36 User's Compilation Initial Version

## 1\. VMware Virtual Machine Software Installation

<font style="color:#000000;">This chapter mainly introduces the installation of</font>VMware virtual machines, using VMware Workstation 15 Pro v15.1.0<font style="color:#000000;">as an example to demonstrate the installation and configuration process of the operating system.</font>

### <font style="color:#000000;">1.1 VMware Software Downloads and Purchase</font>

<font style="color:#000000;">Go to the VMware website https://www.vmware.com/cn.html <font style="color:#000000;">to download </font><font style="color:#000000;">Workstation Pro and get the product key. VMware is a paid software that requires purchasing, or you can choose to use a trial version.</font>

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908647042_b60e46a1_289e_46e1_9c8d_d4138dc0a9ec.png)

<font style="color:#000000;">After the download is complete, double-click the startup file to start the installer.</font>

### <font style="color:#000000;">1.2 VMware Software Installation</font>

Step 1: Double-click the startup program to enter the installation instructions, and click "Next";

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908647129_31efe30d_c142_4267_bca2_0676a8221910.png)

Step 2: Check "I accept the terms of the license agreement" and click "Next";

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908647205_2435cc9a_3500_46d9_bec8_805e42852382.png)

Step 3: You can modify the installation location, install it to the partition where your computer installs software, and click "Next";

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908647306_d2db4dbe_cc36_46d1_8289_5e2075a3560b.png)

Step 4: Check the option and click "Next";

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908647377_37b9fd9a_7a3e_4800_9c3a_c764907d867a.png)

Step 5: Check the option to add the shortcuts and click "Next"；

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908647442_89d74b7b_b867_4b4f_9531_85e80149c571.png)

Step 6：Click "Install"；

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908647507_ee998c68_f04b_44ef_8c3f_6f9520680834.png)

Step 7：Wait for the installation to complete；

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908647590_2cbc793c_e0bc_4881_8583_3bfd31fb5f23.png)

Step 8：Click "Finish" to try it out. If users need to use it for a long time, they need to buy it from the official and fill in the license.</font>

## 2\. Loading the Existing Ubuntu Development Environment

**Note:**

+ **It is recommended for beginners to directly use the pre-built virtual machine environment provided by Forlinx, which already includes installed cross-compiler and Qt environment. After understanding this chapter, you can directly jump to the compilation chapter for further study;**
+ **The development environment provided for general users is: forlinx (username), forlinx (password);**
+ **Please ask your sales representative for the download link.**

There are two ways to use a virtual machine environment in VMware: one is to directly load an existing environment, and the other is to create a new environment. Let's first talk about how to load an existing environment.

Step 1: Download the development environment provided by Forlinx. There is MD5 verification file in the development environment data. After downloading the development environment data, first perform MD5 verification on the compressed package of the development environment (MD5 verification can be performed by selecting MD5 online tools on the network, or by downloading MD5 verification tools, which can be selected according to the actual situation). Check whether the verification code is consistent with the verification code in the verification file. If they are consistent, the downloaded file is normal; otherwise, the file may be damaged and needs to be downloaded again;

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908649110_27d0fbbd_e8b8_4059_8c4f_2973eecc3b98.png)

Step 2: Select all compressed files, right-click and extract to the current folder or your own directory:

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908649184_11c577be_bb04_4bb9_8ced_451882b9484a.png)

Step 3: After decompression, get the development environment OK8MP-Linux6.1.36-VM\_17\_5\_2-ubuntu20\_04

The file "forlinx.vmx" in the OK8MP-Linux6.1.36-VM\_17\_5\_2-ubuntu20\_04 folder is the file that you need to open to access the virtual machine.

Step4: Open the installed virtual machine;

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908649254_dc996e40_3873_44e9_a8a2_3c4bbaa5b4cf.png)

Step 5: Select the directory where the OK8MP-Linux6.1.36-VM\_17\_5\_2-ubuntu20\_04 file you just unzipped and generated is located, and double-click to open the startup file:

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908649467_d893a4e8_530c_46c5_af3e_240510624164.png)

Step 6: Turn on this virtual machine after loading is complete to run it and enter the system's interface;

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908649545_b820cf82_e557_4946_95a0_1fd2d5fef10d.png)

Step 7: The default automatic login account is forlinx, and the password is forlinx.

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908649618_bb26c8f1_7490_4626_a08a_d28ccd113f3f.png)

## 3\. New Ubuntu Development Environment Setup

**Note: Beginners are not recommended to set up a system on their own. It is recommended to use an existing virtual machine environment. If you do not need to set up the environment, you can skip this section.**

Ubuntu is a Linux operating system distribution primarily focused on desktop applications. Ubuntu has many advantages and offers its own strengths compared to other Linux distributions. First of all, installing the system is very easy, requiring very little setup, and is fully comparable to a Windows desktop system; secondly, the GUI is very user-friendly and mimics the shortcuts that are commonly used under XP; when installing and upgrading programs, you can install the dependent packages by the system itself through the network, so you don't have to worry about the dependencies of the Linux system anymore. Considering everyone's usage habits and learning needs, it would be a good choice to use Ubuntu Linux.   
There are numerous versions of Linux desktop systems, and currently, all the Linux experiments and source code in this manual are performed on the Ubuntu 22.04 system. With other versions of Linux desktop systems, problems related to the gcc compiler and library files may occur. If you encounter similar issues, you can seek advice and inquire on the official forums of the Linux distribution vendor. If you are not familiar with Linux, the method introduced by Forlinx is highly recommended.   
Why do we need to install these things? Because we need a Linux environment to do development work. We can't compile Kernel source code, Qt applications, uboot and so on under Windows. We need to do these work under Linux environment. Given that most users are accustomed to the Windows environment, we use VMware software to provide Ubuntu virtual machines. Of course, you can also install Linux on your computer or server for development.   
This chapter mainly explains the process of setting up the Ubuntu system and installing Qt Creator. If the user is not using Qt, the installation of Qt Creator can be ignored.

Next, it introduces the process of building the virtual machine.

### 3.1 Ubuntu Virtual Machine Setup

The specific method is as follows:

The version of Ubuntu we chose to install is 20.04, and the introduction and development in this maual are all carried out on Ubuntu20.04. First, go to the Ubuntu official website to get the Ubuntu 20.04 64-bit image. The download address is: [[http://releases.ubuntu.com/20.04/](http://releases.ubuntu.com/20.04/)](http://releases.ubuntu.com/20.04/)

Step 1: Download "Ubuntu-20.04.6-desktop-amd64.iso" (you can download the version that you actually need; this is just an example with 20.04.6);![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908651020_84722bb6_07c4_4a04_a3ca_e539121e7584.png)

Step 2: Open the VMware software and click \[File]/ \[New Virtual Machine]. Enter the following interface, check "Customize" and click "Next":

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908651128_c3f53071_c03f_429f_943d_6b24e9985348.png)

Step 3: Select the compatibility of the corresponding VMware version. The version can be viewed in Help-> About VMware Workstation. Click "Next" after confirmation:

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/14.png)

Step 4: Select “Install program from disc image file”, then click “Next”；

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/20.png)

Step 5: Enter full name, user name and password, and click "Next":

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/17_1756706002298_4.png)

Step 6: Enter the virtual machine name and configuration installation location and click "Next":

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/21.png)

Step 7: Allocate a disk size of 80G and divide the virtual disk into multiple files (it is recommended to allocate at least 80G of space for the virtual machine environment), and click Next:

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/45908651847_bac65ed7_e499_4b64_b6fb_17d8c3288b91_1756706301870_8.png)

Step 8: Enter the virtual machine name and configuration installation location and click "Next":

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908651747_9f3369df_c24d_4dd0_9d50_3f535809b217.png)

Step 9: Allocate memory. It is recommended to allocate more than 8GB of memory: 

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908651847_bac65ed7_e499_4b64_b6fb_17d8c3288b91.png)

Step 10: Configure the number of CPU cores. It is recommended to allocate more than 4 CPUs: 

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908651995_7fe4e5e1_9ed9_496b_801f_53d42f500f9d.png)

Step 11: The basic configuration is as follows:

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/34.png)

The virtual machine creation is now complete.

Step 12: Then click "Start this virtual machine" to start installing the image. Wait patiently.

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908652129_3d0b79ab_82de_413c_b24f_dd28484ed470.png)

The ubuntu system installation is complete.

### 3.2 Basic configuration of Ubuntu system

#### 3.2.1 VMware Tools Installation

VMware Tools will be installed automatically after the virtual machine is created. If it is not successful, follow the steps below.   
If you do not install the tool, you cannot use copy-paste file drag and drop between the Windows host and the virtual machine.

Step 1: First, click on “Virtual Machine” in the VMware navigation bar, and then click on “Install VMware Tools” in the drop-down box;  
![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908652201_41ce57e0_d350_4277_9340_84b88220d157.png)

Step 2: Enter Ubuntu after completion. The VMware Tools CD will appear on the desktop. Click to enter it;  
![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908652272_fc37611c_f753_4f29_b64c_c80ac4e7d1b4.png)

Step 3: Enter, you’ll see a compressed file named VMwareTools - 10.3.10 - 12406962.tar.gz (the name may vary depending on different virtual machine versions). Copy this file to the home directory (i.e., the directory under the personal username in the home folder);  
![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908652338_baeac982_16bf_477a_bda3_c46162c58d27.png)

Step 4: Press 【Ctrl + Alt + T】 to bring up the terminal command interface and enter the commands:

```plain
forlinx@ubuntu:~$ sudo tar -xvf VMwareTools-10.3.10-12406962.tar.gz
```

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908652447_df74001b_ff34_4f41_8069_6f882e3f020f.png)

Step 5: After the extraction is completed, a folder named vmware-tools-distrib will appear;  
![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908652526_0f8ce776_944a_4d09_831e_7858208a9267.png)

Step 6: Go back to the terminal. Enter: cd vmware-tools-distrib to enter this directory.   
Then enter: sudo ./vmware-install.pl. Press Enter and then enter your password. After that, the installation will start. When prompted with a question, enter yes. For other prompts, just press Enter to accept the default settings for installation.![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908652592_bc432f9d_3f5a_4970_9a48_63f13b17a711.png)

#### 3.2.2 Virtual Machine Full Screen Display

If the virtual machine is not able to be displayed in full screen, you can resolve this issue by clicking on "View" and selecting "Autofit Guest." This will adjust the display to fit the screen automatically, enabling you to have a full-screen experience in the virtual machine.   
![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908652657_32689299_dfe4_45bf_aff4_87ad250d5b21.png)  
Make most of the system settings in the location shown. A lot of the setup requirements on Ubuntu can be done here.![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908652731_d4212ee3_83e6_4ad0_bb1c_e00d90053a3a.png)

#### 3.2.3 Virtual Machine Hibernation Settings

Also, the default hibernation is 5min, if you don't want to set hibernation, just set it to Never by setting Power->Blank screen.  
![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908652838_e817ff45_b12e_4ff3_afb1_350648931e81.png)

### 3.3 Virtual Machines Network Settings

#### 3.3.1 NAT Connection Method

By default, after the virtual machine is installed, the network connection method is set to NAT, which shares the host machine's IP address. This configuration does not need to be changed when performing tasks like installing dependencies or compiling code.   
When the VMware virtual NIC is set to NAT mode in a virtual machine, the network in the Ubuntu environment can be set to dynamic IP. In this mode the virtual NAT device and the host NIC are connected to communicate for Internet access. This is the most common way for VM to access the external network.  
![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908652910_be5fb1fc_33f7_4731_9fe0_feea72f53e03.png)

#### 3.3.2 Bridge Connection

When the VMware virtual NIC device is in bridge mode, the host NIC and the virtual machine NIC communicate through the virtual bridge, and the network IP and the host need to be set in the same network segment in the Ubuntu environment. If accessing an external network, you need to set the DNS to be consistent with the host NIC. If TFTP, SFTP and other servers are used, the network contact mode of the virtual machine needs to be set as the bridge mode.  
![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908653041_83342dc2_8c56_47bd_8f77_941474d88088.png)

### 3.4 Virtual Machine Software Installation 

#### 3.4.1 Common Software Installation

It is recommended to switch to the root user before use to avoid installation or compilation failure due to insufficient permissions:

```plain
forlinx@ubuntu:~$ sudo su
[sudo] password for forlinx: 
root@ubuntu:/home/forlinx# 
```

To install the necessary toolkit for OK-MX8MPX-C compilation, please execute the following command to install it, and make sure that the network can be used normally and you can access the external network before installation:

```plain
root@ubuntu:~$ sudo apt-get update
forlinx@ubuntu:~$ sudo apt-get install openssh-server vim git fakeroot make automake \
autoconf libtool libssl-dev bc dosfstools mtools parted iproute2 kmod \
libyaml-dev device-tree-compiler python flex bison build-essential \
u-boot-tools libncurses-dev lib32stdc++6 lib32z1 libc6:i386 python3-pip pip zstd swig \
python-dev python3-dev uuid-dev libghc-gnutls-dev cmake build-essential libgl1-mesa-dev libglu1-mesa-dev freeglut3-dev
forlinx@ubuntu:~$ sudo apt install --reinstall libxcb-xinerama0
forlinx@ubuntu:~$ sudo python3 -m pip install launchpadlib
```

#### 3.4.2 Qt Creator Installation

️Path: User Data\\Software Data\\3 - Tools\\qt - creator - opensource - linux - x86\_64 - 11.0.3.run

Copy the file qt - creator - opensource - linux - x86\_64 - 11.0.3.run to any directory under the current user's directory in the virtual machine, and then execute:

```plain
forlinx@ubuntu:~$ chmod 777 qt-creator-opensource-linux-x86_64-11.0.3.run
forlinx@ubuntu:~$ ./qt-creator-opensource-linux-x86_64-11.0.3.run
```

Step 1: The following interface pops up, and click "Next" to enter the next step:

Note: Turn off the network and install Qt Creator without logging in to the Qt account.

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908653134_2db7bdb6_84de_4c62_a774_3d80769e210e.png)

Step 2: Click "Next" to go to the next step:

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908653206_30cf0ec1_ad79_44c7_a61c_3f393b04378a.png)

Step 3: In the following interface, click "Browse..." to select the installation path of Qtcreator, after the selection is complete, click "Next" to enter the next step:

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908653276_9e3f087f_2623_4ad7_b7b1_e854ff91fab8.png)

Step 4: The following interface pops up, and click "Next" to enter the next step:

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908653340_295a02c4_37d5_4beb_ad8b_9ab7192834b3.png)

Step 5: Agree to the agreement and click "Next":

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908653407_d105a010_6c8e_4483_a3b7_6119ad6c15f9.png)

Step 6: Click Install to install:

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908653476_de9616d4_a8b7_442d_a9e0_56031c7c2e97.png)

Step 7: After the installation is completed, the following interface will be displayed. Uncheck the option "Launch Qt Creator" "and click" Finish "to complete the installation steps of Qt Creator:

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908653546_00bc34fb_4d0a_4c70_ab7d_2772bad587e3.png)

Go to the /home/forlinx/ -11.0. 3/bin/ directory of the actual qtcreator installation directory:

```plain
forlinx@ubuntu:~$ cd /home/forlinx/qtcreator-11.0.3/bin/
forlinx@ubuntu: ~/qtcreator-11.0.3/bin$ sudo ./qtcreator
[sudo] password for forlinx: forlinx                         //输入forlinx用户的密码，无回显
QStandardPaths: XDG_RUNTIME_DIR not set, defaulting to '/tmp/runtime-root'
QStandardPaths: XDG_RUNTIME_DIR not set, defaulting to '/tmp/runtime-root'
```

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908653611_afe15eb1_569c_43ac_afb9_50be0e93c0ba.png)

The Qt Creator tool screen appears. Qt Creator is installed.

#### 3.4.3 Qt CREATOR Configuration

Install the cross-compilation tool

```plain
root@ubuntu:/home/forlinx/work/OK-MX8-linux-sdk# ./fsl-imx-xwayland-glibc-x86_64-forlinx-image-qt6-full-armv8a-fet-mx8mp-c-toolchain-6.1-mickledore.sh
NXP i.MX Release Distro SDK installer version 6.1-mickledore
============================================================
Enter target directory for SDK (default: /opt/fsl-imx-xwayland/6.1-mickledore):/opt/fsl-imx-xwayland/6.1-mickledore-imx8mp
```

Set the installation path, enter

```plain
/opt/fsl-imx-xwayland/6.1-mickledore-imx8mp
```

The cross-compilation tool chain is automatically installed in the/opt directory when compiling the SDK for the first time. The Qt compilation environment needs to be configured after the cross-compilation tool chain is installed

First open the Qt Creator software.

Step 1: Navigate to the actual installation directory of Qt Creator, which is /home/forlinx/qtcreator-11.0.3/bin;

```plain
forlinx@ubuntu:~$ cd /home/forlinx/qtcreator-11.0.3/bin
forlinx@ubuntu: ~/qtcreator-11.0.3/bin $ sudo ./qtcreator
[sudo] password for forlinx: forlinx                         //输入forlinx用户的密码，无回显
QStandardPaths: XDG_RUNTIME_DIR not set, defaulting to '/tmp/runtime-root'
```

Step 2: Launch the Qt Creator program. Click on “Edit” -> “Preferences”;

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908653673_1ef201b5_9d67_483a_a4e8_4e30b4ed1427.png)

Step 3: Once you’re in the Preferences interface, click on “Kits” on the left side. Then click on the “Compilers” tab in the upper - middle area. Click on “Add -> GCC -> C++” on the right side, as shown in the figure;

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908653742_2f3b4f2b_1ba7_4c1f_bc3d_28d6a200922d.png)

specify the Compiler path. Click on “Browse”. Find “aarch64 - poky - linux - g++” under /opt/fsl - imx - xwayland/6.1 - mickledore - imx8mp/sysroots/x86\_64 - pokysdk - linux/usr/bin/aarch64 - poky - linux/. After selecting it, click on “Open”. Change the Name to “G++”, and finally click on “Apply” to save the configuration;

Step 4: Add the GCC compiler in the same way. Click on “Add -> GCC -> C” on the right side. The Compiler path for GCC is: /opt/fsl - imx - xwayland/6.1 - mickledore - imx8mp/sysroots/x86\_64 - pokysdk - linux/usr/bin/aarch64 - poky - linux/aarch64 - poky - linux - gcc, as shown in the figure;

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908653809_3b1a62e6_6ccd_4b57_869c_b7d742845595.png)

Step 5: Refer to the steps for adding compilers to add Debuggers. The Path for Debuggers is: /opt/fsl - imx - xwayland/6.1 - mickledore - imx8mp/sysroots/x86\_64 - pokysdk - linux/usr/bin/aarch64 - poky - linux/aarch64 - poky - linux - gdb;

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908653880_a5f444f1_754c_4aea_aaad_97f2ff08e449.png)

Step 6: Click on the “Qt Versions” tab and then click on “Add”. Find “qmake” in the directory /opt/fsl - imx - xwayland/6.1 - mickledore - imx8mp/sysroots/x86\_64 - pokysdk - linux/usr/bin/. After selecting it, click on “Open”. After adding, it will be displayed as follows. Then click on “Apply”;

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908653962_b9b1c87f_5d91_4225_bf3d_75e146092430.png)

Step 7: Click on the “Kits” tab. Click on “Add” on the right side to add a new Kit. Name it “imx8mp”. Make modifications according to the content in the following figure and then click on “Apply”;

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908654042_2f27ed3d_ff0f_4969_a495_6901426cb450.png)

### 3.5 Handling Virtual Machine Error Reports

**Error 1: Unable to connect to MKS: Too many socket connection attempts; giving up.**

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908654137_b230e9a1_893f_468f_af79_737ce2f943c6.png)  
Solution:   
My Computer -> Right click -> Management -> Services and Applications -> Services: turn on all the services about VMware.   
![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908654217_533de949_6e65_420a_851c_42d1b0e1bba8.png)  
After the service has started successfully, restart the virtual machine; or hang the virtual machine first, wait for it to start, and then continue to run the hung virtual machine

**Error 2: Internal error**

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908654324_b6d80e7e_40bb_4989_9a40_573992e2aad5.png)  
Solution: Refer to solution 1

**Error 3: Unable to install service VMware Authorization Service (VMAuthdService)**

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908654426_57fe45f5_74d9_4ec2_a1b8_0f13fc71786d.png)

Solution:   
win+R Enter the services. Msc.

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908654529_9d639335_46f1_476d_b1d5_e88a7d34af75.png)  
Then find the service and start it up as an authorization and authentication service for starting and accessing virtual machines.   
![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908654636_bde763fb_3fec_4b0a_8667_bb7fbf00262f.png)  
WMI must start first.  
![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908654729_0c1b097a_3e98_4e4f_a0ff_8dc31642cb86.png)

**Error 4：Failed to install the hcmon driver**

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908654802_0a4a859a_4dc5_4b26_878c_90cbabd15ed9.png)  
Solution: Delete C:\\Windows\\System32\\drivers\\hcmon.sys, then install again.

**Error 5: Intel VT-x is disabled**

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908654869_20ad29ca_2121_4399_9ad5_b9eb57c73532.png)

Solution:   
①Enter the BIOS interface (F2 or F12) when booting.  
②configuration--》intel virtual technology--》Change “disabled” to “enabled”, then save the settings, exit the program, and restart the device.   
③Reopen VMware and turn on the virtual machine.   
If that doesn't work, just turn the firewall off and reopen the VM. (varies by machine)

**Error 6: The virtual machine appears to be in use... Acquiring Ownership (T)**

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908654942_b504bda9_f961_4f05_a719_39e838217cd4.png)

Solution:   
1\. Shut down the virtual machine;

2\. Navigate to the storage directory of the virtual machine and delete all files with the extension \*.lck. Here, the ".lck" extension indicates locked files;

3\. Open the Windows Task Manager and terminate all VMware - related processes;![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908655040_444da5e9_5747_4989_b46f_185862b10a1b.png)

4. Restart the virtual machine, and the issue should be resolved. 

**Error 7: Failed to lock file**

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908655103_f82ce558_3368_4830_83ca_bbd1bbe891e6.png)

Solution:   
①Enter the storage directory of the virtual machine  
②Delete.vmem.lck，.vmdk.lck，\*.vmx.lck  
③Restart the virtual machine and enter the virtual machine normally

**Error 8：The virtual machine could not be started because there was not enough memory available on the host.**

Solution:   
The virtual machine does not have enough memory to run the image's maximum requirements; increase the virtual machine's memory and reboot the virtual machine.

![Image](./images/OK_MX8MPQ-C_Linux6_1_36_User_Compilation_Manual/1745908655178_2fb6d560_8178_4dd1_a06b_28a3af6b7dbb.png)

## 4\. Related Code Compilation

The source code package contains the source code required by OK8MP platform provided by Forlinx, including Linux kernel source code, test program source code, file system, etc. You can carry out secondary development on this basis.   
Copy the CD-ROM Path: OK8MP - C (Linux) User Materials\\Linux\\Source Code\\OK - MX8 - linux - sdk.tar.zst.0\*

to the virtual machine directory.

```plain
root@ubuntu:/home/forlinx# cd /home/forlinx/work
root@ubuntu:/home/forlinx/work# cat OK-MX8-linux-sdk.tar.zst.0* >> OK-MX8-linux-sdk.tar.zst
root@ubuntu:/home/forlinx/work# tar --zstd -xvf OK-MX8-linux-sdk.tar.zst
root@ubuntu:/home/forlinx/work# ls
OK-MX8-linux-sdk          OK-MX8-linux-sdk.tar.zst.00  OK-MX8-linux-sdk.tar.zst.02
OK-MX8-linux-sdk.tar.zst  OK-MX8-linux-sdk.tar.zst.01  OK-MX8-linux-sdk.tar.zst.03

```

### 4.1 Common File Paths for Source Code

#### 4.1.1 Kernel Source Code Path

OK-MX8MPX-C platform, the software configuration file path (starting under the SDK source code OK-MX8-linux-sdk path) is as follows:

| Name| Path |
|----------|----------|
| Linux kernel source code| OK-MX8-linux-sdk/OK-MX8-linux-kernel/|
| Kernel default configuration file| OK-MX8-linux-sdk/OK-MX8-linux-kernel/arch/arm64/configs/OK8MP-C\_defconfig|
| Device tree file| OK-MX8-linux-sdk/OK-MX8-linux-kernel/arch/arm64/boot/dts/freescale/OK8MP-C.dts OK-MX8-linux-sdk/OK-MX8-linux-kernel/arch/arm64/boot/dts/freescale/imx8mp.dtsi|
| File system source files.| OK-MX8-linux-sdk/ok-mx8mp-c-fs/|
| When compiling, the files in the overlay will overwrite those with the same name under the same path in rootfs, so users can operate in the overlay-related directory when modifying the file system.||
| SDK root directory| OK-MX8-linux-sdk/|
| Test program source code| OK-MX8-linux-sdk/appsrc/|
| Generate image path| OK-MX8-linux-sdk/images|
| Tools directory| OK-MX8-linux-sdk/tools|
| Extra directory| OK-MX8-linux-sdk/extra\_8mp|

#### 4.1.2 Test Program Source Code Path

+ For the OK - MX8MPX - C platform, the paths of the test programs (starting from the path of the SDK source code OK - MX8 - linux - kernel) are as follows:
+ OK - MX8 - linux - sdk/appsrc/forlinx - cmd: Source code directory of the command - line test program;
+ OK - MX8 - linux - sdk/appsrc/forlinx - qt: Source code directory of the Qt test program;

##### 4.1.2.1 Qt Test Program Source Code Path

| Name| path
|----------|----------
| 4g| OK-MX8-linux-sdk/appsrc/forlinx-qt/fltest\_qt\_4g
| Sound recording| OK-MX8-linux-sdk/appsrc/forlinx-qt/fltest\_qt\_audiorecorder
| Backlight| OK-MX8-linux-sdk/appsrc/forlinx-qt/fltest\_qt\_backlight
| SQL| OK-MX8-linux-sdk/appsrc/forlinx-qt/fltest\_qt\_books
| camera| OK-MX8-linux-sdk/appsrc/forlinx-qt/fltest\_qt\_camera
| Video play| OK-MX8-linux-sdk/appsrc/forlinx-qt/fltest\_qt\_musicplayer
| Network Configuration| OK-MX8-linux-sdk/appsrc/forlinx-qt/fltest\_qt\_network
| ping| OK-MX8-linux-sdk/appsrc/forlinx-qt/fltest\_qt\_ping\_test
| OpenGL| OK-MX8-linux-sdk/appsrc/forlinx-qt/fltest\_qt\_qopenglwidget
| rtc| OK-MX8-linux-sdk/appsrc/forlinx-qt/fltest\_qt\_rtc
| Serial test| OK-MX8-linux-sdk/appsrc/forlinx-qt/fltest\_qt\_terminal
| WiFi| OK-MX8-linux-sdk/appsrc/forlinx-qt/fltest\_qt\_wifi
| Watchdog| OK-MX8-linux-sdk/appsrc/forlinx-qt/fltest\_qt\_watchdog
| Desktop| OK-MX8-linux-sdk/appsrc/forlinx-qt/matrix-browser

##### 4.1.2.2 Command Test Program Source Code Path

| Name| path
|----------|----------
| UART| OK-MX8-linux-sdk/appsrc/forlinx-cmd/uarttest
| Watchdog| OK-MX8-linux-sdk/appsrc/forlinx-cmd/watchdog
| 4G| OK-MX8-linux-sdk/appsrc/forlinx-cmd/quectel-CM
| serial| OK-MX8-linux-sdk/appsrc/forlinx-cmd/serial\_tool
| spi| OK-MX8-linux-sdk/appsrc/forlinx-cmd/spitest

### 4.2 Compilation Test

#### 4.2.1 Full Flash Image Compilation

It is recommended to switch to the root user before use to avoid installation or compilation failure due to insufficient permissions:

```plain
forlinx@ubuntu:~$ sudo su
[sudo] password for forlinx: 
root@ubuntu:/home/forlinx# 
```

Start the compilation. Enter the SDK directory:

```plain
root@ubuntu:/home/forlinx/work# cd OK-MX8-linux-sdk
root@ubuntu:/home/forlinx/work/OK-MX8-linux-sdk# tree -L 1
.
├── appsrc
├── build_8mp.sh
├── build.sh -> build_8mp.sh
├── commit_id.txt
├── extra_8mp
├── forlinx-image-qt6-full-fet-mx8mp-c-202410221050.rootfs.tar.zst
├── freertos_8mp
├── fsl-imx-xwayland-glibc-x86_64-forlinx-image-qt6-full-armv8a-fet-mx8mp-c-toolchain-6.1-mickledore.sh
├── OK8MP-BOOT-1G.bin
├── OK8MP-BOOT-2G.bin
├── OK8MP-BOOT-4G.bin
├── OK-MX8-linux-kernel
├── overlay_8mp
└── tools


root@ubuntu:/home/forlinx/work/OK-MX8-linux-sdk# ./build.sh all
INFO: build uboot...
...
INFO: build imx-atf...
...
INFO: build kernel...
...
INFO: build extra...
...
INFO: build apps...
...
INFO: build version...
...
INFO: build rootfs...
...
INFO: pack imgs...
...

```

After executing the compilation script, the above - mentioned compilation content will appear in the serial port. After waiting for the compilation to complete, image files will be generated in the “images” directory.

```plain
root@ubuntu:/home/forlinx/workOK-MX8-linux-sdk# cd images
root@ubuntu:/home/forlinx/work/OK-MX8-linux-sdk/images# tree
.
├── boot.img
├── Image
├── OK8MP-BOOT.bin
├── OK8MP-C.dtb
├── okmx8mp-c-linux-fs.sdcard
├── okmx8mp-c-linux-fs.sdcard.aa
├── okmx8mp-c-linux-fs.sdcard.ab
├── okmx8mp-c-linux-fs.sdcard.ac
├── okmx8mp-c-linux-fs.sdcard.ad
├── okmx8mp-c-linux-fs.sdcard.md5sum
├── rootfs.ext4
└── uboot
...

```

Uboot firmware: OK8MP - BOOT.bin

Device tree binary file: OK8MP - C.dtb

Kernel image: Image

File system: okmx8mp - c - linux - fs.sdcard.a\*

Ramdisk: The ramdisk file system is used for burning the eMMC from the TF card.

#### 4.2.2 Separate Compilation of the Kernel

```plain
root@ubuntu:/home/forlinx/work# cd OK-MX8-linux-sdk
root@ubuntu:/home/forlinx/work/OK-MX8-linux-sdk# ./build.sh kernel
INFO: build kernel...
/home/forlinx/work/OK-MX8-linux-sdk/OK-MX8-linux-kernel /home/forlinx/work/OK-MX8-linux-sdk
#
# configuration written to .config
#
  SYNC    include/config/auto.conf.cmd
  CALL    scripts/checksyscalls.sh
  CALL    scripts/checksyscalls.sh
....
INFO: build extra...
....

```

Note: During compilation, the system will automatically copy the configuration file “arch/arm64/configs/OK8MP - C\_defconfig” to overwrite the “.config” file in the kernel root directory. Clean the compiled kernel image.

```plain
root@ubuntu:/home/forlinx/work# cd OK-MX8-linux-sdk
root@ubuntu:/home/forlinx/work/OK-MX8-linux-sdk# ./build.sh clean_kernel
INFO: clean extra...
...
INFO: clean kernel...
...
```

#### 4.2.3 Separate Compilation of the Test Program

```plain
root@ubuntu:/home/forlinx/work# cd OK-MX8-linux-sdk
root@ubuntu:/home/forlinx/work/OK-MX8-linux-sdk# ./build.sh apps
INFO: build apps...
/home/forlinx/work/OK-MX8-linux-sdk/appsrc /home/forlinx/work/OK-MX8-linux-sdk
/home/forlinx/work/OK-MX8-linux-sdk/appsrc/forlinx-qt /home/forlinx/work/OK-MX8-linux-sdk/appsrc /home/forlinx/work/OK-MX8-linux-sdk
cd fltest_qt_4g/ && ( test -e Makefile || /opt/fsl-imx-xwayland/6.1-mickledore_imx8mp/sysroots/x86_64-pokysdk-linux/usr/bin/qmake -o Makefile /home/forlinx/work/OK-MX8-linux-sdk/appsrc/forlinx-qt/fltest_qt_4g/fltest_qt_4g.pro ) && make -f Makefile 
cd fltest_qt_audiorecorder/ && ( test -e Makefile || /opt/fsl-imx-xwayland/6.1-mickledore_imx8mp/sysroots/x86_64-pokysdk-linux/usr/bin/qmake -o Makefile /home/forlinx/work/OK-MX8-linux-sdk/appsrc/forlinx-qt/fltest_qt_audiorecorder/fltest_qt_audiorecorder.pro ) && make -f Makefile 
cd fltest_qt_books/ && ( test -e Makefile || /opt/fsl-imx-xwayland/6.1-mickledore_imx8mp/sysroots/x86_64-pokysdk-linux/usr/bin/qmake -o Makefile /home/forlinx/work/OK-MX8-linux-sdk/appsrc/forlinx-qt/fltest_qt_books/fltest_qt_books.pro ) && make -f Makefile 
cd fltest_qt_backlight/ && ( test -e Makefile || 
...
```

After execution, the command - line test program will be installed in the “overlay/usr/bin/” directory of the file system.

Clean the compiled test program.

```plain
root@ubuntu:/home/forlinx/work# cd OK-MX8-linux-sdk
root@ubuntu:/home/forlinx/work/OK-MX8-linux-sdk# ./build.sh clean_apps
INFO: clean apps...
...
```