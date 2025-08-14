# Linux5.15.147\_User’s Compilation Manual

Document classification: □ Top secret □ Secret □ Internal information ■ Open

## Copyright

The copyright of this manual belongs to Baoding Folinx Embedded Technology Co., Ltd. Without the written permission of our company, no organizations or individuals have the right to copy, distribute, or reproduce any part of this manual in any form, and violators will be held legally responsible.

Forlinx adheres to copyrights of all graphics and texts used in all publications in original or license-free forms.

The drivers and utilities used for the components are subject to the copyrights of the respective manufacturers. The license conditions of the respective manufacturer are to be adhered to. Related license expenses for the operating system and applications should be calculated/declared separately by the related party or its representatives.

## <font style="color:black;">Overview</font>

<font style="color:#333333;">This manual is designed to enable users of the Forlinx Embedded development board to quickly understand the</font> <font style="color:#333333;">compilation process</font><font style="color:#333333;">of the products and familiarize themselves with the </font><font style="color:#333333;">compilation</font> <font style="color:#333333;">methods </font><font style="color:#333333;">of</font> <font style="color:#333333;">Forlinx</font><font style="color:#333333;"> products. The application needs to be cross-compiled on an </font><font style="color:#333333;">ubuntu</font> <font style="color:#333333;">host before it can run on the development board.</font>By following the methods provided in the compilation manual and performing practical operations, you will be able to successfully compile your own software code.

The manual will provide instructions for setting up the environment but there may be some unforeseen issues during the environment setup process. For beginners, it is recommended to use the pre-configured development environment provided by us. This will allow you to quickly get started and reduce development time.

Linux systems are typically installed in three ways: Dual system on a real machine, single system on a real machine, and virtual machine. Different installation methods have their advantages and disadvantages. This manual only provides methods to build ubuntu in a virtual machine. 

Computer Hardware Requirements: It is recommended to have at least 16GB memory or above. It allows for allocating a sufficient memory to the virtual machine (recommended to allocate 10GB or above), while still leaving enough resources for other operations on Windows. Insufficient memory allocation may result in slower performance on Windows.

The manual is mainly divided into five chapters:

Chapter 1. is about the installation of virtual machine software, providing a brief introduction to the download and installation of VMware software;

Chapter 2. offers the loading of the Ubuntu system;

Chapter 3. is about the setup, configuration and installation of necessary tools for the Ubuntu system, as well as common issues related to the development environment;

Chapter 4. is the data and compilation method required for the compilation of the source code of the product;

Chapter 5. Configuration of the Qt compilation environment and methods for compiling programs;

A description of some of the symbols and formats associated with this manual:

| **Format**| **Meaning**|
|:----------:|----------|
| //| Interpretation of input instructions or output information|
| Username@Hostname| root@forlinx： Development board login account information,                                                                                          forlinx@ubuntu Development environment: Ubuntu account information.                                                                                Users can use this information to determine the environment for functional operations. |

For example, when copying source code, you can use the “ls” command to view the source code files:

```plain
forlinx@ubuntu:~$ ls /mnt/hgfs/share/                                //View files in a shared directory
OKT527-linux-sdk.tar.bz2
```

forlinx@ubuntu: The username is forlinx and the hostname is ubuntu, indicating that the user forlinx is used on the development environment ubuntu for operations.

// : Explanation of ls /run/media operation, no input required.

## Application Scope

This software manual is applicable to the <font style="color:rgb(0,0,0);">OK527 platform Linux 5.15 operating system of Forlinx.</font>

# <font style="color:black;">Revision History</font>

| Date| Manual Version| Revision History|
|:----------:|:----------:|----------|
| 28/04/2025 | V1.0| User's Compilation Manual Initial Version|

## 1. VMware Virtual Machine Software Installation

This chapter mainly introduces the installation of VMware virtual machines, using VMware Workstation 15 Pro v15.5.6 as an example to demonstrate the installation and configuration process of the operating system.

### <font style="color:black;">1.1</font><font style="color:black;">  </font><font style="color:black;">VMware</font><font style="color:black;">Software Download \& Purchase</font>

Visit Vmware official website [https://www.vmware.com/cn.html](https://www.vmware.com/cn.html) for downloading Workstation Pro and obtaining the product key. VMware is a paid software that requires purchasing, or you can choose to use a trial version.

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1723079121244-b1781bd8-d4da-4103-bf22-b85ea7b85834.png)

After the download is complete, double-click the installation file to start the installation program.

### <font style="color:black;">1.2 VMware Software</font> Installation 

Double-click the startup program to enter the installation wizard.

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1723079142871-4a15056b-c774-4cdf-8285-2bb081323c93.png)

Click on "Next".

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1723079159587-f1bc696a-cc53-4b7d-8df1-9f0660cc88c5.png)

Check the terms in the license agreement that I accept, then click "Next".

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1723079174511-f70aee38-d83e-4d75-b875-bbc0968ef617.png)

Modify the installation location to the partition where you want to install the software on your computer, then click '"Next".

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1723079184114-1cdf6c73-4a92-4713-9595-47a8c36c164c.png)

Check and click on "Next".

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1723079198669-5c9c9b4c-9a51-41ef-9bcb-c157ed98e036.png)

Check the box to add a shortcut, then click "Next".

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1723079209843-fb94bed8-c4c3-40e6-badd-a9336c61b81d.png)

Click "Installation".

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1723079221521-57505963-3f30-4034-ab79-3febbe1b8959.png)

Wait for the installation to complete.

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1723079233778-a6d19fda-9c5c-40cf-853b-c76a62f3f3b6.png)

Click "Finish" to try it out. If users need to use it for a long time, they need to buy it from the official and fill in the license.

## 2. Loading the Existing Ubuntu Development Environment

**Note:**

**It is recommended for beginners to directly use the pre-built virtual machine environment provided by Forlinx, which already includes installed cross-compiler and Qt environment. After understanding this chapter, you can directly jump to the compilation chapter for further study.**

**The development environment provided for general users is: forlinx (username), forlinx (password). The superuser is: root (username), root (password).**

Please ask your sales representative for the download link.

There are two ways to use a virtual machine environment in VMware: one is to directly load an existing environment, and the other is to create a new environment. First talk about how to load an existing environment.

First, download the development environment provided by Forlinx. There is an MD5 verification file in the development environment data. After downloading the development environment data, the user first performs MD5 verification on the compressed package of the development environment (02-User Data \\ 01-Software Data \\ 04-Tools \\ md5sums-1.2.zip) to check whether the verification code is consistent with the verification code in the verification file. If they are consistent, the downloaded file is normal; if not, the file may be damaged and needs to be downloaded again.

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718948365948-5822150f-e7ea-483d-8743-ea64e4ab08fd.png)

Select OK527-VM15.5.6-ubuntu20.04 and right click to extract to the current folder or your own directory:

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718948388548-5aa3ea5e-8d97-4cab-98ec-f9689e6e2f7f.png)

After the extraction is complete, you will obtain the development environment OK527-VM15.5.6-ubuntu20.04.

OK527-VM15.5.6-ubuntu20.04 folder in the OK527-VM15.5.6-ubuntu20.04.vmx is the file to be opened by the virtual machine.

Open the installed virtual machine.

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718948433154-61bdd056-eea7-412e-bb47-2ca27326221e.png)

Navigate to the directory where the recently extracted OK527-VM15.5.6-ubuntu20.04 virtual machine file is located, and double-click on the startup file to open it.

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718948455858-24fdc770-800f-4c2b-8a57-4541461a3d0c.png)

Turn on this virtual machine after loading is complete to run it and enter the system's interface.

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718948476623-d85ceac2-9abb-47c0-bf44-8b57fe5189bc.png)

The default login account for automatic login in the development environment is "forlinx".

## 3. New Ubuntu Development Environment Setup

**Note: Beginners are not recommended to set up a system on their own. It is recommended to use an existing virtual machine environment. If you do not need to set up the environment, you can skip this section.**

This chapter mainly explains the process of setting up the Ubuntu system and installing Qt Creator. If the user is not using Qt, the installation of Qt Creator can be ignored.

### <font style="color:black;">3.1</font><font style="color:black;">  </font><font style="color:black;">Ubuntu</font><font style="color:black;">System Setup</font>

The version of Ubuntu we chose to install is 20.04, and the introduction and development in this maual are all carried out on Ubuntu20.04. First, go to the Ubuntu official website to get the Ubuntu 20.04 64-bit image. The download address is: [[http://releases.ubuntu.com/20.04/](http://releases.ubuntu.com/20.04/)](http://releases.ubuntu.com/20.04/)

Download "Ubuntu-20.04.6-desktop-amd64.iso" (you can download the version that you actually need; this is just an example with 20.04.6).

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718948846066-ec162f18-7e2d-4487-ac4d-e38cdc5ed1fa.png)

#### <font style="color:black;">3.1.1 Ubuntu Virtual Machine Setup</font>

Step 1: Open the VMware software and click on "Create New Virtual Machine". Enter the following interface, check "Customize (Advanced)" and click "Next":

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718948893126-e3590cfb-7439-4651-924f-a2d10374da9f.png)

Step 2: Select the compatibility of the corresponding VMware version. The version can be viewed in Help-> About VMware Workstation. Click "Next" after confirmation:

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718948932428-9511048d-e2d7-4f7a-8395-0821cef9cb79.png)

Select “Install program from disc image file”, then click “Next”；

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718948970851-e5167620-f7bc-4451-9278-0138cdc7719c.png)

Enter full name, user name and password and click "Next":

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718948988345-6bc05b9f-e9f7-4f69-9958-6601680f096b.png)

Enter the virtual machine name and configuration installation location, and click "Next":

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718949004063-573e7818-db79-447f-87be-7300ada8564f.png)

To configure the number of cores, click "Next":

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718949028219-34f18366-f692-4a22-b57b-54d17b6c25ad.png)

To configure at least 8GB of memory, select Next:

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718949106542-abdb4dd3-94ff-4717-aae8-49ff1552ddc5.png)

Set the network type, use the default NAT form for networking, and click "Next". Keep the default values for the remaining steps until you reach the step to specify the disk capacity.

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718949123407-6494b5a1-1357-440c-95d5-99782ec611f7.png)

Use the recommended I/O controller; click "Next":

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718949139079-ff464474-be29-4f7a-8bd4-947d20c6330c.png)

Use the recommended disk type; click "Next":

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718949153183-98ee5751-ae4f-4587-94b0-471fc1a3ae2a.png)

Use the default options; create a new virtual disk and click "Next":

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718949166693-8782adbb-56d4-4831-bb1c-31b4156f3740.png)

Allocate a disk size of 80G and divide the virtual disk into multiple files, and click "Next":

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718949181244-213bc0ba-c5c3-4af7-b2bf-e376f015b5c7.png)

Click "Next" by default:

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718949199722-746f65a3-37d5-4f62-947b-a5569544f780.png)

Click "Finish":

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718949214671-bc902643-637a-486d-9ac4-61a49f72171d.png)

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718949231445-fcd76a84-fea5-451c-ad59-800cd108292e.png)

The virtual machine creation is now complete.

Then click "Open this virtual machine" to start installing the image and wait patiently.

The ubuntu system installation is complete.

#### <font style="color:black;">3.1.2 Ubuntu</font><font style="color:black;">Basic Configuration</font>

##### <font style="color:black;">3.1.2.1</font><font style="color:black;">  </font><font style="color:black;">VMware Tools</font><font style="color:black;">Installation</font>

VMware Tools will be installed automatically after the virtual machine is created. If it is not successful, follow the steps below.

If you do not install the tool, you cannot use copy-paste file drag and drop between the Windows host and the virtual machine.

First click on "Virtual Machine" on the VMware navigation bar, then click "Install VMware Tools" in the drop-down box.

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718949273811-f3e92114-4eea-4b65-862c-dbb8304364f9.png)

Once done, enter Ubuntu and the VMware Tools CD will appear on your desktop and click into it.

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718949359798-ba856cf3-7059-41d2-96ed-a599e55d10fc.png)

Enter and see a compressed file VMwareTools-10.3.10-12406962.tar.gz (it may be different for different VM versions); copy the file under the home directory (i.e. the directory with the home personal username)

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718949385494-91210da6-b0d4-4d43-a4b7-60b589eaf39f.png)

Press \[Ctrl+Alt+T] to bring up the Terminal Command Interface and enter the command:

```plain
forlinx@ubuntu:~$ sudo tar xvf VMwareTools-10.3.10-12406962.tar.gz
```

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718949403392-ae4f707b-f5e8-49ae-ad9a-70858568cbe2.png)

After the extraction is complete, a file named “vmware-tools-distrib" will appear.

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718949418780-e8c547ab-60de-4c4c-a5bb-9f73fff7b700.png)

Go back to the terminal and enter:

```plain
cd vmware-tools-distrib
```

Enter the directory:

Input again:

```plain
sudo ./vmware-install.pl
```

Enter the password, and then start the installation. Enter yes when asked, and enter the default installation.

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718949432279-4216de1f-7cf9-4c48-9d11-262568195cdb.png)

Once the VMware tools is complete, we can implement file copy and paste between Windows and Ubuntu.

##### <font style="color:black;">3.1.2.2</font><font style="color:black;">  </font><font style="color:black;">Virtual Machine Full Screen Display</font>

If the virtual machine is not able to be displayed in full screen, you can resolve this issue by clicking on "View" and selecting "Autofit Guest." This will adjust the display to fit the screen automatically, enabling you to have a full-screen experience in the virtual machine.

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718949460433-abac797c-fb21-47c2-90a5-951390afdaee.png)

Make most of the system settings in the location shown. A lot of the setup requirements on Ubuntu can be done here.

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718949472087-a7f61941-4de2-49c9-acc8-4e93358132b0.png)

##### <font style="color:black;">3.1.2.3</font><font style="color:black;">  </font><font style="color:black;">Virtual Machine Hibernation Settings</font>

Also, the default hibernation is 5min, if you don't want to set hibernation, just set it to Never by setting Power->Blank screen.

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718949527824-2c751878-01cd-4e46-ad0f-9af78af1ccaf.png)

#### <font style="color:black;">3.1.3</font><font style="color:black;">  </font><font style="color:black;">VM</font><font style="color:black;">Swapfile</font><font style="color:black;">Settings</font>

The memory allocated when creating the virtual machine is 8GB. If the 8GB memory is not enough during compilation, the size of the swapfile needs to be modified.

```plain
forlinx@ubuntu:~$ sudo swapoff /swapfile
forlinx@ubuntu:~$ sudo dd if=/dev/zero of=/swapfile bs=1M count=16384
forlinx@ubuntu:~$ sudo mkswap /swapfile
forlinx@ubuntu:~$ sudo swapon /swapfile
```

#### <font style="color:black;">3.1.4</font><font style="color:black;">  </font><font style="color:black;">Virtual Machines Network Settings</font>

##### <font style="color:black;">3.1.4.1</font><font style="color:black;">  </font><font style="color:black;">NAT</font><font style="color:black;">Connection Method</font>

By default, after the virtual machine is installed, the network connection method is set to NAT, which shares the host machine's IP address. 

This configuration does not need to be changed when performing tasks like installing dependencies or compiling code.

When the VMware virtual NIC is set to NAT mode in a virtual machine, the network in the Ubuntu environment can be set to dynamic IP. In this mode the virtual NAT device and the host NIC are connected to communicate for Internet access. This is the most common way for our VM to access the external network.

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718949560787-ecabd604-18e6-4ed4-8e99-14b964deb1c9.png)

##### <font style="color:black;">3.1.4.2</font><font style="color:black;">  </font><font style="color:black;">Bridge Connection</font>

When the VMware virtual NIC device is in bridge mode, the host NIC and the virtual machine NIC communicate through the virtual bridge, and the network IP and the host need to be set in the same network segment in the Ubuntu environment. If accessing an external network, you need to set the DNS to be consistent with the host NIC. If TFTP, SFTP and other servers are used, the network contact mode of the virtual machine needs to be set as the bridge mode.

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718949577128-36c6f2e1-80d0-4fa6-8fad-8e99fe54be14.png)

### <font style="color:black;">3.2</font><font style="color:black;">  </font><font style="color:black;">Toolkit Installation</font>

To install the necessary toolkit for T527N compilation, please execute the following command to install it, and make sure that the network can be used normally and you can access the external network before installation:

```plain
forlinx@ubuntu:~$ sudo apt-get update
forlinx@ubuntu:~$ sudo apt-get install openssh-server vim git fakeroot make automake \
autoconf libtool libssl-dev bc dosfstools mtools parted iproute2 kmod \
libyaml-dev device-tree-compiler python flex bison build-essential \
u-boot-tools libncurses-dev lib32stdc++6 lib32z1 libc6:i386 \
nodejs gyp ninja-build  bison flex gperf ruby 
```

### <font style="color:black;">3.3</font><font style="color:black;">  </font><font style="color:black;">Qt Creator</font><font style="color:black;">Installation</font>

Path: 02-User Information\\01-Software Information\\04-Tools\\qt-opensource-linux-x64-5.12.9.run

Copy qt-opensource-linux-x64-5.12.9.run to any directory in the current user's home directory and execute it:

```plain
forlinx@ubuntu:~$ chmod 777 qt-opensource-linux-x64-5.12.9.run
forlinx@ubuntu:~$ ./qt-opensource-linux-x64-5.12.9.run
```

The following interface will pop up. Click "Next" to enter the next step:

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718949644183-8f03f041-918e-488f-b607-c28206d44892.png)

Click "Next" to go to the next step:

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718949656133-5a89edca-94ba-4209-913a-f43bf8b6d99c.png)

In the following interface, click "Browse..." to select the installation path of Qtcreator, after the selection is complete, click "Next" to enter the next step:

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718949673168-caaa5ebb-5e95-44fc-b70f-cfae68a38a59.png)

In the following screen, click "Next" to the next step:

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718949687856-8c7d69c6-1815-4e7b-ad12-c64a75c87cbf.png)

Agree to the agreement and click "Next":

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718949701721-f1d0408a-296a-4e43-b693-d158f2c84508.png)

Click Install to install:

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718949715223-eea00453-23fc-48c2-81e2-47f755e7a935.png)

After the installation is completed, the following interface will be displayed. Uncheck the option "Launch Qt Creator" "and click" Finish "to complete the installation steps of Qt Creator:

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718949729984-de2da63e-1e6d-4d0c-bdba-c87880e5c665.png)

Go to the /home/forlinx/Qt5.12.9/Tools/QtCreator/bin/ directory of the actual qtcreator installation directory:

```plain
forlinx@ubuntu:~$ cd /home/forlinx/Qt5.12.9/Tools/QtCreator/bin/
```

Boot Qt Creator ：

```plain
forlinx@ubuntu:~/Qt5.12.9/Tools/QtCreator/bin $ sudo./qtcreator
[sudo] password for forlinx: forlinx                         //Enter the password of the forlinx user without any response
QStandardPaths: XDG_RUNTIME_DIR not set, defaulting to '/tmp/runtime-root'
QStandardPaths: XDG_RUNTIME_DIR not set, defaulting to '/tmp/runtime-root'
```

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718949849986-73e1f541-6fdf-461c-b19b-f0b884b4a91b.png)

The Qt Creator tool screen appears. Qt Creator is installed.

### <font style="color:black;">3.4</font><font style="color:black;">  </font><font style="color:black;">Qt</font> <font style="color:black;">Compilation Environment Configuration</font>

Path: User profile \\ software profile \\ 3-tools \\ host. tar. gz

There are libraries and cross-compilation tools required for compiling Qt programs in the host. tar. gz. 

The configuration steps are as follow:

1\. Unzip the compilation environment zip;

Because the qmake tool depends on local paths, this toolkit can only be placed in a fixed path: /opt/. Avoid unrecognized due to source code path change

Unzip the tool kit

```plain
forlinx@ubuntu:~$ sudo tar -xf host.tar.gz -C /opt/
```

If you cannot find the compressed package, you can also compile the source code first and copy out/t527/okt527/buildroot/buildroot/host/to the/opt/directory

2\. Qt Creator environment configuration

First open the Qt Creator software.

Go to the /home/forlinx/Qt5.12.9/Tools/QtCreator/bin/ directory of the actual qtcreator installation directory:

```plain
forlinx@ubuntu:~$ cd /home/forlinx/Qt5.12.9/Tools/QtCreator/bin/
```

Boot Qt Creator ：

```plain
forlinx@ubuntu:~/Qt5.12.9/Tools/QtCreator/bin $ sudo./qtcreator
[sudo] password for forlinx: forlinx                         //输入forlinx用户的密码，无回显
QStandardPaths: XDG_RUNTIME_DIR not set, defaulting to '/tmp/runtime-root'
QStandardPaths: XDG_RUNTIME_DIR not set, defaulting to '/tmp/runtime-root'
```

Start the Qt Creator program and click on the Tools->option:

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718949891654-e1cd171c-54a1-4fab-8ca5-7de0fc03a81b.png)

Enter the Options interface, click "Kits" on the left side, then click the "Compilers" tab in the upper center, and click "Add->GCC->C++" on the right side, as shown in the figure:

![](https://cdn.nlark.com/yuque/0/2025/png/45417194/1751868922304-59b3a76f-f68c-40ae-90f4-152bdb04cec3.png)

Find "aarch64-none-linux-gnu-g + +" under/opt/host/bin, select it, click Open, and modify the Name

Follow the same method to add GCC compiler and click "Add->GCC->C" on the right side; as shown in the figure:

![](https://cdn.nlark.com/yuque/0/2025/png/45417194/1751869022810-9cd2f4a7-2992-4917-8fcd-b229f5a1d75d.png)

Find "aarch64-none-linux-gnu-gcc" under/opt/host/bin, select it, click Open, and modify the Name

Click on the Qt Versions tab and click on "Add":

Find qmake in the directory /opt/host/bin, select it and click Open, add it and display it as below, click " Apply".

![](https://cdn.nlark.com/yuque/0/2025/png/45417194/1751869158232-7cba0a60-20d6-475f-a245-d4c27902b9d1.png)

Click the Kits tab, click Add on the right, add a new kit, modify it according to the following figure, and click "Apply".

![](https://cdn.nlark.com/yuque/0/2025/png/45417194/1751869278831-51736641-badb-40ad-925e-770572d9f90d.png)

### <font style="color:black;">3.5</font><font style="color:black;">  </font><font style="color:black;">VMware</font><font style="color:black;">Solution to Error Reporting</font>

Error 1: Unable to connect to MKS. Too many socket connection attempts; giving up.

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718950065962-b1270a23-8379-465e-8ebb-074c27535b1b.png)

Solution:

My Computer -> Right click -> Management -> Services and Applications -> Services: turn on all the services about VMware.

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718950090751-c1daea0f-13a9-4afe-b694-89126fbb76a2.png)

After the service starts successfully, restart the virtual machine; or hang the virtual machine first, and when the service starts, continue to run the hung virtual machine;

Error 2: Internal error

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718950103214-a7871f85-aa0b-41e9-a60d-1f1ad1d485b5.png)

Solution: Refer to solution 1

Error 3: Unable to install service VMware Authorization Service (VMAuthdService)

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718950118552-6d413624-2cac-4adf-870d-859727b1d73f.png)

Solution:

win+R

Enter services.msc

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718950135095-dcf3ba1f-5104-40fd-a040-cec6bed9d893.png)

Then find the service and start it up as an authorization and authentication service for starting and accessing virtual machines.

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718950195578-21d1856a-834a-4efe-8807-3d190d83ebdf.png)

WMI must start first.

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718950209258-c350c7e6-c2cb-49e6-a5b5-501d59205fd5.png)

Error 4：Failed to install the hcmon driver

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718950243863-dc11008b-5c1e-4f28-90bb-265e2b879287.png)

Solution: Delete C:\\Windows\\System32\\drivers\\hcmon.sys, then install again.

Error 5: Intel VT-x in disabled state

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718950313530-3343a477-e16a-4f01-b661-072c7cd3620f.png)

Solution:

①Enter the BIOS screen while booting (F2 or F12)

②configuration--》intel virtual technology--》--"change disabled to enabled--"save the setting, exit and reboot.

③Reopen VMware and turn on the virtual machine.

If that doesn't work, just turn the firewall off and reopen the VM. (varies by machine)

Error 6: The virtual machine appears to be in use... Acquiring Ownership (T)

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718950333783-0d094cf5-34e2-401e-b8cb-600a9a4006e0.png)

Solution:

①Shut down the virtual machine

② Enter the storage directory of the virtual machine and delete the \*.lck file, where lck represents the locked file.

③ Open the Windows Task Manager and kill the VMware process

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718950354133-3b24662e-114f-4a86-b27e-ed85982cf247.png)

④Reopen the virtual machine

Error 7: Failed to lock file

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718950365534-20b50f59-a57a-4be7-acf4-667c16512c5e.png)

Solution:

①Go to the virtual machine's storage directory

②Delete.vmem.lck，.vmdk.lck，\*.vmx.lck

③Reopen the VM, you can enter the VM normally

Error 8：The virtual machine could not be started because there was not enough memory available on the host.

Solution:

The virtual machine does not have enough memory to run the image's maximum requirements; increase the virtual machine's memory and reboot the virtual machine

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718950502280-738cd080-0319-4274-b239-59c91a70a889.png)

## 4\. Ubuntu Compilation

**Note: Please do not skip this paragraph.**

The development environment is the hardware and software platform that developers need during the development process. Development environment is not a fixed style . In the previous article, it explains in detail how to build an embedded Linux development environment. If you already know a lot about embedded development, you can build the environment according to your needs. If you encounter some problems, you can search for related information from some big Linux forums and websites to solve them. The operations mentioned in this section are performed on the development environment provided by us, which has been tested by Forlinx. If you are not very familiar with embedded development, recommend you to use the environment provided by Forlinx. 

**The development environment provided for general users is: forlinx (username), forlinx (password). **

**The superuser is: root (username), root (password).**

### <font style="color:black;">4.1</font><font style="color:black;">  </font><font style="color:black;">Preparation Before Startup</font>

#### <font style="color:black;">4.1.1</font><font style="color:black;">  </font><font style="color:black;">Versions</font>

Virtual Machine Software: Vmware 15.1.0

Recommended Development Environment OS: Ubuntu 20.04 64-bit

Cross toolchain: gcc-arm-10.3-2021.07-x86 \_ 64-aarch64-none-linux-gnu (kernel)

```plain
aarch64-buildroot-linux-gnu_sdk-buildroot（应用）
```

Bootloader version: u-boot-2018.07

Kernel version: linux-5.15.147

Development board QT version: qt5.15.8

#### <font style="color:black;">4.1.2</font><font style="color:black;">  </font><font style="color:black;">Source Code </font><font style="color:black;">Copy and Release</font>

Kernel source code path: user data \\ software data \\ 2-image and source code \\ 1-source code \\ OKT527-linux-sdk 1.3.tar.bz2.

1\. Copy Source Code

OKT527-linux-sdk1.3.tar.bz2 includes the toolchain, user SDK, Linux kernel, file system, source code for test programs, and some tools.

```plain
forlinx@ubuntu:~$ mkdir /home/forlinx/work                                            //Create working path
```

Copy the source package to the virtual machine /home/forlinx/work directory.

You can directly drag and drop the source package from your computer to a folder on the desktop of the virtual machine, or use a shared folder to copy it using the command; here we focus on the use of shared folders

There are many kinds of file transfers between ubuntu and Windows hosts. After installing VMware Tools, you can set up a virtual machine shared folder to mount the file directory of the Windows host to ubuntu for file sharing.

Click "Virtual Machine" on the menu bar and select "Settings".

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718950783159-aa38c988-c012-4406-8082-6a9a28411890.png)

Click "Options", enable "Shared Folders", set the shared directory on the Windows host, and click "OK".

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718950804162-7efbad0f-793c-4665-ba22-9b194e4fd765.png)

After completing the virtual machine's file sharing setup, place the source code package OKT527-linux-sdk1.3.tar.bz2 into the Windows host's shared folder. Here, we'll name it "share".

The shared folder is in the mount directory /mnt/hgfs/share in ubuntu; view the files in the mount directory.

```plain
forlinx@ubuntu:~$ ls /mnt/hgfs/share/                                //View files in the shared directory
OKT527-linux-sdk1.3.tar.bz2
```

Copy the source code from the shared folder to ubuntu's /home/forlinx/work directory for md5 checksum:

```plain
forlinx@ubuntu:~$ cp /mnt/hgfs/share/OKT527-linux-sdk1.3.tar.bz2.* /home/forlinx/work/       
forlinx@ubuntu:~$ cd /home/forlinx/work
forlinx@ubuntu:~/work$ md5sum OKT527-linux-sdk1.3.tar.bz2.*
```

The returned md5 checksum is the same as the one in the profile, so you can unzip the source code:

```plain
forlinx@ubuntu:~/work$ cat OKT527-linux-sdk1.3.tar.bz2.0* | tar jxv
```

#### <font style="color:black;">4.1.3</font><font style="color:black;">  </font><font style="color:black;">Common File Path of Source Code</font>

OK527-C platform, the software configuration file path (starting under the SDK source code OKT527-linux-sdk path) is as follows:

| Document type| path|
|----------|----------|
| Kernel configuration file| device/config/chips/t527/configs/okt527/linux-5.15/bsp\_defconfig|
| Device tree file| kernel/linux-5.15/bsp/configs/linux-5.15/sun55iw3p1.dtsi|
| | kernel/linux-5.15/arch/arm64/boot/dts/allwinner/OKT527-C-Common.dtsi|
| | kernel/linux-5.15/arch/arm64/boot/dts/allwinner/OKT527-C-Linux.dts|
| sysconfig.fex| device/config/chips/t527/configs/okt527/sys\_config.fex|
| File system source files.| File add path<br/>buildroot/buildroot-202205/board/forlinx/okt527/fs-overlay/<br/>Final packaging path<br/>out/t527/okt527/buildroot/buildroot/target|
| uboot environment variable settings file| Device/config/chips/t527/configs/okt527/buildroot/env.cfg                                                                                                          You can modify this file if you need to modify or add default environment variables. |

OK527-C platform, the test program path (SDK source code starts under OKT527-linux-sdk path) is as follows:

platform/framework/auto/cmd\_demo Command Line Test Program Source Directory

platform/framework/auto/qt\_demo Qt test program source directory

| | | Source code path
|----------|----------|----------
| qt-demo| 4G| platform/forlinx/forlinx\_qt\_demo/4g
| | ADC| platform/forlinx/forlinx\_qt\_demo/adc
| | Backlight| platform/forlinx/forlinx\_qt\_demo/backlight
| | SQL| platform/forlinx/forlinx\_qt\_demo/books
| | Browser| platform/forlinx/forlinx\_qt\_demo/browser
| | Camera test| platform/forlinx/forlinx\_qt\_demo/camera
| | Sound recording| platform/forlinx/forlinx\_qt\_demo/fltest\_qt\_audiorecorder
| | Video play| platform/forlinx/forlinx\_qt\_demo/fltest\_qt\_musicplayer
| | Key test| platform/forlinx/forlinx\_qt\_demo/keypad
| | Desktop| platform/forlinx/forlinx\_qt\_demo/matrix-browser
| | Network Configuration| platform/forlinx/forlinx\_qt\_demo/network
| | ping| platform/forlinx/forlinx\_qt\_demo/ping\_test
| | | platform/forlinx/forlinx\_qt\_demo/qopenglwidget
| | rtc| platform/forlinx/forlinx\_qt\_demo/rtc
| | Spi| platform/forlinx/forlinx\_qt\_demo/spitest
| | Serial test| platform/forlinx/forlinx\_qt\_demo/terminal
| | Watchdog| platform/forlinx/forlinx\_qt\_demo/watchdog
| | WiFi| platform/forlinx/forlinx\_qt\_demo/wifi
| cmd-demo| Video Hardware Decoding| platform/forlinx/forlinx\_cmd\_demo/decoderTest
| | Video Hardware Encoding| platform/forlinx/forlinx\_cmd\_demo/encoder\_test
| | Clear screen| platform/forlinx/forlinx\_cmd\_demo/fbinit\_test
| | GPADC| platform/forlinx/forlinx\_cmd\_demo/fltest\_adc
| | Backlight| platform/forlinx/forlinx\_cmd\_demo/fltest\_backlight
| | Key test| platform/forlinx/forlinx\_cmd\_demo/fltest\_keytest
| | SPI Test| platform/forlinx/forlinx\_cmd\_demo/fltest\_spidev\_test
| | UART| platform/forlinx/forlinx\_cmd\_demo/fltest\_uarttest
| | USB camera| platform/forlinx/forlinx\_cmd\_demo/fltest\_usbcam
| | Watchdog| platform/forlinx/forlinx\_cmd\_demo/fltest\_watchdog
| | ec20 4G| platform/forlinx/forlinx\_cmd\_demo/quectelCM
| | wifi| platform/forlinx/overlay\_rootfs/usr/bin/fltest\_wifi.sh
| | Wifi-ap| platform/forlinx/overlay\_rootfs/usr/bin/fltest\_hostap.sh
| | gpio| platform/forlinx/overlay\_rootfs/usr/bin/fltest\_gpio.sh
| | Desktop| platform/forlinx/overlay\_rootfs/etc/init.d/S60Matrix\_Browser

### <font style="color:black;">4.2</font><font style="color:black;">  </font><font style="color:black;">Source Code Compilation</font>

#### <font style="color:black;">4.2.1</font><font style="color:black;">  </font><font style="color:black;">Full Compilation</font>

Full compilation refers to the unified compilation of source code, including kernel source code, library files, applications, file system packaging, and so on.

First select the configuration:

```plain
forlinx@ubuntu:~$ cd /home/forlinx/work/OKT527-linux-sdk                    //Enter source code path
forlinx@ubuntu:~/work/OKT527-linux-sdk$ ./build.sh config                    //Execute configure commands
```

```plain
forlinx@ubuntu:~/work/OKT527-linux-sdk$ ./build.sh config
========ACTION List: mk_config ;========
options : 
All available board:
   0. okt527
Choice [okt527]: 
Setup BSP files
.

…

```

Run the compilation script for full compilation:

```plain
forlinx@ubuntu:~/work/OKT527-linux-sdk$ ./build.sh
```

**Note: If compilation of qt\_webengine stalls or results in errors, please switch to a more powerful host machine to run the virtual machine environment.**

**or:**

**Delete OKT527-linux-sdk1.3/out/t527/okt527/buildroot/buildroot/build/qt5webengine-5.15.8/ directory**

**And switch to OKT527-linux-sdk1.3/buildroot/buildroot-202205/package/qt5/qt5webengine directory**

**Modify the qt5web engine. mk films**

    **QT5WEBENGINE_ENV += NINJAFLAGS="-j32"**

**modify to**

    **QT5WEBENGINE_ENV += NINJAFLAGS="-j8"**

![](https://cdn.nlark.com/yuque/0/2025/png/50461850/1745800715577-0679cdb4-a7ef-4503-bc58-f08daf758a84.png)

**Continue to execute the build. sh to compile.**

After the source code is compiled you need to generate an image to package the various files and configuration files generated by the compilation.

Execute the pack command to generate the image file:

```plain
forlinx@ubuntu:~/work/OKT527-linux-sdk$ ./build.sh pack

…

Dragon execute image.cfg SUCCESS !
----------image is at----------

655M    ~/work/OKT527-linux-sdk/out/t527_linux_okt527_uart0.img

pack finish
```

#### <font style="color:black;">4.2.2</font><font style="color:black;">  </font><font style="color:black;">Individual Kernel </font><font style="color:black;">Device Tree Compilation</font>

Compile the kernel alone only for the kernel source code to compile, affecting the driver, applicable to only modify the kernel to compile.

After selecting the configuration according to the previous method:

```plain
forlinx@ubuntu:~$ cd /home/forlinx/work/OKT527-linux-sdk
forlinx@ubuntu:~/work/OKT527-linux-sdk$ ./build.sh kernel                    //Execute compile kernel command

…

Copy modules to target ...
15985 blocks
28830 blocks
bootimg_build
Copy boot.img to output directory ...

sun55iw3p1 compile all(Kernel+modules+boot.img) successful

…

forlinx@ubuntu:~/work/OKT527-linux-sdk$ ./build.sh pack
```

#### <font style="color:black;">4.2.3</font><font style="color:black;">  </font><font style="color:black;">**Individual Test Program Compilation**</font>

When modifying the test program separately, you can compile only the test program to reduce the amount of compilation.

```plain
forlinx@ubuntu:~$ cd /home/forlinx/work/OKT527-linux-sdk
forlinx@ubuntu:~/work/OKT527-linux-sdk$ source .buildconfig              //Configuration before compilation
forlinx@ubuntu:~/work/OKT527-linux-sdk$ ./platform/forlinx/build.sh
```

#### <font style="color:black;">4.2.4  **Individual U-Boot Compilation**</font>

Compile uboot separately using the following command.

```plain
forlinx@ubuntu:~/work/OKT527-linux-sdk$ ./build.sh brandy
forlinx@ubuntu:~/work/OKT527-linux-sdk$ ./build.sh pack
```

Note: The content of uboot is not open source, and it will report an error when compiled separately. Just ignore it.

#### <font style="color:black;">4.2.5 **Individual Filesystem Compilation**</font>

During the full compilation process, the file system will not be compiled and needs to be modified and compiled separately. Enter the file system directory to compile and configure modifications.

The compilation instructions are as follows, using the compile script in the buildroot-202205.

```bash
forlinx@ubuntu:~/work/OKT527-linux-sdk/buildroot/buildroot-202205$ ./build.sh
```

If you want to modify the configuration, you can do so as follows. Use the above instructions to compile after the modification is completed.

```bash
forlinx@ubuntu:~/work/OKT527-linux-sdk/buildroot/buildroot-202205$ make OKT527-C-Linux_defconfig ARCH=arm64					//Read the current configuration
forlinx@ubuntu:~/work/OKT527-linux-sdk/buildroot/buildroot-202205$ make menuconfig	//Enter the graphic configuration interface to modify the configuration
forlinx@ubuntu:~/work/OKT527-linux-sdk/buildroot/buildroot-202205$ cp ../../out/t527/okt527/buildroot/buildroot/.config configs/OKT527-C-Linux_defconfig		//Save the modified content as the default configuration
```

#### <font style="color:black;">4.2.6 OKT527-linux-sdk Clearance</font>

This operation clears all intermediate files. However, it does not affect the source files, including those that have already had changes made to them.

```plain
forlinx@ubuntu:~$ cd /home/forlinx/work/OKT527-linux-sdk
forlinx@ubuntu:~/work/OKT527-linux-sdk$ ./build.sh clean                            //Execute the clear command
```

#### <font style="color:black;">4.2.7 Boot Logo Replacement</font>

Replace device/config/chips/t527/boot-resource/boot-resource/bootlogo.bmp

The image is in bmp format, 720x480 resolution, with the file name "bootlogo.bmp".

Repackage the image

```plain
forlinx@ubuntu:~/work/OKT527-linux-sdk$ ./build.sh pack
```

#### <font style="color:black;">4.2.8  Individual Development Board Firmware Update</font>

After compiling the image, uboot, device tree, and kernel can be updated separately, and uboot, device tree file boot \_ package. fex, and kernel file boot. fex can be copied from the out/pack \_ out/.

Here, a USB drive is used for testing, with files placed on the USB drive and mounted to/run/media/sda1/. You can also transfer files to the development board through the network port

Uboot and device tree updates

```plain
dd if=/run/media/sda1/boot_package.fex of=/dev/mmcblk0 seek=32800
dd if=/run/media/sda1/boot_package.fex of=/dev/mmcblk0 seek=24576
```

Kernel update

```plain
dd if=/run/media/sda1/boot.fex of=/dev/mmcblk0p3 conv=fsync
```

The entire file system update is not supported for the time being. If necessary, the required files can be transferred by U disk or SSH.

### <font style="color:black;">4.3</font><font style="color:black;">  </font><font style="color:black;">Qt </font><font style="color:black;">Configuration and Use</font>

The OKT527-linux-sdk1.3.tar.bz2 provided by Forlinx offers a complete development dependency environment for Qt 5.15.8. The development environment has already installed Qt Creator 5.12.9. Please set up the Qt Creator 5.15.8 environment on your own by following the methods described previously.

#### <font style="color:black;">4.3.1</font><font style="color:black;">  </font><font style="color:black;">OKT527-linux-sdk</font> Installation

Please refer to Chapter 3 for SDK installation and full compilation.

#### <font style="color:black;">4.3.2</font><font style="color:black;">  </font><font style="color:black;">Qt Creator </font><font style="color:black;">Environment </font><font style="color:black;">Configuration</font>

Please refer to Chapter 3. for installation and configuration.

#### <font style="color:black;">4.3.3</font><font style="color:black;">  </font><font style="color:black;">Qt Creator </font><font style="color:black;">Development Examples</font>

Open the Qt Creator software.

```plain
forlinx@ubuntu:~$ cd /home/forlinx/Qt5.12.9/Tools/QtCreator/bin/
forlinx@ubuntu:~/qtcreator-4.7.0/bin$ sudo ./qtcreator
```

Start the Qt Creator program, enter the Qt Creator interface, click "File" -> "New File or Project" to create a new project, select " Application (Qt)" -> "Qt Widgets Application", then click "Choose" in the right corner. Application (Qt)"->"Qt Widgets Application", then click "Choose" in the lower right corner:

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718950862335-48648f4d-29e4-48b2-8bec-96a15102c9ca.png)

In the following interface, change the name of the new project to "helloworld", select the installation path /home/forlinx, and then click "Next":

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718950877270-ef232c40-5d0d-40bf-8e2e-4d37f996f4d0.png)

Select qmake and click "Next" to continue.

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718950886144-54b37456-de62-48c7-b7cc-b2df962488b2.png)

In the following interface, you can modify the Class name and Base class as required. The default is used here, and then click "Next":

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718950897755-f70676a4-65e7-4835-9c32-b977524dc66d.png)

Translation files can be selected, and languages can be selected if there is a need for multi-language support. Use the default here and click "Next":

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718950910018-0542302c-e7a7-4851-884b-53bd0b717a00.png)

In the following screen, select "OK527" as the kit of the current project, and then click "Next":

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718950921104-6b1d4af7-5ea5-4eaa-95c6-9402a26bca74.png)

In the following interface, click "Finish" to complete the new project:

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718950932773-3bf58552-1a8c-4ee2-a872-fc9ea2d124ae.png)

When the creation of the new project is complete, the following window can be displayed:

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718950947708-0c81ca78-c489-44cd-aff2-714c433cbc67.png)

When the program is written, click the hammer icon in the lower left corner to cross-compile and copy the compiled executable program to the development board to test the application.

#### <font style="color:black;">4.3.4 </font><font style="color:black;"> </font><font style="color:black;">Qt Creator </font><font style="color:black;">FQA</font>

Open the Qt Creator integrated development environment from the command line or through a shortcut. Once launched, you will see a interface similar to the one below:

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718950971164-9e266495-0250-4eb7-8f3b-dfb8feadda73.png)

The "Design" button, "Project" button, and the "Build and Debug" area on the left side will only become available after opening or creating a project.

There are the positioning tools and output panes underneath the QtCreator, which are used when writing project code , running and debugging programs. There are seven output panes: Issues (problems with the project build), Search Results (searches for the contents of the project file), Application Output (display of runtime and debugging information), Compile Output (compilation and linking commands and their output information), QML/JS Console (the QML command window), Summary Information (a summary of the project's information), and Version Control (a system of control of the version.)

1. Click the hammer button in the lower left corner and find that there is no compilation information. The solution is as follows:

By default, the selected output pane is 1 (Issues) for viewing. If you need to check the compilation information, you will need to select 4 (Compile Output) in the output pane location.

Build Debugging

![](https://cdn.nlark.com/yuque/0/2024/png/45383109/1718950991143-dd0cec48-825b-49c9-a6a3-fe7388b5959b.png)

2\. The solution to the issue of the gray debug/run button in Qt Creator is as follows:

This problem occurs because there is a problem configuring the C, C++ and Qt versions in the kits suite, maybe there is a problem with the paths, maybe you haven't done a full compilation, just change the editor language.

![](https://cdn.nlark.com/yuque/0/2025/png/45417194/1751872642898-3fc9d076-0e87-4113-950a-b8ae7c7b52d3.png)

Please check if the cross-compiler path configuration in the checkbox is correct.

For the specific configuration method, refer to the chapter "[**3.4 Configuration of Qt Compilation Environment**](https://forlinx-book.yuque.com/pxh4d1/xrit1g/4065557d050f94a9c309bdd354805839#KyF8n)".

