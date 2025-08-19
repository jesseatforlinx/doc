# 0 Linux5.10.209+ Qt5.15.10_用户使用手册

# 免责声明
本手册版权归保定飞凌嵌入式技术有限公司所有。未经本公司的书面许可，任何单位和个人无权以任何形式复制、传播、转载本手册的任何部分，违者将被追究法律责任。

保定飞凌嵌入式有限公司所提供的所有服务内容旨在协助用户加速产品的研发进度，在服务过程中所提供的任何程序、文档、测试结果、方案、支持等资料和信息，都仅供参考，用户有权不使用或自行参考修改，本公司不提供任何的完整性、可靠性等保证，若在用户使用过程中因任何原因造成的特别的、偶然的或间接的损失，本公司不承担任何责任。 

# 概述
<font style="color:#333333;">本手册以使用户快速熟悉产品，了解接口功能和测试方法为目的，主要讲述了开发板接口功能的测试，烧写镜像方法，以及使用过程中出现的一些问题如何排查。在测试过程中，对一些命令进行了注释，方便</font>用户理解，以实用够用为主。涉及到内核编译、相关应用编译方法，开发环境搭建等请参考飞凌提供的《OK3588-C Linux用户编译手册》

本手册一共分为6部分：

+ 第一部分产品的整体概述，简单介绍了开发板在接口资源、内核源码中相关驱动路径、开发板支持的烧写和启动方式，以及资料中重点部分的说明；
+ 第二部分产品的快速开机启动，可采用串口登录和网络登录两种方式；
+ 第三部分产品的桌面功能及QT界面功能测试；
+ 第四部分产品的命令行操作进行功能测试；
+ 第五部分产品的多媒体测试，包括了摄像头的播放测试以及视频硬件编解码测试；
+ 第六部分产品的镜像更新，主要描述更新镜像到存储设备的方法，用户可根据实际情况选择对应的烧录方式。

本手册中一些符号及格式的相关说明：

| **表现形式** | **含义** |
| :---: | --- |
| ⁉️ | 注意或者是需要特别关注的信息，一定要仔细阅读 |
| 📚 | 对测试章节做的相关说明 |
| 🛤️ | 表示相关路径 |
| <font style="color:blue;">蓝色字体</font> | 指在命令行输入的命令，需要手动输入 |
| <font style="color:black;">黑色字体</font> | 输入命令后的串口输出信息 |
| **<font style="color:black;">黑色加粗</font>** | 串口输出信息中的关键信息 |
| // | 对输入指令或输出信息的解释内容 |
| 用户名@主机名 | forlinx@ubuntu：开发环境ubuntu账户信息   用户可通过该信息确定功能操作的环境 |


例：打包文件系统后，使用ls查看生成文件的操作

```plain
forlinx@ubuntu:~/3588$ ls                                  //列出该目录下的文件
OK3588-linux-source  OK3588-linux-source.tar.bz2
```

+ forlinx@ubuntu：用户名为forlinx，主机名为ubuntu，表示在开发环境ubuntu中进行操作。
+ // ：对操作指令的解释说明内容，不需要输入
+ <font style="color:blue;">ls</font>：蓝色字体，表示需要手动输入的相关命令
+ **<font style="color:black;">OK3588-linux-source</font>**：黑色字体为输入命令后的输出信息，加粗字体为关键信息，此处为打包后的文件系统。

# 适用范围
本文主要适用于飞凌OK3588-C平台Linux5.10.209操作系统，其他平台也可以参考，但是不同平台之间会存在差异，需客户自行修改以适应自己的使用。

# 更新记录
| **日期** | **手册版本** | **核心板版本** | **底板版本** | **更新内容** |
| :---: | :---: | :---: | :---: | --- |
| 20241125 | V1.0 | V1.1 | V1.3及其以上版本 | OK3588-C Linux5.10.209软件手册初版 |




# 01_OK3588开发板介绍

## 1.1 OK3588开发板简介
RK3588是基于ARM64架构的低功耗高性能处理器，它包括4核Cortex-A55和4核Conrtex-A76以及独立的NEON协处理器和神经网络加上处理器NPU，可应用于计算机、手机、个人移动互联网，数字多媒体设备。

飞凌OK3588-C开发平台核心板和底板采用接插件的连接方式，主要接口如下图所示：

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954716859-19d55d72-2378-422a-918f-831427f4bb79.png)

**正面视图**

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954717240-37bbcad9-dae7-4ca7-b8fa-6ae064d91400.png)

**反面视图**

📚 **请阅读：**

本软件手册中不再对硬件参数进行叙述，在参考本手册进行软件开发前请阅读“硬件资料\用户手册”路径下的“OK3588-C _硬件手册”，以了解产品命名规则和您所使用产品的硬件配置信息，这样有助于您对本产品的使用。

## 1.2 CPU/GPU/NPU频率说明
**RK3588J工业级核心板频率说明如下：**

+ **<font style="color:#ff0000;">注意：对于工业级RK3588J核心板，为了客户能更好的测试该SOC的最大性能，R4及其之后的版本用户资料中默认将工作在超频模式下（如无性能要求，建议客户修改为常规模式）。</font>**

依据《Rockchip RK3588J Datasheet V1.1-20230803.pdf》 手册

Table 3-2 Recommended operating conditions

| 最大CPU A76频率, 常规模式① | 1.6 GHz |
| --- | --- |
| 最大CPU A76频率, 超频模式② | 2.0 GHz |
| 最大CPU A55频率, 常规模式① | 1.3 GHz |
| 最大CPU A55频率, 超频模式② | 1.7 GHz |
| 最大GPU频率, 常规模式① | 700 MHz |
| 最大GPU频率, 超频模式② | 850 MHz |
| 最大NPU频率, 常规模式① | 800 MHz |
| 最大NPU频率, 超频模式② | 950 MHz |


1. 常规模式表示芯片在安全电压和频率下工作。对于工业环境，强烈建议保持在正常模式下，以合理保证寿命。

② 超频模式会带来更高的频率，相应的电压也会增加。在超频模式下长时间运行，芯片的寿命可能会缩短，尤其是在高温条件下。



切换成“常规模式”，需要在内核设备树中引用中添加#include "rk3588j.dtsi"即可，路径为：OK3588_Linux_fs/kernel/arch/arm64/boot/dts/rockchip/OK3588-C-common.dtsi

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954717604-ba8c8389-6605-43fe-8331-d12b42f92b2a.png)

**RK3588商业级核心板频率说明如下：**

依据《Rockchip RK3588 Datasheet V1.7-20231117.pdf》 手册

Table 3-2 Recommended operating conditions

| 最大CPU A76频率 | 2.2-2.4 GHz |
| --- | --- |
| 最大CPU A55频率 | 1.8 GHz |
| 最大GPU频率 | 1 GHz |
| 最大NPU频率 | 1 GHz |


## 1.3 Linux 5.10.209系统软件资源介绍
| **设备** | **驱动程序源代码在内核中的位置** | **设备名** |
| --- | --- | --- |
| LCD 背光驱动 | drivers/video/backlight/pwm_bl.c | /sys/class/backlight |
| USB接口U盘 | drivers/usb/storage/ |  |
| USB鼠标 | drivers/hid/usbhid/ | /dev/input/mice |
| 以太网 | drivers/net/ethernet/stmicro/stmmac |  |
| SD/micro TF卡驱动 | drivers/mmc/host/dw_mmc-rockchip.c | /dev/mmcblk1pX |
| EMMC驱动 | drivers/mmc/host/dw_mmc-rockchip.c | /dev/mmcblk0pX |
| OV13855 | drivers/media/i2c/ov13855.c | /dev/videoX |
| LCD 控制器 | drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  |
| MIPI CSI | drivers/phy/rockchip/phy-rockchip-mipi-rx.c |  |
| MIPI DSI | drivers/phy/rockchip/phy-rockchip-inno-mipi-dphy.c |  |
| LCD触摸驱动 | drivers/input/touchscreen/goodix.c   drivers/input/touchscreen/edt-ft5x06.c | /dev/input/eventX |
| RTC实时时钟驱动 | drivers/rtc/rtc-rx8010.c   drivers/rtc/rtc-pcf8563.c | /dev/rtc0 |
| 串口 | drivers/tty/serial/8250/8250_dw.c | /dev/ttySX |
| 按键驱动 | drivers/input/keyboard/adc-keys.c | /dev/input/eventX |
| LED | drivers/leds/leds-gpio.c |  |
| I2S | sound/soc/rockchip/rockchip_i2s.c |  |
| 音频驱动 | sound/soc/codecs/nau8822.c | /dev/snd/ |
| PMIC | drivers/mfd/rk806.c   drivers/regulator/rk860x-regulator.c |  |
| PCIE | drivers/pci/controller/pcie-rockchip.c |  |
| 看门狗 | drivers/watchdog/dw_wdt.c |  |
| SPI | drivers/spi/spi-rockchip.c |  |
| PWM | drivers/video/backlight/pwm_bl.c |  |


## 1.4 eMMC存储器分区表
下面表格是Linux操作系统的eMMC存储器分区信息（计算时一个块大小为512bit）：

| **分区索引** | **名称** | **偏移/block** | **大小/block** | **内容** |
| --- | --- | --- | --- | --- |
| N/A | security | 0x00000000 | 0x00004000 | MiniLoaderAll.bin |
| 1 | uboot | 0x00004000 | 0x00004000 | uboot.img |
| 2 | misc | 0x00006000 | 0x00002000 | misc.img |
| 3 | boot | 0x00008000 | 0x00020000 | boot.img |
| 4 | recovery | 0x00028000 | 0x00050000 | recovery.img |
| 5 | oem | 0x01c78000 | 0x00040000 | oem.img |
| 6 | rootfs | 0x00078000 | 0x01c00000 | rootfs.img |
| 7 | userdata | 0x01cb8000 |  | userdata.img |




# 02_快速开机启动

## 2.1 开机前的准备
OK3588开发板有串口登录和网络登录两种系统登录方式，系统开机前硬件准备：

+ 12V3A DC电源线
+ 调试串口线（串口登录使用）

开发板上的调试串口为Type-C USB插孔，用户可以使用USB转Type-C线连接开发板和PC机，以便查看开发板状态。

+ 网线（网络登录使用）
+ 屏幕，根据开发板接口连接屏幕（不需要显示的可以不接）



![](https://cdn.nlark.com/yuque/0/2025/png/45535139/1735881117957-0d439ed2-55f1-4bca-a4dc-d022c67a04a9.png)

## 2.2 调试串口驱动安装
OK3588-C平台调试串口使用的是Type-C接口，板载USB转UART芯片，无需客户购买USB转串口调试工具，使用极其简单方便。

安装驱动请使用用户资料\Linux\工具\目录下提供的驱动包CP210x_VCP_Windows_XP_Vista.zip进行装。

解压完成后直接运行CP210xVCPInstaller_x64.exe，为确保安装最新的驱动，请先点击驱动卸载，再驱动安装。

## 2.3 串口登录方式
### 2.3.1 串口连接设置
📚**说明：**

+ **串口设置：波特率115200、数据位8、停止位1、无校验位、无流控制**
+ **串口终端登录为forlinx用户，密码forlinx **
+ **软件需求：PC端Windows系统需要安装超级终端软件，超级终端软件有多种，可自行使用自己熟悉的串口终端软件**

以下我们以putty终端软件为例介绍串口的登录方式：

**步骤1：**首先需要确认连接电脑的串口端口号，从设备管理器中查看串口端口号，以电脑实际识别的端口号为准。

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954727852-9c9b1c4a-e1c9-4599-b47f-7248258645a1.png)

**步骤2：**打开putty并设置，serial line根据使用的电脑COM口设置，波特率115200

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954728047-b3584dd0-c73c-41c5-9d2f-88f10230261c.png)

**步骤3：**上述设置完成后可以在Saved Sessions输入电脑使用的COM口，下图以COM24为例，将设置保存，之后再打开串口时，直接点击保存的端口号即可。

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954728245-98417d68-58ab-4ee7-a137-04e15add214c.png)

**步骤4：**打开开发板的电源开关，串口会有打印信息输出，免登录。

```plain
libpng warning: iCCP: known incorrect sRGB profile

root@ok3588-buildroot:/#
```



### 2.3.2 串口登录常见问题
电脑端口没有串口的可以通过USB转串口线与开发板连接，使用USB转串口线接需要安装对应的驱动程序。

建议使用质量好串口线以避免出现乱码情况。

## 2.4 网络登录方式
### 2.4.1 网络连接测试
📚 **说明：**

+ **出厂时网卡默认配置为静态IP，IP地址为192.168.0.232，更改静态IP的方法可参考“**[**以太网配置**](https://forlinx-book.yuque.com/rh74yu/ok3588/twqpscxwm5yv98kl#9ImlC)**”测试章节**
+ **测试时电脑和开发板需要在同一网段**

在进行网络登录前，需要先确保电脑和开发板直连的网络连接正常，可通过ping指令测试电脑和开发板的连接状态。具体方法操作如下：

1、将开发板的eth0和电脑通过网线连接，给开发板上电，内核启动后核心板上会有蓝色心跳灯闪烁，与电脑连接的网卡在正常启动后网卡灯快速闪烁，此时可以测试网络连接。

2、**关闭电脑防火墙（此处不作关闭防火墙的介绍，电脑通用操作）**，打开电脑的运行命令

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954728414-9f9a202c-0ba7-47f1-a14e-b10aa678fa01.png)

3、使用cmd打开电脑管理员界面，使用ping指令测试电脑和开发板的网络连接状态

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954728585-22cc0ffd-0558-45ae-90c2-d581345a261a.png)

有数据返回，网络连接正常。

### 2.4.2 SSH服务器
📚 **说明：**

+ **出厂时网卡默认配置为静态IP，IP地址为192.168.0.232，更改静态IP的方法可参考“以太网配置”测试章节**
+ **登录为forlinx用户，密码forlinx**
+ **如果想要使用root用户登录，则需要更改root登录的密码之后，才可以使用ssh登录和scp进行文件传输。**

1、使用ssh登录开发板

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1721610891693-b0ef8b04-31c0-4a9c-a227-afa062aa4ac8.png)

点击“Open”,出现如下对话框，点击“是”进入登录界面

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954728936-f3f3edb5-5891-4323-b079-34f7601d46b9.png)



```plain
Login as：forlinx
root@192.168.0.232's password:          //按照提示输入开发板forlinx账户的密码forlinx
root@ok3588-buildroot:~#
```



### 2.4.3 SFTP
🛤️ 路径：OK3588-C（Linux）用户资料\工具\FileZilla*

OK3588开发板支持 SFTP 服务并启动时已自动开启，设置好 IP 地址后就可以作为一台 SFTP 服务器。下面介绍如何利用FTP工具进行文件传输。

在 windows上安装好filezilla工具，并按照下图所示步骤进行设置,用户名和密码均为forlinx。

打开filezilla工具，点击文件，选择站点管理器（site Manager)。

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954729099-282246fe-f588-46d3-b4ea-4c670fb661bc.png)

```plain
    登录成功后便可以进行上传下载操作。
```

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954729427-adb43e9d-3117-426a-a8ef-84eac179aad8.png)

## 2.5 屏幕切换
OK3588支持MIPI DSI、HDMI、eDP、DP、RGB等多种屏幕接口，同时可以进行四个屏幕的同显和异显。目前屏幕切换控制方式有三种：uboot菜单动态控制；内核设备树指定；DisplayHwConfig应用程序控制。

OK3588中包含4个显示控制器，即4个VP。最多支持4个屏幕同时显示。其中VP0最大分辨率为7680x4320；VP1最大分辨率为4096x4320；VP2最大分辨率为4096x4320；VP3最大分辨率为2048x1080。

### 2.5.1 uboot菜单动态控制
**2.5.1.1显示类型设置**

该方式在现有已支持屏幕的基础上不需要重新编译和烧写，即可切换屏幕。

在uboot自启动过程中串口终端按下space空格按键，即可弹出控制选项：

```plain
Hit key to stop autoboot('Spacebar'):  0
---------------------------------------------
0:Exit to console
1:Reboot
2:Display type
---------------------------------------------
```



终端输入2，进入屏幕控制子菜单：

```plain
---------------------------------------------
hdmi0 and edp0 share same port, only one can be used.
hdmi1 and edp1 share same port, only one can be used.
only four VPs internally, so up to four interfaces can be activated
hdmi edp dp can only be displayed on VP0 or VP1 or VP2.
dsi0 dsi1 can only be displayed on VP2 or  VP3.
rgb can only be displayed on VP3.

Select  display
  0:Exit
  1: hdmi0 => VP0
  2: hdmi1 =>
  3: edp0  =>
  4: edp1  =>
  5: dp0   =>
  6: dp1   =>
  7: mipi0 =>
  8: mipi1 =>
  9: rgb   =>
  a: primary display  => HDMI0
  b: primary display resolution => 1920x1080p50
  c: display type => sync
---------------------------------------------
```

⁉️ **注意：最好不要把HDMI设置成主屏，系统启动完成热插拔HDMI造成QT应用程序退出。**

根据uboot菜单中注释的内容，我们可以知道uboot显示菜单设置规则：

1. hdmi0和edp0使用相同的端口，二者只能同时使用其中的一个。
2. Hdmi1和edp1使用相同的端口，二者只能同时使用其中的一个。
3. 内部只有四个VP，所以最多可以激活四个接口。
4. hdmi、edp、dp只能在VP0或VP1或VP2上显示。
5. dsi0、dsi1只能在VP2或是VP3上显示。

6、rgb只能在VP3上显示。

在设置显示时，输入显示接口对应的序号，将会为对应的接口分配VP。若再次输入，会依次切换该端口可以使用的VP，或是关闭为端口分配的VP。

### 2.5.2内核设备树指定
该方式不需要连接串口终端，系统镜像默认为所期望的配置选择，适合量产。但需要手工修改设备树，重新生成一次系统镜像。

⁉️ **注意：该方式优先级高于uboot屏幕选择，在设备树修改后，uboot的选择不会生效。**

设备树路径为：kernel/arch/arm64/boot/dts/rockchip/OK3588-C-common.dtsi 

内核源码中，打开设备dtsi文件，找到如下节点：

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954729754-1cd542f1-5686-472b-a7bc-954bb05e7fa0.png)

该节点默认disabled状态，需要改为okay使能节点。根据屏幕需求更改。

**参数说明：**

| **参数** | **含义** |
| --- | --- |
| status | 描述节点状态：disabled为关闭节点，okay使能节点 |
| HDMI0 | 指定为HDMI0分配的VP |
| HDMI1 | 指定为HDMI1分配的VP |
| EDP0 | 指定为EDP0分配的VP |
| EDP1 | 指定为EDP1分配的VP |
| DP0 | 指定为DP0分配的VP |
| DP1 | 指定为DP1分配的VP |
| MIPI0 | 指定为MIPI0分配的VP |
| MIPI1 | 指定为MIPI1分配的VP |
| RGB | 指定为RGB分配的VP |
| primary_display | 指定主屏显示 |
| primary_display_resolution | 指定HDMI为主屏所使用分辨率 |
| disp_type | 注意指定同异显，默认同显。 |


用户根据需要更改设置参数，保存后，需要重新编译生成镜像。

节点的注释描述：

1、hdmi0和edp0使用相同的端口，二者只能同时使用其中的一个。

2、Hdmi1和edp1使用相同的端口，二者只能同时使用其中的一个。

3、内部只有四个VP，所以最多可以激活四个接口。

4、hdmi、edp、dp只能在VP0或VP1或VP2上显示。

5、dsi0、dsi1只能在VP2或是VP3上显示。

6、rgb只能在VP3上显示。

所以 HDMI0/1，EDP0/1，DP0/1可选参数为：”VP0”，”VP”，”VP2”，”OFF”；

DP0/1可选参数为：”VP2”，”VP3”；

RGB可选参数为：”VP3”;

primary_display参数根据实际分配获得VP的显示接口而定。

disp_type可选参数为同显“sync”和异显 ”async”

⁉️ **注意：修改设备树时需要按照注释规则进行修改，避免使用冲突。驱动不会检测forlinx-control配置是否符合规则。如果设置错误将会导致显示异常。**

**对于设置为”OFF”的显示接口，屏蔽，删除或保留皆可。四个VP可以不用全部都设置。**

**设置举例**:

将VP0分配给HDMI0，VP1分配给HDMI1，未使用VP2，VP3分配给RGB使用。将主屏设置为HDMI0。

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954729981-047114a6-2fe3-4934-8ffe-88812222c98c.png)

保存后，重新编译生成镜像。

## 2.6 系统关闭
一般情况下直接关闭电源即可，如果有数据存储、功能使用等操作，操作过程中不要随意断电，以防出现文件不可逆损坏，只能重新烧写固件。未确保数据完全写入，可输入 sync 命令完成数据同步后再关闭电源。

⁉️ **注意：用户依据核心板设计的产品，若在使用中存在意外掉电导致系统异常关闭的情景，可在设计中加入掉电保护等措施。**



# 03_桌面功能测试

OK3588平台对Qt的支持非常完善，特别是多媒体相关的类，例如视频解码播放、摄像头、视频录制等，均能结合硬件编解码以及OpenGL达到最佳效果。



### 3.1 界面功能简介
开发板启动后桌面显示如下：

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053223756-9cbec827-f85f-4330-afb0-a51129acd1fc.png)

### 3.2  硬件解码体验
```plain
点击桌面图标进入打开视频播放器video player。
```

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053223868-ce5f49dc-37d2-41bb-b379-ca0008f46c75.png)

应用图标

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954742140-33ef4eb1-dbbe-4857-b103-0449d47e9168.png)

⁉️ **注意：测试视频文件所在目录：/userdata/media/*.mp4**

⁉️ **播放8K视频请只开一个显示屏进行测试。**

### 3.3  OpenGL测试
OK3588支持OpenGL ES3.2,点击桌面图标进行OpenGL测试。

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053223976-605398dc-e6f0-4d13-9a74-9bc7d3e154fc.png)

应用图标

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053224064-1354666a-5e4d-4dca-bb03-4c5a928e001f.png)

### 3.4  播放音乐测试
“musicplayer”是一款简单的音频测试应用，可用来测试声卡功能是否正常，也可用来作为一款简单的音频播放器。

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053224220-c5662bd5-8050-499d-add1-4b9fd668bf0b.png)

应用图标

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053224320-f33c56b0-3a64-449e-b048-aa115e81f7d5.png)

应用界面

点击左下角的按钮，选择测试音频 /userdata/media/test.mp3

⁉️ 注意：默认声卡输出为nau8822输出，若要使用HDMI输出请在串口使用命令：

```plain
root@ok3588:/# gst-play-1.0 /userdata/media/test.mp3 --audiosink="alsasink device= plughw:3,0"
```

### 3.5  4G/5G测试
⁉️ 注意：此测试需要插入可上网的SIM卡，具体操作描述可以参考本手册的命令行功能测试 5G章节。



“4G/5G”测试程序用于测试OK3588外置5G模块(RM500U)。测试前请将开发板断电，接入5G模块，插入SIM卡，启动开发板打开测试应用。

同时该测试支持4G模组（EM05-CE），在断电情况下插入4G模组和SIM卡，上电系统启动后打开测试应用。

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053224425-fd1b1ba7-c7ba-4350-a09d-0a4ab2971f45.png)

应用图标

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053224585-ae5b0597-ca25-4095-8bb2-4d2e110e16a7.png)

应用界面

```plain
点击connect按钮，程序将自动进入拨号流程并获取IP设置DNS等，耐心等待几秒钟后，点击ping按钮进行测试。
```

### 3.6  WIFI测试
“WIFI”是一款配置wifi的工具，OK3588平台默认板载AW-XM458模块。wifi模块在系统中会以mlan结点的形式存在，此测试对应mlan0（多设备时使用其它对应节点）：

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053224687-5cbea6da-6347-4812-a540-fc3263068270.png)

应用图标

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053224782-3dd40a5f-88ce-44c9-bfd3-fcb88844d693.png)

应用界面

选中mlan0，在SSID栏中输入需要使用wifi连接的路由器名称，PAWD栏输入路由器密码，点击connect，即可通过wifi连接路由器，在IP栏中输入有效ip后，点击ping，可查看当前使用wifi网络是否畅通。

下面以AW-XM458模块为例测试

打开Wifi测试应用，输入正确的网络名称及密码，点击connect，等待5秒后点击status查看连接窗台。

```plain
连接成功后可点击ping进行网络测试
```

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053224864-dbcb5d88-193b-43c6-a130-a6e376219e66.png)

### 3.7  网络配置测试
OK3588启动时网卡默认设置为dhcp，可通过“Network”网络配置应用来选择 dhcp和static两种模式，static模式可配置ip地址、子网掩码、网关、DNS。

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053224980-1f02ba2f-c029-46d6-bb53-9b9656910152.png)

应用图标

DHCP模式界面如下：

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053225064-2c44f29a-77d7-4f5c-bcd0-d5919fc9b6b2.png)

选中DHCP，在interface中选中需要配置的网卡设备，点击界面下方的Apply and Restart Network，即可重启网络并自动获取到ip。

static模式界面如下：

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053225196-1232af09-7ed9-451b-9ad9-31d2dfa25fa9.png)

在interface中选中需要配置的网卡设备，在ip栏中输入要设定的ip，netmask栏中输入子网掩码，geteway栏中输入网关，dns栏中输入DNS。

注：在STATIC模式下设置的ip等信息会被保存至系统的相关配置文件中，因此每次重启都会使用本次设置的网络信息；而在DHCP模式下配置的网络信息则不需注意这一点，每次重新启动都会动态分配一次ip地址。

### 3.8  Ping测试
“Ping”是网络测试常用命令ping的界面版应用:

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954745453-24d4f300-19ce-4448-abaf-dabe0990e8bd.png)

应用图标

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954745698-252561e9-00ef-4ed6-b3f2-9a2026f88e3a.png)

应用界面

在hostname一栏中写人需要ping的目标ip，点击ping键后，result栏中会提示ping的结果，点击stop可停止ping测试，点击clear清空result中的信息。

### 3.9  浏览器测试
“DemoBrowser”是一款简单实用的网络浏览器，在使用时请保证网络通畅，访问外网前需保证dns可用，浏览器启动时默认访问飞凌嵌入式官方网站，界面如下：

⁉️ 注意：如果开发板的时间异常会导致证书问题。使用浏览器后不可以立即关闭电源或者在关闭电源前在命令行使用sync命令，否则可能导致浏览器异常退出，无法正常运行，只能重新烧录解决。

![](https://cdn.nlark.com/yuque/0/2024/jpeg/45535139/1718954745936-2b14cb7c-5b24-4d52-b285-03c603531ff6.jpeg)

通过上方导航栏File->Quit退出该浏览器。

### 3.10  看门狗测试
“WatchDog”是用来测试看门狗功能是否正常的应用

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053225320-82d8a07e-c271-4de3-86ca-e286b36b4b91.png)

应用图标

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053225449-9da8c2bf-5599-45cf-9af2-54e87e0dda54.png)

应用界面

勾选feed dog，点击open watchdog按键，此时看门狗功能会被启动，程序会进行喂狗操作，正常情况下系统不会重启；取消勾选feed dog时，点击open watchdog按键，看门狗功能会被启动，程序不进行喂狗操作，在打开看门狗约10s后，系统进入重启，说明看门狗功能正常。

### 3.11  按键测试
“Keypad”用于测试平台自带按键是否可用：

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053225580-f1b482e0-d867-4d84-a35b-e8e87a207737.png)

应用图标

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053225677-6e2a4584-016a-41fd-a9d6-41c154108208.png)

应用界面

OK3588平台默认将4个物理按键V+、V-、Home、ESC分别配置为音量+键、音量-键，Home、返回键。当按下按键时测试应用中的对应按键会变为蓝色，说明按键功能正常。

“Exit”退出当前例程，返回到系统桌面。

### 3.12  RTC测试
通过“RTC”应用，可查看和设置当前的系统时间：

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053225759-25931508-fc33-4d70-af32-e569136725d9.png)

应用图标

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053225843-b781f518-e8ff-4084-b411-1bdd8e5a9a1c.png)

应用界面

点击set后，即可进行时间的设置，设置完毕点击保存，即可设置完成。

在安装RTC备用电池的情况下，断电重启开发板以确认RTC时钟设置成功。



### 3.13  同显异显
⁉️ **注意：默认为同显；异显配置需要在UBOOT菜单将disp_type属性值更改成async。**

⁉️ **注意: 在异显情况下，配置多屏显示而没有接上显示器， QT显示将会在相邻屏上显示， 需要在QT里检测是否已经接屏。**

点击桌面图标QtMultScreen用来测试多屏异显。

根据UBOOT菜单配置章节打开多个屏，将HDMI配置成主屏。

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954747615-b7ae9f58-d366-4a13-a966-7ca6acedae9a.png)

点击”show”按钮之后将会在其它屏上弹出一个窗口，使用鼠标可以在其它屏上移动QT窗口。

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954747849-aa7365c7-ba29-429c-807a-2d7e9308691c.png)



### 3.14  UART测试
点击桌面图标可以使用它来测试OK3588板载UART接口。

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053225920-129c1bb6-a9f9-4b83-a588-121297e8e01d.png)

应用图标

OK3588平台底板原理图中标示引出的UART2、UART4、UART6、UART9共4路串口，其中UART2为调试串口，UART6为蓝牙串口，UART9为485串口。UART4、UART9在开发板中的默认设备名称分别为ttyS4，ttyS9。 

| **UART** | **设备节点** | **说明** |
| :---: | :---: | --- |
| UART2 | /dev/ttyS2 | 调试串口，不能直接用于该测试: |
| UART4 | /dev/ttyS4 | TTL点平，P11引出， 可用于测试 |
| UART6 | /dev/ttyS6 | 用于蓝牙，未单独引出，不能直接用于该测试 |
| UART9 | /dev/ttyS9 | RS485 |


使用命令fltest_qt_terminal可以打开uart的qt测试程序（qt测试方法参考本节开头设置）。本次测试采用UART4(ttyS4)，通过开发板的UART和电脑串口工具软件之间的数据收发，来进行串口测试。

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954748405-4166e8b5-f06c-4e5e-80f9-78af5f59b990.png)

1、开发板和电脑通过TTL转USB模块连接好后，给开发板上电，在电脑设备管理器查看识别为COM4（用户以自己实际识别的COM口设置参数）

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954748622-c72bd518-65af-4d62-8faa-ce04aef130e9.png)

2、打开电脑串口工具，设置串口参数：波特率115200、8位数据位、1位停止位、无校验、无流控制，并打开串口。

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1721638493475-d3d954e1-408b-45ab-a489-16a3a1167efc.png)

3、点击UART测试图标，进入如下界面，进行串口参数设置：

![](https://cdn.nlark.com/yuque/0/2024/jpeg/45535139/1718954749000-98287ab8-efd2-48b4-8648-318545498c44.jpeg)

点击左上角![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954749178-50754fdd-090e-43f7-833d-0881f8596f62.png)设置按钮，设置串口参数与电脑端串口工具参数一致，如下图：

| **相关参数** | **含义** |
| --- | --- |
| Select Serial Port | 设置串口（选择UART5，即ttyS5） |
| BaudRate | 设置波特率（115200） |
| Data bits | 设置数据位（8位） |
| Parity | 设置校验位（无校验） |
| Stop bits | 设置停止位（1位） |
| Flow control | 设置流控（无流控） |


![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954749367-09e3127f-84a3-44b5-b339-7c64b19ba656.png)

```plain
设置完串口参数后，点击左上角的![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954749590-052564b6-a4f3-4f38-8722-b5a624c102d8.png)连接按钮，此时测试程序可以进行数据收发测试。
```

4、此时电脑端串口工具发送：“forlinx_uart_test.1234567890...”，测试界面会接收到数据：

![](https://cdn.nlark.com/yuque/0/2024/jpeg/45535139/1718954749795-538f093d-27bb-4cc4-8604-c3a123ca224f.jpeg)

点击测试界面会弹出软键盘，输入“abcdefg”，按软键盘的回车，向电脑端串口工具发送数据：

![](https://cdn.nlark.com/yuque/0/2024/jpeg/45535139/1718954749970-1a4fb96f-5011-4aa9-9f33-524dae7ce276.jpeg)

电脑端串口工具接收到数据：

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1721639690809-63a3196c-c12b-4ff3-97d3-cbe2d837d7cb.png)

### 3.15  数据库测试
点击桌面图标可以使用Sqlite测试数据库。

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053226012-126491da-8598-4417-8bae-d7bb758aa596.png)

应用图标

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053226103-30863d1f-5705-4056-85c0-34ca9cff96d8.png)

### 3.16  背光测试
“BackLight”是lcd背光调整应用：

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053226273-f8775d1c-041a-43b0-8c66-84a18b047231.png)

应用图标

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053226373-dafc8166-e107-49c9-bbe8-a202467a7670.png)

拖动界面中的滑块即可设置Lcd背光亮度，0级为无背光，255级为最高亮度。



### 3.17  UbootMenu
点击桌面图标![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053226474-485a8384-4028-4aad-bce8-9744fd0658e0.png)可以进行Uboot菜单配置

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053226627-c6bee14c-7226-415c-9fac-ffdbe0197e44.png)

配置完成之后，重启开发板生效。

### 3.18  Web服务
OK3588开发板预装了lighttpdweb服务器，并且系统启动时已经自动启动了lighttpd服务，在PC端的浏览器中输入开发板的IP 地址即可浏览开发板webserver 中的网页，如下图所示：

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053226847-20a0e978-a65d-420c-8c8b-5a3a2e326545.png)

⁉️ 注意：开发板的网络ip需要和PC机的网络IP在同一网段下才可以正常使用该功能，或者PC在开发板所处网络的子网下。

### 3.19  异触摸
```plain
将OK3588 配置成异显模式，接入两个MIPI 显示屏，分别触摸各个MIPI屏它们之间互不受影响。
```

### 3.20  Tftp升级系统
⁉️ **注意：当前版本升级rootfs.img文件不能大于1.6G。**

⁉️ **注意：使用tftp udp方式传输， 端口号为69.**

⁉️ **注意：安装tftpd服务器工具Tftpd64.4.64.exe**

+ <font style="color:#0000ff;">路径：OK3588-C-Linux 用户资料/工具/Tftpd64.4.64.exe</font>
1. 安装Tftpd64.4.64.exe
2. 打开Tftpd64.4.64.exe，进行测试

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954752164-298a591f-2c3b-4bb7-80ae-91908538e041.png)

CurrentDirectory: 选择OK3588-C 分区固件存放路径。

Server interfaces: 选择本地IP地址，

⁉️ **注意：请关闭window防火墙，请客户自行验证tftp 下载文件测试。**

1. 打开桌面Tftp Update图标

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053227013-e7482a3f-f3a5-482f-8ef1-932f0ae36a23.png)

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954752607-68c786b5-539f-4b82-8460-44b1d961acea.png)

请客户根据实际情况填写。 选择需要更新的固件。

单击 Tftp:Off 变成Tftp:On；重启板卡。

串口打印信息如下：

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954752821-bc7cd981-3cb1-4067-a55d-446e3a41cd6c.png)

### 3.21  CPU频率配置测试
⁉️ **注意：**当前界面只配置A55核，没有配置A76核调频，A76核调频请参考调频测试章节。

```plain
点击桌面图标进入下一级菜单：
```

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954753126-80537975-b46f-4148-a54c-14f4ecfb3aef.png)**->**![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954753325-4499b669-ec46-4b4d-becd-eb3b24ec0bdd.png)

应用图标

```plain
OK3588 CPU主频最大1.8Ghz，默认情况下CPU会根据负载动态调整主频，也可以通过设置固定CPU主频率。

点击桌面 Power 图标进入CPU主频设置页面：
```

![](https://cdn.nlark.com/yuque/0/2024/jpeg/45535139/1718954753503-b94b7b9b-6a51-42da-83b2-8ab3f5d52159.jpeg)

```plain
Set Userspace Governor：用户态设置主频
```

Set Frequency A55：设置主频

```plain
以设置主频频率为例，如果需要设置固定频率，请先点击Set Userspace Governor，点击run，再返回上图操作界面，点击Set Frequency A55进行设置。
```

![](https://cdn.nlark.com/yuque/0/2024/jpeg/45535139/1718954753742-7766e8da-4e6a-4842-a77a-3c04a57d51b5.jpeg)

```plain
根据需求选择对应的频率进行设置。
```



# 04_命令行功能测试

OK3588平台内置了丰富的命令行工具可供用户使用。

### 4.1  系统信息查询
查看内核和cpu信息，输入如下命令

```plain
root@ok3588-buildroot:~# uname -a
Linux ok3588-buildroot 5.10.209 #1 SMP Sun Aug 18 19:07:38 CST 2024 aarch64 GNU/Linux
```

查看操作系统信息：

```plain
root@ok3588-buildroot:~# cat /etc/issue
Welcome to Forlinx OK3588 Board
```

查看环境变量信息：

```plain
root@ok3588-buildroot:/# env
SHELL=/bin/sh
GST_V4L2_PREFERRED_FOURCC=NV12:YU12:NV16:YUY2
GST_VIDEO_CONVERT_PREFERRED_FORMAT=NV12:NV16:I420:YUY2
CHROMIUM_FLAGS=--enable-wayland-ime
GST_V4L2_USE_LIBV4L2=1
GST_INSPECT_NO_COLORS=1
PULSE_HOME=/userdata/.pulse
EDITOR=/bin/vi
GST_DEBUG_NO_COLOR=1
PWD=/
HOME=/
LANG=en_US.UTF-8
WESTON_DRM_PRIMARY=DSI-1
ADB_TCP_PORT=5555
LS_COLORS=rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:
WAYLANDSINK_FORCE_DMABUF=1
GST_V4L2SRC_DEFAULT_DEVICE=/dev/video-camera0
QT_QPA_PLATFORM=wayland
USB_FW_VERSION=0x0310
TERM=xterm-color
USER=root
AUTOAUDIOSINK_PREFERRED=pulsesink
ADBD_SHELL=/bin/bash
GST_V4L2SRC_RK_DEVICES=_mainpath:_selfpath:_bypass:_scale
WESTON_DRM_MIRROR=1
SHLVL=1
USB_FUNCS=adb
WESTON_DISABLE_ATOMIC=1
USB_MANUFACTURER=Rockchip
USB_PRODUCT=rk3xxx
XDG_RUNTIME_DIR=/var/run
USB_VENDOR_ID=0x2207
PLAYBIN2_PREFERRED_AUDIOSINK=pulsesink
PATH=/usr/bin:/usr/sbin
storagemedia=emmc
GST_V4L2SRC_MAX_RESOLUTION=3840x2160
GST_VIDEO_DECODER_QOS=0
_=/usr/bin/env
```

### 4.2  调频测试
📚**说明：四核A55分别是cpu0、cpu1、cpu2、cpu3; 四核A76分别是cpu5、cpu6、cpu7、cpu8。此过程以cpu0为例操作，实际过程cpu1、cpu2、cpu3会同时改变； 单独操作cpu4、 cpu5、cpu6、cpu7相互之间不会受到影响**。

1.    当前内核中支持的所有cpufreq governor类型：

```plain
root@ok3588-buildroot:/# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
conservative ondemand userspace powersave performance schedutil
```

其中userspace表示用户模式，在此模式下允许其他用户程序调节CPU频率。

1. 查看当前CPU支持的频率档位

```plain
root@ok3588-buildroot:~# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
408000  600000  816000  1008000  1200000  1416000  1608000  1800000
```

1. 设置为用户模式，修改频率为1800000：

```plain
root@ok3588-buildroot:/# echo userspace > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
root@ok3588-buildroot:/# echo 1800000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
```

查看修改后当前频率：

```plain
root@ok3588-buildroot:/# cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
1800000
```

### 4.3  温度测试
查看温度值：

```plain
root@ok3588-buildroot:~# cat /sys/class/thermal/thermal_zone0/temp
45307
```

温度值即为45.3℃。

### 4.4  DDR测试
```plain
root@ok3588-buildroot:/# fltest_memory_bandwidth.sh
L1 cache bandwidth rd test with # process
0.008192 34377.39
0.008192 33984.75
0.008192 55061.17
0.008192 55036.10
0.008192 31220.66
L2 cache bandwidth rd test
0.131072 43651.06
0.131072 43698.59
0.131072 43608.40
0.131072 43682.74
0.131072 37935.10
Main mem bandwidth rd test
52.43 18157.16
52.43 18066.44
52.43 18711.21
52.43 18293.37
52.43 17823.83
L1 cache bandwidth wr test with # process
0.008192 71583.65
0.008192 50513.15
0.008192 71591.09
0.008192 71590.31
0.008192 71535.33
L2 cache bandwidth wr test
0.131072 43075.72
0.131072 45764.77
0.131072 41351.95
0.131072 46124.97
0.131072 44245.42
Main mem bandwidth wr test
52.43 7342.97
52.43 7310.21
52.43 7357.40
52.43 7352.24
52.43 7330.65
L1 cache bandwidth rdwr test with # process
0.008192 36026.35
0.008192 36037.05
0.008192 36048.68
0.008192 36036.17
0.008192 36024.58
L2 cache bandwidth rdwr test
0.131072 25015.92
0.131072 25010.29
0.131072 25017.20
0.131072 25020.46
0.131072 13448.39
Main mem bandwidth rdwr test
52.43 10359.38
52.43 10580.99
52.43 10595.96
52.43 10304.40
52.43 10792.26
L1 cache bandwidth cp test with # process
0.008192 28217.79
0.008192 36032.60
0.008192 36036.75
0.008192 36038.84
0.008192 36041.82
L2 cache bandwidth cp test
0.131072 22356.68
0.131072 22555.37
0.131072 22625.67
0.131072 22519.82
0.131072 22364.80
Main mem bandwidth cp test
52.43 6197.99
52.43 6141.36
52.43 6114.86
52.43 6138.48
52.43 6102.76
L1 cache bandwidth frd test with # process
0.008192 10891.45
0.008192 10895.39
0.008192 10898.38
0.008192 10893.92
0.008192 10895.88
L2 cache bandwidth frd test
0.131072 10815.70
0.131072 10811.78
0.131072 10819.62
0.131072 10816.62
0.131072 10778.87
Main mem bandwidth frd test
52.43 9245.07
52.43 9048.81
52.43 9310.74
52.43 9365.63
52.43 9180.32
L1 cache bandwidth fwr test with # process
0.008192 15780.22
0.008192 15145.62
0.008192 30524.19
0.008192 30891.70
0.008192 31170.71
L2 cache bandwidth fwr test
0.131072 27427.59
0.131072 22163.22
0.131072 27451.38
0.131072 24936.65
0.131072 27422.61
Main mem bandwidth fwr test
52.43 3328.81
52.43 3343.89
52.43 3326.91
52.43 3335.38
52.43 3321.01
L1 cache bandwidth fcp test with # process
0.008192 9104.37
0.008192 9051.73
0.008192 5531.40
0.008192 9056.83
0.008192 6320.95
L2 cache bandwidth fcp test
0.131072 8971.34
0.131072 4788.34
0.131072 8972.33
0.131072 4779.16
0.131072 6890.70
Main mem bandwidth fcp test
52.43 8565.40
52.43 8787.93
52.43 8732.31
52.43 8564.00
52.43 8559.80
L1 cache bandwidth bzero test with # process
0.008192 70325.47
0.008192 61005.11
0.008192 70226.90
0.008192 70151.61
0.008192 70173.32
L2 cache bandwidth bzero test
0.131072 60200.58
0.131072 59218.33
0.131072 47963.00
0.131072 43743.43
0.131072 54540.03
Main mem bandwidth bzero test
52.43 27843.23
52.43 27449.63
52.43 27216.89
52.43 27569.92
52.43 27608.64
L1 cache bandwidth bcopy test with # process
0.008192 35515.04
0.008192 35475.39
0.008192 35526.89
0.008192 35551.67
0.008192 35482.84
L2 cache bandwidth bcopy test
0.131072 32708.53
0.131072 32761.49
0.131072 16620.35
0.131072 28515.39
0.131072 32714.54
Main mem bandwidth bcopy test
52.43 11990.58
52.43 11997.44
52.43 11856.35
52.43 11929.19
52.43 11706.78
```



### 4.5  看门狗测试
看门狗是嵌入式系统中经常用到的功能，OK3588中看门狗的设备节点为/dev/watchdog 。本测试提供了两种测试程序，用户根据实际情况选择一种测试。

启动看门狗，设置复位时间10s，并定时喂狗

使用fltest_watchdog，此命令会打开看门狗并执行喂狗操作，因此系统不会重启

```plain
root@ok3588-buildroot:~# fltest_watchdog
Watchdog Ticking Away!
```

使用ctrl+c结束测试程序时，停止喂狗，看门狗处于打开状态，10s后系统复位;

若不想复位，请在结束程序之后10s内输入关闭看门狗命令：

```plain
root@ok3588-buildroot:~# fltest_watchdog -d                       //关闭看门狗
```

启动看门狗，设置复位时间10s，不喂狗

执行命令fltest_watchdogrestart, 此命令会打开看门狗，但不执行喂狗操作，系统会在10s后重启.

```plain
root@ok3588-buildroot:~# fltest_watchdogrestart
```

### 4.6  RTC功能测试
⁉️ **注意：确保板子上已经安装了纽扣电池，并且电池电压正常**

<font style="color:#000000;">RTC 测试，主要通过使用 date 和 hwclock 工具设置软、硬件时间，测试当板子断电再上电的时候，软件时钟读取 RTC 时钟是否同步</font>

时间设置

```plain
root@ok3588-buildroot:/# date -s "2022-12-12 17:23:00"               //设置软件时间
Mon Dec 12 17:23:00 CST 2022
root@ok3588-buildroot:/# hwclock -wu			          //将软件时间同步到硬件时间
root@ok3588-buildroot:/# hwclock -r					    //显示硬件时间
Mon Dec 12 17:23:06 CST 2022
```

然后给板子断电再上电，进入系统后读取系统时间，可以看到时间已经同步。

```plain
root@ok3588-buildroot:~# date
Mon Dec 12 17:23:20 CST 2022
```

### 4.7  按键测试
使用fltest_keytest命令行工具进行按键测试，目前fltest_keytest支持底板上4个按键VOL+、VOL-、MENU、ESC的测试，键码分别为115、114、139、158

执行如下命令：

| ```plain root@ok3588-buildroot:~# fltest_keytest ``` |
| --- |


此时依次按下抬起按键，终端上可输出如下内容：

```plain
key115 Presse                                                         // VOL+按下
key115 Released                                                       // VOL+抬起
key114 Presse                                                         // VOL-按下
key114 Released                                                       // VOL-抬起
key139 Presse                                                         // MENU按下
key139 Released                                                       // MENU抬起
key158 Presse                                                          // ESC按下
key158 Released                                                        // ESC抬起
```

### 4.8  UART测试
OK3588平台底板原理图中标示引出的UART2、UART4、UART6、UART9共4路串口，其中UART2为调试串口，UART6为蓝牙串口，UART9为485串口。UART4、UART9在开发板中的默认设备名称分别为ttyS4，ttyS9。 

| **UART** | **设备节点** | **说明** |
| :---: | :---: | --- |
| UART2 | /dev/ttyS2 | 调试串口，不能直接用于该测试: |
| UART4 | /dev/ttyS4 | TTL电平，P11引出， 可用于测试 |
| UART6 | /dev/ttyS6 | 用于蓝牙，未单独引出，不能直接用于该测试 |
| UART9 | /dev/ttyS9 | RS485 |


本次测试采用UART4(ttyS4)，按照开发板原理图短接UART4的收发引脚，分别对应PIN7,PIN10。通过开发板的UART和电脑串口工具软件之间的数据收发，来进行串口测试。

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954754043-49789947-2230-467b-94e8-811528fac838.png)

1、开发板和电脑通过TTL转USB模块连接好后，给开发板上电，在电脑设备管理器查看识别为COM4（用户以自己实际识别的COM口设置参数）

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954754264-bafeb07d-6346-455b-bc94-86876b66d6f9.png)

2、打开电脑串口工具，设置串口参数：波特率115200、8位数据位、1位停止位、无校验、无流控制，并打开串口。

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1721639992165-b124c989-eb0c-4460-89d3-02b8a163d02e.png)

在开发板串口中输入如下命令（测试程序固定波特率为115200）：

```plain
root@ok3588-buildroot:~# fltest_uarttest  -d /dev/ttyS4
```

打印信息如下：

```plain
Welcome to uart test
Send test data:
forlinx_uart_test.1234567890...                                             //发送的数据
```

测试程序自动发送“forlinx_uart_test.1234567890...”，此时查看串口助手，接收到该信息：

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1721639829473-47f93c6e-4274-497e-8941-b48b1d88e9c5.png)

电脑串口工具发送“forlinx_uart_test.1234567890...”，此时开发板接收到信息，相关打印信息如下：

```plain
Welcome to uart test
Send test data:
forlinx_uart_test.1234567890...
Read Test Data finished,Read:
forlinx_uart_test.1234567890...                                             //接收到数据
```

### 4.9  ADC测试
OK3588-C开发板内部提供了8路ADC，在saradc2、 saradc4、saradc5、saradc6、saradc7通道上连接了一个可调电阻，选择 saradc2进行测试，ADC引脚硬件图如下，在P12的1引脚输入电压。当前芯片使用1.8V参考电压对应 12 位ADC最大值4096。

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954754798-54d027c1-628b-4d34-ab5b-797c40cd9e55.png)

测试可调电阻数值

```plain
root@ok3588-buildroot:~# cd /sys/bus/iio/devices/iio:device0
root@ok3588:/sys/bus/iio/devices/iio:device0# cat in_voltage2_raw
3516
```

### 4.10  TF卡测试
📚**说明：**

+ **SD卡挂载目录为/run/media/，支持热插拔。**

1、上电前将TF卡插入开发板底板的TF卡插槽，上电启动，运行命令dmesg，终端有如下打印信息：

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954755132-b8fa31c3-71ab-44c2-a7a5-47be2cdf23f6.png)

2、查看挂载目录：

```plain
root@ok3588-buildroot:~#  mount | grep "mmcblk1p1"
/dev/mmcblk1p1 on /run/media/mmcblk1p1 type vfat (rw,relatime,fmask=0022,dmask=0022,codepage=936,iocharset=utf8,shortname=mixed,errors=remount-ro)
```

3、写入测试：

```plain
root@ok3588-buildroot:/# dd if=/dev/zero of=/run/media/mmcblk1p1/test bs=1M count=500 conv=fsync
500+0 records in
500+0 records out
524288000 bytes (524 MB, 500 MiB) copied, 13.5747 s, 38.6 MB/s
```

4、读取测试：

⁉️ **注意：为确保数据准确，请重启开发板后测试读取速度。**

```plain
root@ok3588-buildroot:/# dd if=/run/media/mmcblk1p1/test of=/dev/null bs=1M
500+0 records in
500+0 records out
524288000 bytes (524 MB, 500 MiB) copied, 9.60899 s, 54.6 MB/s
```

5、TF卡使用完成后，在弹出TF卡前，需要使用umount卸载TF

```plain
root@ok3588-buildroot:/# umount /run/media/mmcblk1p1
```

⁉️ **注意：退出TF卡挂载路径后再插拔TF卡。**

### 4.11  eMMC 测试
OK3588平台eMMC默认运行于HS200模式200MHz时钟，下面简单测试eMMC的读写速度，以读写ext4文件系统为例。

写入测试：

```plain
root@ok3588-buildroot:/# dd if=/dev/zero of=/test bs=1M count=500 conv=fsync
500+0 records in
500+0 records out
524288000 bytes (524 MB, 500 MiB) copied, 3.29881 s, 159 MB/s
```

读取测试：

⁉️ **注意：为确保数据准确，请重启开发板后测试读取速度。**

```plain
root@ok3588-buildroot:/# dd if=/test of=/dev/null bs=1M
500+0 records in
500+0 records out
524288000 bytes (524 MB, 500 MiB) copied, 2.57102 s, 204 MB/s
```

### 4.12  USB鼠标测试
<font style="color:#000000;">将USB鼠标接入OK3588平台的usb接口，使用dmesg命令， 串口终端的打印信息如下：</font>

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053228830-5fb0b889-72cb-430f-b8b1-7d6598afa586.png)

<font style="color:#000000;">此时在屏幕上出现箭头光标，鼠标已可正常使用。</font>

### 4.13  USB2.0
OK3588支持一个USB2.0接口用户可以在任何一个板载USB HOST接口上连接USB鼠标、 USB键盘、U盘等设备， 并支持以上设备的热插拔。 这里用挂载U盘为例进行演示， 目前U盘测试支持到32G， 32G以上并未测试。

终端会打印关于U盘的信息，由于存在很多种U盘，显示的信息可能会有差别：

1. 开发板启动后，连接USB接口u盘到开发板的USB host接口，默认log打印信息较低，不会有打印信息。可以使用dmesg命令查看，找到u盘相关信息

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053228927-c4898f1e-b98e-4c60-96db-2ea878bf5a75.png)

1. 查看挂载目录：

```plain
root@ok3588-buildroot:/# mount | grep "sda1"
/dev/sda1 on /run/media/sda1 type vfat (rw,relatime,fmask=0022,dmask=0022,codepage=936,iocharset=utf8,shortname=mixed,errors=remount-ro)
```

可以看到/run/media/sda1为USB存储设备的挂载路径

3、查看U盘内容(这里的sda1以实际U盘分区名称为准)

```plain
root@ok3588-buildroot:/# ls -l /run/media/sda1/
total 8
drwxrwx--- 2 root disk 8192 Sep 23  2021 'System Volume Information'
-rwxrwx--- 1 root disk    0 Apr 25 09:25  test
```

4、写入测试，写入速度受限于具体的存储设备：

```plain
root@ok3588-buildroot:/# dd if=/dev/zero of=/run/media/sda1/test bs=1M count=500 conv=fsync
500+0 records in
500+0 records out
524288000 bytes (524 MB, 500 MiB) copied, 74.533 s, 7.0 MB/s
```

5、读取测试：

⁉️**注意：为确保数据准确，请重启开发板后测试读取速度。**

```plain
root@ok3588-buildroot:/# dd if=/run/media/sda1/test of=/dev/null bs=1M iflag=direct
500+0 records in
500+0 records out
524288000 bytes (524 MB, 500 MiB) copied, 25.2193 s, 20.8 MB/s
```

6、U盘使用完成后，在拔出U盘前，需要使用umount卸载

```plain
root@ok3588-buildroot:/# umount /run/media/sda1
```

⁉️ **注意：退出U盘挂载路径后再插拔U盘。**

### 4.14  TYPE-C 测试
OK3588-C包含2个TYPE-C接口，TPYE-C0的HOST/DEVICE模式自动识别，TYPE-C1只有HOST模式。Device模式可以用它来进行刷机，ADB文件传输、调试，Host模式可以插入普通的USB 设备。

Device 模式： 

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954755736-a5acc21c-f6b2-4915-9f89-0c5a95090beb.png)

Host模式：

通过demsg 查看插入信息。

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053229031-ba43be22-88e1-4f7e-9439-f1cecdf4256a.png)

### 4.15  以太网配置
OK3588-C板载两个千兆网卡，插入网线连接网络的情况下，出厂时默认配置为动态IP。

创建一个eth0配置文件， 配置文件的路径为：/etc/network/interfaces,设置动态ip的配置文件内容为

```plain
auto eth0
iface eth0 inet dhcp
```

设置静态配置ip，以下以eth0设置ip为192.168.0.232为例：

```plain
auto eth0
iface eth0 inet static
address 192.168.0.232
netmask 255.255.255.0
gateway 192.168.0.1
```

| **参数** | **含义** |
| :---: | --- |
| iface | 用于指定需要固定IP的网卡 |
| address | 用于指定需要固定的IP地址 |
| netmask | 用于设置子网掩码 |
| gateway | 用于指定网关 |


设置完后使用sync文件同步指令，重启开发板或者重启服务，配置生效。

```plain
root@ok3588-buildroot:/# ifdown –a
root@ok3588-buildroot:/# ifup -a
```

### 4.16  WIFI 测试
📚**说明：**

+ **由于网络环境的不同，所以在您做本实验时，请根据实际情况进行设置。**

OK3588平台支持2种WIFI蓝牙二合一模块：AW-XM458和AW-CM276MA。



STA 模式 

该模式即作为一个站点，连接到无线网络中。以下测试中，路由器采用wpa加密方式，连接的wifi热点名称为：H3C_708_5G，密码为：123456785.。由于网络环境的不同，用户在进行本次测试时，请根据实际情况进行设置：

1、以AW-XM458模块为例，开发板终端中输入如下命令：

```plain
root@ok3588-buildroot:/# fltest_wifi.sh -i mlan0 -s H3C_708_5G -p 12345678
```

命令中相关参数含义如下：

| **参数** | **含义** |
| :---: | --- |
| -i | 不同wifi模块所用参数不同,指定WIFI设备名称 |
| -s | 连接的实际wifi热点名称。 |
| -p | 后接参数Password指要连接的实际wifi热点的密码；   如果当前热点没有密码，-p后参数写NONE。 |


串口打印如下：

```plain
wifi mlan0
ssid H3C_708_5G
pasw 123456785.
[  480.732219] wlan: Received disassociation request on mlan0, reason: 3
[  480.732260] wlan: REASON: (Deauth) Sending STA is leaving (or has left) IBSS or ESS
waiting...
[  483.053122] wlan: mlan0 START SCAN
try to connect again...
[  487.590894] wlan: Connected to bssid 14:XX:XX:XX:fc:87 successfully
[  487.600365] woal_cfg80211_set_rekey_data return: gtk_rekey_offload is DISABLE
RTNETLINK answers: File exists
Finshed!
```

2、检查是否能ping外网，在终端中输入如下命令：

```plain
root@ok3588-buildroot:/# ping www.forlinx.com -c 3
PING s-526319.gotocdn.com (211.149.226.120) 56(84) bytes of data.
64 bytes from 211.149.226.120 (211.149.226.120): icmp_seq=1 ttl=49 time=201 ms
64 bytes from 211.149.226.120 (211.149.226.120): icmp_seq=2 ttl=49 time=226 ms
64 bytes from 211.149.226.120 (211.149.226.120): icmp_seq=3 ttl=49 time=253 ms

--- s-526319.gotocdn.com ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2002ms
rtt min/avg/max/mdev = 201.045/226.733/252.750/21.109 ms
```



AP 模式

📚 **说明：**

+ **进行该项测试前需要保证千兆网卡eth0连网，并且网络正常；**
1. 查看驱动加载状态，以AW-XM458模块为例

```plain
root@ok3588-buildroot:/# lsmod                                 //查看已加载的模块
Module               Size      Used by    Tainted: G
moal                  573440  1
mlan                  454656  1 moal
```

1. 配置热点

WiFi热点名称：OK3588_WIFI_2.4G_AP

密码：12345678

热点名称和密码和通过/etc/hostapd-2.4g.conf文件查看。

```plain
root@ok3588-buildroot:/# sudo fltest_hostapd.sh
[  705.365653] wlan: Received disassociation request on mlan0, reason: 3
[  705.365693] wlan: REASON: (Deauth) Sending STA is leaving (or has left) IBSS or ESS
hostapd: no process found
Stopping dnsmasq (via systemctl): dnsmasq.service.
Configuration file: /etc/hostapd-2.4g.conf
[  706.760789] uap0: Skip change virtual intf on uap: type=3
Using interface uap0 with hwaddr 14:13:33:63:f0:73 and ssid "OK3588_WIFI_2.4G_AP"
[  706.777774] wlan: Starting AP
[  706.778591] Get ht_cap from beacon ies: 0xc
[  706.779094] fw doesn't support 11ax
[  706.789807] wlan: AP started
[  706.791465] Set AC=3, txop=47 cwmin=3, cwmax=7 aifs=1
[  706.793782] Set AC=2, txop=94 cwmin=7, cwmax=15 aifs=1
[  706.796067] Set AC=0, txop=0 cwmin=15, cwmax=63 aifs=3
[  706.798295] Set AC=1, txop=0 cwmin=15, cwmax=1023 aifs=7
uap0: interface state UNINITIALIZED->ENABLED
uap0: AP-ENABLED
Starting dnsmasq (via systemctl): dnsmasq.service.
```

### 4.17  蓝牙测试
OK3588开发板中底板AW-XM458模块，集成了蓝牙功能，本节演示使用手机与开发板之间通过蓝牙进行数据传输，支持蓝牙5.0。 

1、蓝牙配置

```plain
root@ok3588-buildroot:/# bluetoothctl                         //打开bluez蓝牙工具
[NEW] Controller B8:4D:43:12:43:6F forlinx [default]
Agent registered
[bluetooth]# power on                                            //启动蓝牙设备
Changing power on succeeded
[bluetooth]# pairable on                                          //设置为配对模式
Changing pairable on succeeded
[bluetooth]# discoverable on                                      //设置为可发现模式
[bluetooth]# [ 1547.589820] Bluetooth: hu ffffffc066059c00 retransmitting 1 pkts
Changing discoverable on succeeded
[CHG] Controller B8:4D:43:12:43:6F Discoverable: yes
[bluetooth]# agent on                                            //启动代理
Agent is already registered
[bluetooth]# default-agent                                        //设置当前代理为默认
Default agent request successful
```

2、开发板被动配对

此时打开PC蓝牙搜索，会出现一个“BlueZ 5.72”的设备，选择配对

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954756108-4860c91f-be25-4556-9756-af80fe60d925.png)

同时开发板上打印信息如下，输入yes

```plain
[bluetooth]# 
Default agent request successful
[NEW] Device 2C:DB:07:C7:4F:F6 DESKTOP-VND9V1F
Request confirmation
[agent] Confirm passkey 678054 (yes/no): yes
[CHG] Device 2C:DB:07:C7:4F:F6 UUIDs: 0000110c-0000-1000-8000-00805f9b34fb
[CHG] Device 2C:DB:07:C7:4F:F6 UUIDs: 0000110e-0000-1000-8000-00805f9b34fb
[CHG] Device 2C:DB:07:C7:4F:F6 Modalias: bluetooth:v0006p0001d0A00
[CHG] Device 2C:DB:07:C7:4F:F6 UUIDs: 00001000-0000-1000-8000-00805f9b34fb
[CHG] Device 2C:DB:07:C7:4F:F6 UUIDs: 0000110a-0000-1000-8000-00805f9b34fb
[CHG] Device 2C:DB:07:C7:4F:F6 UUIDs: 0000110b-0000-1000-8000-00805f9b34fb
[CHG] Device 2C:DB:07:C7:4F:F6 UUIDs: 0000110c-0000-1000-8000-00805f9b34fb
[CHG] Device 2C:DB:07:C7:4F:F6 UUIDs: 0000110e-0000-1000-8000-00805f9b34fb
[CHG] Device 2C:DB:07:C7:4F:F6 UUIDs: 00001115-0000-1000-8000-00805f9b34fb
[CHG] Device 2C:DB:07:C7:4F:F6 UUIDs: 0000111e-0000-1000-8000-00805f9b34fb
[CHG] Device 2C:DB:07:C7:4F:F6 UUIDs: 0000111f-0000-1000-8000-00805f9b34fb
[CHG] Device 2C:DB:07:C7:4F:F6 UUIDs: 00001200-0000-1000-8000-00805f9b34fb
[CHG] Device 2C:DB:07:C7:4F:F6 UUIDs: c7f94713-891e-496a-a0e7-983a0946126e
[CHG] Device 2C:DB:07:C7:4F:F6 ServicesResolved: yes
[CHG] Device 2C:DB:07:C7:4F:F6 Paired: yes
Authorize service
[agent] Authorize service 0000110e-0000-1000-8000-00805f9b34fb (yes/no): yes
Authorize service
[agent] Authorize service 0000110d-0000-1000-8000-00805f9b34fb (yes/no): yes
[CHG] Device 2C:DB:07:C7:4F:F6 UUIDs: 00001000-0000-1000-8000-00805f9b34fb
[CHG] Device 2C:DB:07:C7:4F:F6 UUIDs: 0000110a-0000-1000-8000-00805f9b34fb
[CHG] Device 2C:DB:07:C7:4F:F6 UUIDs: 0000110b-0000-1000-8000-00805f9b34fb
[CHG] Device 2C:DB:07:C7:4F:F6 UUIDs: 0000110c-0000-1000-8000-00805f9b34fb
[CHG] Device 2C:DB:07:C7:4F:F6 UUIDs: 0000110d-0000-1000-8000-00805f9b34fb
[CHG] Device 2C:DB:07:C7:4F:F6 UUIDs: 0000110e-0000-1000-8000-00805f9b34fb
[CHG] Device 2C:DB:07:C7:4F:F6 UUIDs: 00001115-0000-1000-8000-00805f9b34fb
[CHG] Device 2C:DB:07:C7:4F:F6 UUIDs: 0000111e-0000-1000-8000-00805f9b34fb
[CHG] Device 2C:DB:07:C7:4F:F6 UUIDs: 0000111f-0000-1000-8000-00805f9b34fb
[CHG] Device 2C:DB:07:C7:4F:F6 UUIDs: 00001200-0000-1000-8000-00805f9b34fb
[CHG] Device 2C:DB:07:C7:4F:F6 UUIDs: c7f94713-891e-496a-a0e7-983a0946126e
```

查看和移除连接设备：

```plain
[bluetooth]# devices		                             //查看连接的蓝牙设备
Device 2C:DB:07:C7:4F:F6 DESKTOP-VND9V1F 
[bluetooth]# remove 2C:DB:07:C7:4F:F6               //移除设备
```

3、开发板主动配对

除了被动配对，也可以在开发板终端发送主动配对的请求

```plain
[bluetooth]# scan on	                             //搜索可被发现蓝牙
Discovery started
[CHG] Controller 14:13:33:63:EF:72 Discovering: yes
[NEW] Device FC:E8:00:CF:42:E3 EDIFIER BLE
[NEW] Device 5C:50:51:B5:85:4B 5C-50-51-B5-85-4B
[CHG] Device FC:E8:00:CF:42:E3 RSSI: -92
[bluetooth]# scan off		                            //停止搜索
[bluetooth]# pair 2C:DB:07:C7:4F:F6                 //配对蓝牙
Attempting to pair with 2C:DB:07:C7:4F:F6
[CHG] Device 2C:DB:07:C7:4F:F6 Connected: yes
Request confirmation
[agent] Confirm passkey 745068 (yes/no): yes	      //口令确认
```

4、开发板接收文件

配对成功后，在PC端，可以使用蓝牙发送文件至OK3568-C中。

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954756310-3c1f25c1-0b75-43b3-806f-4fb6e0be3aac.png)

接收到的文件保存在/tmp目录。

5、开发板发送文件

同样，可以OK3588-C可以发送文件至手机端，测试方法如下：

6、OK3588-C 开发板发送文件至手机端，测试方法如下： 

```plain
root@ok3588-buildroot:/# fltest_obexctl.sh                      //开启obexctl
[NEW] Client /org/bluez/obex
[obex]# connect 2C:DB:07:C7:4F:F6	                   //连接需要通讯的蓝牙的MAC
Attempting to connect to 2C:DB:07:C7:4F:F6
[NEW] Session /org/bluez/obex/client/session1 [default]
[NEW] ObjectPush /org/bluez/obex/client/session1
Connection successful
[C4:E1:A1:BA:A4:9E]# send /userdata/media/audio/test.mp3	         //发送文件
```

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954756493-8837d97b-4be8-492e-a394-61d52b1812b1.png)

<font style="color:#000000;">手机将收到传入文件请求，点击接受，进行文件传输。</font> 

### 4.18  4G/5G
📚**说明：**

+ **使用物联网卡测试时，需确认模组固件版本，低版本固件不支持，需升级**EC05**固件**
+ **有些物联网卡拨号时需要设置专用账号和密码，用户需根据实际情况调整指令**
+ **可使用quectelCM --help指令查看相关参数含义**

OK3588支持4G模块EM05和5G RM500U RM500Q，开发板启动前接入4G/5G模块 ，并插入SIM卡，启动开发板。

1、连接好模块，开发板和模块上电后，可通过lsusb指令查看USB状态

```plain
root@ok3588-buildroot:/# lsusb
Bus 006 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 002 Device 003: ID 2c7c:0125	                                   //EC05的VID和PID
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```

/dev下查看设备节点状态

```plain
root@ok3588-buildroot:/# ls /dev/ttyUSB*
/dev/ttyUSB0  /dev/ttyUSB1  /dev/ttyUSB2  /dev/ttyUSB3
```

2、设备识别成功后，可进行拨号上网测试。fltest_quectel.sh会调用quectelCM，具体指令可查看/usr/bin/fltest_quectel.sh

```plain
root@ok3588-buildroot:/# fltest_quectel.sh &
```

打印信息如下：

```plain
[01-01_08:00:45:041] Quectel_QConnectManager_Linux_V1.6.0.24
[01-01_08:00:45:042] Find /sys/bus/usb/devices/2-1 idVendor=0x2c7c idProduct=0x125, bus=0x002, dev=0x002
[01-01_08:00:45:043] Auto find qmichannel = /dev/qcqmi0
[01-01_08:00:45:043] Auto find usbnet_adapter = usb0
[01-01_08:00:45:043] netcard driver = GobiNet, driver version = V1.6.2.14
[01-01_08:00:45:043] Modem works in QMI mode
[01-01_08:00:45:133] Get clientWDS = 7
[01-01_08:00:45:201] Get clientDMS = 8
[01-01_08:00:45:230] Get clientNAS = 9
[01-01_08:00:45:261] Get clientUIM = 10
[01-01_08:00:45:347] Get clientWDA = 11
[01-01_08:00:45:391] requestBaseBandVersion EM05CEFCR06A04M1G_ND
[01-01_08:00:45:663] requestGetSIMStatus SIMStatus: SIM_READY
[01-01_08:00:45:710] requestGetProfile[1] cmnet///1
[01-01_08:00:45:743] requestRegistrationState2 MCC: 460, MNC: 0, PS: Attached, DataCap: LTE
[01-01_08:00:45:804] requestQueryDataCall IPv4ConnectionStatus: DISCONNECTED
[01-01_08:00:45:851] ifconfig usb0 0.0.0.0
[01-01_08:00:45:859] ifconfig usb0 down
[01-01_08:00:45:934] requestSetupDataCall WdsConnectionIPv4Handle: 0x86d6ed00
[01-01_08:00:46:158] ifconfig usb0 up
[01-01_08:00:46:233] busybox udhcpc -f -n -q -t 5 -i usb0
udhcpc: started, v1.36.1
udhcpc: broadcasting discover
udhcpc: broadcasting select for 10.78.208.225, server 10.78.208.226
udhcpc: lease of 10.78.208.225 obtained from 10.78.208.226, lease time 7200
[01-01_08:00:50:588] deleting routers
[01-01_08:00:50:610] adding dns 111.11.1.3
[01-01_08:00:50:610] adding dns 111.11.11.3
```

3、测试前，查看相关配置

查看网关配置

```plain
root@ok3588-buildroot:/# route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         10.78.208.226   0.0.0.0         UG    0      0        0 usb0
10.78.208.224   *               255.255.255.252 U     0      0        0 usb0
```

查看DNS配置

```plain
root@ok3588-buildroot:/# cat /etc/resolv.conf
nameserver 111.11.1.3 # usb0
nameserver 111.11.11.3 # usb0
```

4、设置DNS 与路由之后，可ping 域名。

```plain
root@ok3588-buildroot:/# ping -I usb0 www.baidu.com -c 3         //指定usb0网卡ping3次
PING www.a.shifen.com (39.156.66.14) from 10.78.208.225 usb0: 56(84) bytes of data.
64 bytes from 39.156.66.14 (39.156.66.14): icmp_seq=1 ttl=50 time=39.9 ms
64 bytes from 39.156.66.14 (39.156.66.14): icmp_seq=2 ttl=50 time=88.0 ms
64 bytes from 39.156.66.14 (39.156.66.14): icmp_seq=3 ttl=50 time=105 ms

--- www.a.shifen.com ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2112ms
rtt min/avg/max/mdev = 39.938/77.690/105.133/27.596 ms
```

### 4.19  放/录音测试
<font style="color:#000000;">OK3588提供NAU88C22YG芯片1路标准3.5mm音频插座1个XH2.0-2P 白色插座 P25 引出和1个PH2.0-4P白色插座P48引出,可驱动8Ω 喇叭，最高输出功率为 1W，在进行放音测试前，请将准备好的耳机插入听筒接口，或将扬声器插入底板上的对应插槽上进行测试。</font>

3.2.19.1  HDMI 播放声音 

```plain
root@ok3588-buildroot:/# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: rockchipdp1 [rockchip,dp1], device 0: rockchip,dp1 spdif-hifi-0 [rockchip,dp1 spdif-hifi-0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: rockchipnau8822 [rockchip-nau8822], device 0: dailink-multicodecs nau8822-hifi-0 [dailink-multicodecs nau8822-hifi-0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 3: rockchiphdmi0 [rockchip-hdmi0], device 0: rockchip-hdmi0 i2s-hifi-0 [rockchip-hdmi0 i2s-hifi-0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
root@ok3588-buildroot:/# gst-play-1.0 /userdata/media/audio/test.mp3 --audiosink="alsasink device=plughw:3,0" 
```

3.2.19.2  SPKOUT 播放声音 

```plain
root@ok3588-buildroot:/# amixer -c rockchipnau8822                    //查询音频参数
root@ok3588-buildroot:/# amixer -c rockchipnau8822 sset "PCM" 255     //设置PCM参数
root@ok3588-buildroot:/# amixer -c rockchipnau8822 sset "Speaker" on   //打开Speaker
root@ok3588-buildroot:/# amixer -c rockchipnau8822 sset "Speaker" 63   //设置音量
root@ok3588-buildroot:/# gst-play-1.0 /userdata/media/test.mp3 --audiosink="alsasink device=plughw:2,0"
```

<font style="color:#000000;">将耳机插到SPKOUT接口即可在听到声音了。</font>

3.2.19.3  MIC输入  

```plain
root@ok3588-buildroot:/# arecord -l
**** List of CAPTURE Hardware Devices ****
card 1: rockchiphdmiin [rockchip,hdmiin], device 0: rockchip,hdmiin i2s-hifi-0 [rockchip,hdmiin i2s-hifi-0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: rockchipnau8822 [rockchip-nau8822], device 0: dailink-multicodecs nau8822-hifi-0 [dailink-multicodecs nau8822-hifi-0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
root@ok3588-buildroot:/# arecord -D hw:rockchipnau8822,0 -d 3 -f cd -t wav test1.wav
           //采集声音3秒，并保存为wav格式
root@ok3588-buildroot:/# aplay -D plughw:3,0 test1.wav   //使用HDMI播放采集声音
```

3.2.19.4  HDMI IN 音频测试

<font style="color:#000000;">将PC机HDMI线插入到HDMI RX接口，PC机播放声音，下面以回环方式进行测试 </font>

```plain
root@ok3588-buildroot:/# arecord -D plughw:1,0 -f cd -t wav test1.wav
root@ok3588-buildroot:/# aplay  -D plughw:3,0 -f cd test1.wav
root@ok3588-buildroot:/# arecord -D plughw:1,0 -f cd | aplay -D plughw:3,0 -f cd  //HDMI IN播放声音通过HDMI 输出
```

### 4.20  LCD 背光调节
背光的亮度设置范围为（0--255），255表示亮度最高，0表示关闭背光亮度。在mipi dsi0上接上mipi屏幕后，上电启动。进入系统后在终端输入如下命令进行背光测试。

1、查看支持背光型号

```plain
root@ok3588-buildroot:/# ls /sys/class/backlight
backlight-dsi0  backlight-dsi1  backlight-edp1 显示当前支持屏背光型号
```

下面以dsi0为例：

1、查看当前屏幕背光值：

```plain
root@ok3588-buildroot:/# cat /sys/class/backlight/backlight-dsi0/brightness
150                                           //当前背光值为200
```

2、背光熄灭：

```plain
root@ok3588-buildroot:/# echo 0 > /sys/class/backlight/backlight-dsi0/brightness
```

3、LCD背光亮起：

```plain
root@ok3588-buildroot:/# echo 125 > /sys/class/backlight/backlight-dsi0/brightness
```

### 4.21  睡眠唤醒测试
⁉️ **注意**：测试睡眠唤醒测试不能插着type-C 4G模块

<font style="color:#000000;">OK3588平台支持睡眠唤醒。</font>

<font style="color:#000000;">短按电源键，效果如下：</font>

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053229122-bddca433-d609-417d-84b7-cf763d497a7a.png)

在此短按电源键进行唤醒：

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053229217-203e3f36-d829-4657-ac35-88406ccf78da.png)

### 4.22  PCIE测试
OK3588-C板卡有1个PCIE2.0和1个PCIE 3.0 x4接口

系统上电前将PCIE模块插入底板PCIE卡槽。上电后启动后，通过lspci可以看到对应设备枚举成功。

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053229382-e2dcce17-6918-4c51-a1f4-b1e7695f28b7.png)

由于pcie设备类型较多，有可能默认不被内核支持需自行添加编译设备对应的驱动程序。

以TL-NT521万兆网卡举例，linux内核默认已经包含该驱动。插入网卡后上电启动可以看到枚举信息，并出现以太网接口：

```plain
root@ok3588-buildroot:/# ifconfig eth2
eth2      Link encap:Ethernet  HWaddr EC:60:73:50:EF:1C
          inet addr:192.168.1.16  Bcast:192.168.1.255  Mask:255.255.255.0
          inet6 addr: fe80::ee60:73ff:fe50:ef1c/64 Scope:Link
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:1095057 errors:0 dropped:0 overruns:0 frame:0
          TX packets:218610306 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:72299605 (68.9 MiB)  TX bytes:330733410858 (308.0 GiB)
```

将3588设置为performance模式：

```plain
root@ok3588-buildroot:/# echo performance  > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
root@ok3588-buildroot:/# echo performance  > /sys/devices/system/cpu/cpufreq/policy4/scaling_governor
root@ok3588-buildroot:/# echo performance  > /sys/devices/system/cpu/cpufreq/policy6/scaling_governor
```

<font style="color:#000000;">使用iperf3测试带宽</font>

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053229456-5022d76d-c31d-4613-bcae-c233420e48a1.png)

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053229538-37af1b03-9427-411a-b4c5-d3cf95b4e6a2.png)

### 4.23  RKNPU测试
<font style="color:#000000;">linux文件系统里已有rknpu2例子,下面以mobilenet_v1.rknn为例进行测试：</font>

```plain
root@ok3588-buildroot:/# /usr/bin/rknn_common_test /usr/share/model/RK3588/mobilenet_v1.rknn /usr/share/model/dog_224x224.jpg
rknn_api/rknnrt version: 2.0.0b0 (35a6907d79@2024-03-24T10:31:14), driver version: 0.9.6
model input num: 1, output num: 1
input tensors:
  index=0, name=input, n_dims=4, dims=[1, 224, 224, 3], n_elems=150528, size=150528, fmt=NHWC, type=INT8, qnt_type=AFFINE, zp=0, scale=0.007812
output tensors:
  index=0, name=MobilenetV1/Predictions/Reshape_1, n_dims=2, dims=[1, 1001, 0, 0], n_elems=1001, size=2002, fmt=UNDEFINED, type=FP16, qnt_type=AFFINE, zp=0, scale=1.000000
custom string:
Begin perf ...
   0: Elapse Time = 2.44ms, FPS = 409.67
---- Top5 ----
0.884766 - 156
0.054016 - 155
0.003677 - 205
0.002974 - 284
0.000189 - 285
```

### 4.24  SQLite3测试
SQLite3是一款轻型的数据库，是遵守ACID的关系型数据库管理系统，占用资源低。OK3588-C开发板移植的是3.21.0版本的sqlit3。

```plain
root@ok3588-buildroot:/# sqlite3
SQLite version 3.36.0 2021-06-18 18:36:39
Enter ".help" for usage hints.
Connected to a transient in-memory database.
Use ".open FILENAME" to reopen on a persistent database.
sqlite> create table tbl1 (one varchar(10), two smallint);//创建表tbl1
sqlite> insert into tbl1 values('hello!',10);//tbl1表内插入数据
sqlite> insert into tbl1 values('goodbye', 20);//tbl1表内插入数据goodbye|20
sqlite> select * from tbl1;//查询表tbl1中内容
hello!|10
goodbye|20
sqlite> delete from tbl1 where one = 'hello!';//删除数据
sqlite> select * from tbl1;//查询表tbl1中内容
goodbye|20
sqlite> .quit			                                //退出数据库（或使用.exit命令）
root@ok3588-buildroot:/#
```

### 4.25  GPIO测试
OK3588平台底板原理图中引出扩展IO引脚，位于底板P11。

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954759014-d61c0905-7a0e-46a2-81b5-ba7ccfc72c9c.png)

以GPIO_P17 PIN为例进行测试

```plain
root@ok3588-buildroot:/# cat /sys/kernel/debug/gpio  | grep i2c
gpiochip6: GPIOs 485-508, parent: i2c/2-0023, 2-0023, can sleep:	//识别到io扩展芯片
root@ok3588-buildroot:/# fltest_extgpio.sh GPIO_P17 1	//GPIO_P17 拉高 
root@ok3588-buildroot:/# fltest_extgpio.sh GPIO_P17 0	//GPIO_P17 拉低
```

⁉️ **注意**：fltest_extgpio.sh只能测试IO扩展芯片引脚， OK3588 soc GPIO引脚请使用fltest_gpio.sh脚本进行测试。

### 4.26  添加开机自启动脚本
临时添加自启动脚本

1、在/etc/init.d/目录创建一个自启动脚本

```plain
root@ok3588-buildroot:/# vi /etc/init.d/S99autorun.sh
```

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954759444-1c5fae4b-039e-4ab8-905b-ec7126d47786.png)

保存退出

2、添加执行权限

```plain
[root@ok3588:/]# chmod +x /etc/init.d/S99autorun.sh
```

3、重启板卡验证

在烧写镜像里添加开机自启动脚本：

将上面S99autorun.sh脚本拷贝到OK3588-linux-source源码包buildroot/board/forlinx/ok3588/fs-overlay/etc/init.d/目录下并添加执行权限

```plain
root@ok3588-buildroot:/# cp S99autorun.sh buildroot/board/forlinx/ok3588/fs-overlay/etc/init.d/
root@ok3588-buildroot:/# chmod +x buildroot/board/forlinx/ok3588/fs-overlay/etc/init.d/S99autorun.sh
```

重新编译打包并烧写镜像



# 05_OK3588平台多媒体测试

OK3588平台音视频部分应用层软件采用的是Gstreamer，支持硬件编解码。本节所有的示例均是基于Gstreamer命令行的形式。如果您需要带界面的播放器，您也可以使用qt的多媒体类，同样支持硬编解，可以参考Qt测试章节。

OK3588平台内部有一个视频处理单元VPU，支持以下格式的视频硬编解：

视频解码： H264, H265, VP8, VP9等，最大支持8K@60fps

视频编码： H264、H.265，最大支持8k@30fps

OK3588平台硬件编解码参数表：

| Video Decoder | Format | Profile | Resolution | Frame rate |
| --- | --- | --- | --- | --- |
|  | H.265 | main 10 | 7680x4320 | 60 fps |
|  | H.264 | main 10 | 7680x4320 | 30 fps |
|  | VP9 | Profile 0/2 | 7680x4320 | 60 fps |
|  | VP8 | version2 | 1920x1080 | 60 fps |
|  | VC1 |  | 1920x1080 | 60 fps |
|  | MPEG-2 |  | 1920x1080 | 60 fps |
|  | MPEG-1 |  | 1920x1080 | 60 fps |
|  | H.263 |  | 720x576 | 60 fps |
| Video Encoder | H.264 | BP/MP/HP@level4.2 | 7680x4320 | 30 fps |
|  | H.265 | MP@level4.1 | 7680x4320 | 30 fps |


## 5.1 音频和视频播放体验
### 5.1.1使用gst-play播放器播放视频和音频
Gplay 是基于 Gstreamer 实现的音视频播放器，能够自动根据硬件自动选择合适的插件进行音视频播放，运行也十分简单。

```plain
root@ok3588-buildroot:/# gst-play-1.0 /userdata/media/video/1080p_60fps_h265-30S.mp4
//播放带声音视频文件，由耳机放音测试
Press 'k' to see a list of keyboard shortcuts.
Now playing /userdata/media/1080p_60fps_h265-30S.mp4
Redistribute latency...
Redistribute latency...
Redistribute latency...
0:00:30.0 / 0:00:30.0
Reached end of play list.
```

### 5.1.2使用gst-launch 播放视频
```plain
root@ok3588-buildroot:/# gst-launch-1.0 filesrc location= /userdata/media/video/1080p_60fps_h265-30S.mp4 ! qtdemux ! queue ! h265parse ! mppvideodec ! waylandsink
//仅播放视频
Setting pipeline to PAUSED ...
Pipeline is PREROLLING ...
Pipeline is PREROLLED ...
Setting pipeline to PLAYING ...
Redistribute latency...
New clock: GstSystemClock
0:00:01.0 / 0:00:30.0 (3.6 %)
```

### 5.1.3使用gst-launch 播放音频
```plain
root@ok3588-buildroot:/# gst-launch-1.0 filesrc location=/userdata/media/audio/test.mp3 ! id3demux ! mpegaudioparse ! mpg123audiodec ! alsasink device=plughw:2,0
//仅播放音频，由耳机放音测试，使用HDMI播放声音去掉device=plughw:2,0
Setting pipeline to PAUSED ...
Pipeline is PREROLLING ...
Redistribute latency...
Pipeline is PREROLLED ...
Setting pipeline to PLAYING ...
New clock: GstAudioSinkClock
handling interrupt.
Interrupt: Stopping pipeline ...
Execution ended after 0:00:02.665159268
Setting pipeline to PAUSED ...
Setting pipeline to READY ...
Setting pipeline to NULL ...
Freeing pipeline ...
```

### 5.1.4使用gst-launch 播放视频和音频
```plain
root@ok3588-buildroot:/# gst-launch-1.0 filesrc location= /userdata/media/video/1080p_60fps_h265-30S.mp4 ! qtdemux name=dec dec. ! queue ! h265parse ! mppvideodec ! waylandsink dec. ! queue ! decodebin ! alsasink device=plughw:2,0
//播放带声音视频文件，由耳机放音测试
Setting pipeline to PAUSED ...
Pipeline is PREROLLING ...
Redistribute latency...
Redistribute latency...
Pipeline is PREROLLED ...
Setting pipeline to PLAYING ...
Redistribute latency...
New clock: GstAudioSinkClock
^Chandling interrupt. (2.6 %)
```



## 5.2 视频硬编码
OK3588最大支持8K@60fps/H.265和8K@60fps/H.264视频编码

### 5.2.1视频硬编码H.264
```plain
root@ok3588-buildroot:/# gst-launch-1.0 videotestsrc num-buffers=600 ! video/x-raw,framerate=30/1,width=7680,height=4320 ! mpph264enc ! h264parse ! mp4mux ! filesink location=test.mp4
Setting pipeline to PAUSED ...
Pipeline is PREROLLING ...
Pipeline is PREROLLED ...
Setting pipeline to PLAYING ...
Redistribute latency...
New clock: GstSystemClock
0:00:18.2 / 0:00:20.0 (91.0 %)
```

### 5.2.2视频硬编码H.265
```plain
root@ok3588-buildroot:/# gst-launch-1.0 videotestsrc num-buffers=600 ! video/x-raw,framerate=30/1,width=7680,height=4320 ! mpph265enc ! h265parse ! mp4mux ! filesink location=test.mp4
Setting pipeline to PAUSED ...
Pipeline is PREROLLING ...
Redistribute latency...
Pipeline is PREROLLED ...
Prerolled, waiting for async message to finish...
Setting pipeline to PLAYING ...
Redistribute latency...
New clock: GstSystemClock
0:00:05.0 / 0:00:20.0 (25.2 %)
```

### 5.2.3 JPEG硬编码
```plain
root@ok3588-buildroot:/# gst-launch-1.0 videotestsrc num-buffers=1 ! video/x-raw,framerate=1/1,width=7680,height=4320 ! mppjpegenc ! jpegparse ! queue ! filesink location=test.jpeg
Setting pipeline to PAUSED ...
Pipeline is PREROLLING ...
Pipeline is PREROLLED ...
Prerolled, waiting for async message to finish...
Setting pipeline to PLAYING ...
Redistribute latency...
New clock: GstSystemClock
Got EOS from element "pipeline0".
Execution ended after 0:00:00.029266878
Setting pipeline to NULL ...
Freeing pipeline ...
```

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954764988-9058f57e-457d-4602-8cae-e89b29192d03.png)



## 5.3 视频硬解码
OK3588支持 H264，H265、VP8、VP9视频硬解码，H264解码器支持8K@30fps，H265解码器支持8K@60fps。

OK3588使用mppvideodec组件进行视频硬解码，它的输出格式为：NV12，I420，YV12。

### 5.3.1解码并播放H264格式视频
```plain
root@ok3588-buildroot:/# gst-launch-1.0 filesrc location=/userdata/media/video/1080p_60fps_h264-30S.mp4 ! qtdemux ! h264parse ! mppvideodec ! waylandsink
Setting pipeline to PAUSED ...
Pipeline is PREROLLING ...
Redistribute latency...
Redistribute latency...
Pipeline is PREROLLED ...
Prerolled, waiting for async message to finish...
Setting pipeline to PLAYING ...
Redistribute latency...
New clock: GstSystemClock
0:00:05.9 / 0:00:30.0 (19.8 %)
```

### 5.3.2解码并播放H264格式视频带音频
```plain
root@ok3588-buildroot:/# gst-launch-1.0 filesrc location=/userdata/media/video/1080p_60fps_h264-30S.mp4 ! qtdemux name=demux demux.video_0 ! queue ! h264parse ! mppvideodec ! waylandsink demux.audio_0 ! queue ! aacparse ! faad ! alsasink
Setting pipeline to PAUSED ...
Pipeline is PREROLLING ...
Redistribute latency...
Redistribute latency...
Redistribute latency...
Redistribute latency...
Pipeline is PREROLLED ...
Prerolled, waiting for async message to finish...
Setting pipeline to PLAYING ...
Redistribute latency...
New clock: GstAudioSinkClock
0:00:04.5 / 0:00:30.0 (15.0 %)
```

### 5.3.3解码并播放H265格式视频
```plain
root@ok3588-buildroot:/# gst-launch-1.0 filesrc location=/userdata/media/video/4k_60fps_h265-30S.mp4 ! qtdemux ! h265parse ! mppvideodec ! waylandsink
Setting pipeline to PAUSED ...
Pipeline is PREROLLING ...
Redistribute latency...
Redistribute latency...
Pipeline is PREROLLED ...
Prerolled, waiting for async message to finish...
Setting pipeline to PLAYING ...
Redistribute latency...
New clock: GstSystemClock
0:00:06.4 / 0:00:30.0 (21.4 %)
```

### 5.3.4解码并播放H265格式视频带音频
```plain
root@ok3588-buildroot:/# gst-launch-1.0 filesrc location=/userdata/media/video/4k_60fps_h265-30S.mp4 ! qtdemux name=demux demux.video_0 ! queue ! h265parse ! mppvideodec ! waylandsink demux.audio_0 ! queue ! aacparse ! faad ! alsasink
Setting pipeline to PAUSED ...
Pipeline is PREROLLING ...
Redistribute latency...
Redistribute latency...
Redistribute latency...
Redistribute latency...
Pipeline is PREROLLED ...
Prerolled, waiting for async message to finish...
Setting pipeline to PLAYING ...
Redistribute latency...
New clock: GstAudioSinkClock
0:00:03.4 / 0:00:30.0 (11.3 %)
```

### 5.3.5解码并播放VP9格式视频
```plain
root@ok3588-buildroot:/# gst-launch-1.0 filesrc location=/userdata/media/video/1080p_60fps_vp9-30S.mp4 ! qtdemux ! vp9parse ! mppvideodec ! waylandsink
Setting pipeline to PAUSED ...
Pipeline is PREROLLING ...
Pipeline is PREROLLED ...
Prerolled, waiting for async message to finish...
Setting pipeline to PLAYING ...
Redistribute latency...
New clock: GstSystemClock
0:00:02.5 / 0:00:30.0 (8.7 %)
```

### 5.3.6解码并播放VP9格式视频带音频
```plain
root@ok3588-buildroot:/# gst-launch-1.0 filesrc location=/userdata/media/video/1080p_60fps_vp9-30S.mp4 ! qtdemux name=demux demux.video_0 ! queue ! vp9parse ! mppvideodec ! waylandsink demux.audio_0 ! queue ! aacparse ! faad ! alsasink device=plughw:2,0
Setting pipeline to PAUSED ...
Pipeline is PREROLLING ...
Redistribute latency...
Redistribute latency...
Pipeline is PREROLLED ...
Prerolled, waiting for async message to finish...
Setting pipeline to PLAYING ...
Redistribute latency...
New clock: GstAudioSinkClock
0:00:03.2 / 0:00:30.0 (10.7 %)
```

### 5.3.7解码并播放VP8格式视频
```plain
root@ok3588-buildroot:/# gst-launch-1.0 filesrc location=/userdata/media/video/1080p_30fps_vp8.mp4 ! matroskademux ! queue ! mppvideodec ! waylandsink
Setting pipeline to PAUSED ...
Pipeline is PREROLLING ...
Pipeline is PREROLLED ...
Prerolled, waiting for async message to finish...
Setting pipeline to PLAYING ...
Redistribute latency...
New clock: GstSystemClock
0:00:09.2 / 0:00:30.1 (30.7 %)
```

### 5.3.8解码并播放VP8格式视频带音频
```plain
root@ok3588-buildroot:/# gst-launch-1.0 filesrc location=/userdata/media/video/1080p_30fps_vp8.mp4 typefind=true ! video/webm ! matroskademux name=dec dec. ! queue ! mppvideodec ! waylandsink dec. ! queue ! decodebin ! audioconvert ! audioresample ! alsasink device=plughw:2,0
Setting pipeline to PAUSED ...
Pipeline is PREROLLING ...
Redistribute latency...
Redistribute latency...
Pipeline is PREROLLED ...
Prerolled, waiting for async message to finish...
Setting pipeline to PLAYING ...
Redistribute latency...
New clock: GstAudioSinkClock
0:00:02.4 / 0:00:30.1 (8.3 %)
```

## 5.4 摄像头测试
OK3588支持OV13850 MIPI摄像头，同时也支持UVC摄像头。首先来测试一下UVC摄像头，这里以罗技C270进程测试，将USB摄像头插入开发板，将自动安装uvc驱动。

### 5.4.1 UVC Camera测试
#### **5.4.1.1摄像头识别检测和格式支持查询**
摄像头识别检测

```plain
root@ok3588-buildroot:/# v4l2-ctl --list-devices  //查看设备结点，可见/dev/video9&10为USB摄像头结点
rk_hdmirx (fdee0000.hdmirx-controller):
        /dev/video73

rkisp-statistics (platform: rkisp):
        /dev/video62
        /dev/video63
        /dev/video71
        /dev/video72

rkcif-mipi-lvds (platform:rkcif):
        /dev/media0
        /dev/media1
        /dev/media2
        /dev/media3
        /dev/media4

rkcif (platform:rkcif-mipi-lvds1):
        /dev/video11
        /dev/video12
        /dev/video13
        /dev/video14
        /dev/video15
        /dev/video16
        /dev/video17
        /dev/video18
        /dev/video19
        /dev/video20
        /dev/video21

rkisp_mainpath (platform:rkisp0-vir0):
        /dev/video55
        /dev/video56
        /dev/video57
        /dev/video58
        /dev/video59
        /dev/video60
        /dev/video61
        /dev/media5

rkisp_mainpath (platform:rkisp0-vir1):
        /dev/video64
        /dev/video65
        /dev/video66
        /dev/video67
        /dev/video68
        /dev/video69
        /dev/video70
        /dev/media6

Rmoncam HD 720P: Rmoncam HD 720 (usb-fc800000.usb-1):
        /dev/video74
        /dev/video75
        /dev/media7

Failed to open /dev/video0: No such device
```



格式支持查询

```plain
root@ok3588-buildroot:/# v4l2-ctl --list-formats-ext -d /dev/video74 //查看摄像头支持的格式
ioctl: VIDIOC_ENUM_FMT
        Type: Video Capture

        [0]: 'MJPG' (Motion-JPEG, compressed)
                Size: Discrete 1280x720
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 160x120
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 320x240
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 352x288
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 640x480
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 800x600
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 848x480
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 960x540
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 1024x768
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 1280x800
                        Interval: Discrete 0.033s (30.000 fps)
        [1]: 'YUYV' (YUYV 4:2:2)
                Size: Discrete 1280x720
                        Interval: Discrete 0.100s (10.000 fps)
                Size: Discrete 640x480
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 800x600
                        Interval: Discrete 0.050s (20.000 fps)
                Size: Discrete 848x480
                        Interval: Discrete 0.050s (20.000 fps)
                Size: Discrete 960x540
                        Interval: Discrete 0.050s (20.000 fps)
                Size: Discrete 1024x768
                        Interval: Discrete 0.100s (10.000 fps)
                Size: Discrete 1280x800
                        Interval: Discrete 0.100s (10.000 fps)
```

#### **5.4.1.2摄像头采集格式查询和修改**
摄像头采集格式查询

```plain
root@ok3588-buildroot:/# v4l2-ctl -V -d /dev/video74
Format Video Capture:
        Width/Height      : 1280/720
        Pixel Format      : 'MJPG' (Motion-JPEG)
        Field             : None
        Bytes per Line    : 0
        Size Image        : 1843200
        Colorspace        : sRGB
        Transfer Function : Rec. 709
        YCbCr/HSV Encoding: ITU-R 601
        Quantization      : Default (maps to Full Range)
        Flags             :
```

#### **5.4.1.3摄像头图像预览和拍照**
摄像头图像预览

```plain
root@ok3588-buildroot:/# gst-launch-1.0  v4l2src device=/dev/video74 ! videoconvert ! video/x-raw,format=NV12,width=640,height=480  ! waylandsink
Setting pipeline to PAUSED ...
Pipeline is live and does not need PREROLL ...
Pipeline is PREROLLED ...
Setting pipeline to PLAYING ...
New clock: GstSystemClock
Redistribute latency...
0:00:19.7 / 99:99:99.
```

摄像头拍照

```plain
root@ok3588-buildroot:/# gst-launch-1.0 v4l2src device=/dev/video74 num-buffers=1 ! videoconvert ! video/x-raw,format=NV12,width=640,height=480 ! mppjpegenc ! filesink location=pic.jpg
Setting pipeline to PAUSED ...
Pipeline is live and does not need PREROLL ...
Pipeline is PREROLLED ...
Setting pipeline to PLAYING ...
New clock: GstSystemClock
Redistribute latency...
Got EOS from element "pipeline0".
Execution ended after 0:00:00.310412782
Setting pipeline to NULL ...
Freeing pipeline ...
//执行完成后查看根目录下生成的pic.jpg文件即可
```

//执行完成后查看根目录下生成的pic.jpg文件即可



### 5.4.2 OV13855 测试
对于OV13855 等raw sensor，每一个sensor对应5个设备节点：

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053231280-b47026e0-5fef-4e49-baeb-ba9070a676ee.png)

Mainpath,指 Rockchip ISP的一个输出节点，可输出全分辨率图像，一般用来拍照，抓取 Raw 图。

Self Path,指 Rockchip ISP的一个输出节点，最高只能输出1080p分辨率，一般用作预览。

Statistics 3A 统计

Input-params 3A 参数设置

OV13855 的测试方法与UVC Camera的测试方法基本相同。本节测试以OV13855为例，

CAM1：platform:rkisp0-vir0

CAM2：platform:rkisp0-vir1

#### **5.4.2.1摄像头识别检测和格式支持查询**
```plain
root@ok3588-buildroot:/# v4l2-ctl --list-devices
rk_hdmirx (fdee0000.hdmirx-controller):
        /dev/video73

rkisp-statistics (platform: rkisp):
        /dev/video62
        /dev/video63
        /dev/video71
        /dev/video72

rkcif-mipi-lvds (platform:rkcif):
        /dev/media0
        /dev/media1
        /dev/media2
        /dev/media3
        /dev/media4

rkcif (platform:rkcif-mipi-lvds1):
        /dev/video11
        /dev/video12
        /dev/video13
        /dev/video14
        /dev/video15
        /dev/video16
        /dev/video17
        /dev/video18
        /dev/video19
        /dev/video20
        /dev/video21

rkisp_mainpath (platform:rkisp0-vir0):
        /dev/video55
        /dev/video56
        /dev/video57
        /dev/video58
        /dev/video59
        /dev/video60
        /dev/video61
        /dev/media5

rkisp_mainpath (platform:rkisp0-vir1):
        /dev/video64
        /dev/video65
        /dev/video66
        /dev/video67
        /dev/video68
        /dev/video69
        /dev/video70
        /dev/media6

Failed to open /dev/video0: No such device
```

#### **5.4.2.2摄像头预览**
```plain
root@ok3588-buildroot:/# gst-launch-1.0 v4l2src device=/dev/video55 ! videoconvert ! video/x-raw,format=NV12,width=1920,height=1080 ! autovideosink sync=false
Setting pipeline to PAUSED ...
Using mplane plugin for capture
Pipeline is live and does not need PREROLL ...
Pipeline is PREROLLED ...
Setting pipeline to PLAYING ...
New clock: GstSystemClock
Redistribute latency...
0:00:06.9 / 99:99:99.
```

#### **5.4.2.3摄像头拍照**
```plain
//摄像头拍照（前置）
root@ok3588-buildroot:/# gst-launch-1.0 v4l2src device=/dev/video64 num-buffers=1 ! video/x-raw,format=NV12,width=640,height=480 ! mppjpegenc ! filesink location=pic.jpg
Setting pipeline to PAUSED ...
Using mplane plugin for capture
Pipeline is live and does not need PREROLL ...
Pipeline is PREROLLED ...
Setting pipeline to PLAYING ...
New clock: GstSystemClock
Redistribute latency...
Got EOS from element "pipeline0".
Execution ended after 0:00:00.267194152
Setting pipeline to NULL ...
Freeing pipeline ...
//查看是否生成pic.jpg，可拷贝到pc查看
```

#### **5.4.2.4录制H264格式视频**
```plain
//摄像头预览时编码H264
root@ok3588-buildroot:/#  gst-launch-1.0 v4l2src device=/dev/video64 num-buffers=100 ! video/x-raw,format=NV12, width=640,height=480 ! tee name=t ! queue ! mpph264enc ! queue ! h264parse ! qtmux ! filesink location=13855_h264.mp4 t. ! queue ! waylandsink
Setting pipeline to PAUSED ...
Using mplane plugin for capture
Pipeline is live and does not need PREROLL ...
Pipeline is PREROLLED ...
Setting pipeline to PLAYING ...
New clock: GstSystemClock
Redistribute latency...
Redistribute latency...
Redistribute latency...
WARNING: from element /GstPipeline:pipeline0/GstWaylandSink:waylandsink0: A lot of buffers are being dropped.
Additional debug info:
../libs/gst/base/gstbasesink.c(3143): gst_base_sink_is_too_late (): /GstPipeline:pipeline0/GstWaylandSink:waylandsink0:
There may be a timestamping problem, or this computer is too slow.
WARNING: from element /GstPipeline:pipeline0/GstWaylandSink:waylandsink0: A lot of buffers are being dropped.
Additional debug info:
../libs/gst/base/gstbasesink.c(3143): gst_base_sink_is_too_late (): /GstPipeline:pipeline0/GstWaylandSink:waylandsink0:
There may be a timestamping problem, or this computer is too slow.
WARNING: from element /GstPipeline:pipeline0/GstWaylandSink:waylandsink0: A lot of buffers are being dropped.
Additional debug info:
../libs/gst/base/gstbasesink.c(3143): gst_base_sink_is_too_late (): /GstPipeline:pipeline0/GstWaylandSink:waylandsink0:
There may be a timestamping problem, or this computer is too slow.
WARNING: from element /GstPipeline:pipeline0/GstWaylandSink:waylandsink0: A lot of buffers are being dropped.
Additional debug info:
../libs/gst/base/gstbasesink.c(3143): gst_base_sink_is_too_late (): /GstPipeline:pipeline0/GstWaylandSink:waylandsink0:
There may be a timestamping problem, or this computer is too slow.
WARNING: from element /GstPipeline:pipeline0/GstWaylandSink:waylandsink0: A lot of buffers are being dropped.
Additional debug info:
../libs/gst/base/gstbasesink.c(3143): gst_base_sink_is_too_late (): /GstPipeline:pipeline0/GstWaylandSink:waylandsink0:
There may be a timestamping problem, or this computer is too slow.
WARNING: from element /GstPipeline:pipeline0/GstWaylandSink:waylandsink0: A lot of buffers are being dropped.
Additional debug info:
../libs/gst/base/gstbasesink.c(3143): gst_base_sink_is_too_late (): /GstPipeline:pipeline0/GstWaylandSink:waylandsink0:
There may be a timestamping problem, or this computer is too slow.
Got EOS from element "pipeline0".
Execution ended after 0:00:06.843200646
Setting pipeline to NULL ...
Freeing pipeline ...
root@ok3588-buildroot:/# ls
//查看是否生成H264文件
```

#### **5.4.2.5播放H264格式视频**
```plain
root@ok3588-buildroot:/# gst-launch-1.0 filesrc location=13855_h264.mp4 ! qtdemux ! queue ! h264parse ! mppvideodec ! waylandsink
Setting pipeline to PAUSED ...
Pipeline is PREROLLING ...
Redistribute latency...
Redistribute latency...
Pipeline is PREROLLED ...
Prerolled, waiting for async message to finish...
Setting pipeline to PLAYING ...
Redistribute latency...
New clock: GstSystemClock
Got EOS from element "pipeline0".
Execution ended after 0:00:06.619988206
Setting pipeline to NULL ...
Freeing pipeline ...
```

### 5.4.3 OV5645 测试
**摄像头对应节点**

**CAM3 ：rkcif-mipi-lvds2**

**CAM4 ：rkcif-mipi-lvds4**

**CAM5 ：rkcif-mipi-lvds5**

**以测试CAM5为例**

#### **5.4.3.1、摄像头识别检测**
```plain
root@ok3588-buildroot:/#  v4l2-ctl --list-devices
//查看设备节点
rkcif (platform:rkcif-mipi-lvds2):
        /dev/video22
        /dev/video23
        /dev/video24
        /dev/video25
        /dev/video26
        /dev/video27
        /dev/video28
        /dev/video29
        /dev/video30
        /dev/video31
        /dev/video32
```

#### **5.4.3.2、查看支持格式**
```plain
root@ok3588-buildroot:/#  v4l2-ctl --list-formats-ext -d /dev/video22
ioctl: VIDIOC_ENUM_FMT
        Type: Video Capture Multiplanar

        [0]: 'NV16' (Y/CbCr 4:2:2)
                Size: Stepwise 64x64 - 1920x1080 with step 8/8
        [1]: 'NV61' (Y/CrCb 4:2:2)
                Size: Stepwise 64x64 - 1920x1080 with step 8/8
        [2]: 'NV12' (Y/CbCr 4:2:0)
                Size: Stepwise 64x64 - 1920x1080 with step 8/8
        [3]: 'NV21' (Y/CrCb 4:2:0)
                Size: Stepwise 64x64 - 1920x1080 with step 8/8
        [4]: 'YUYV' (YUYV 4:2:2)
                Size: Stepwise 64x64 - 1920x1080 with step 8/8
        [5]: 'YVYU' (YVYU 4:2:2)
                Size: Stepwise 64x64 - 1920x1080 with step 8/8
        [6]: 'UYVY' (UYVY 4:2:2)
                Size: Stepwise 64x64 - 1920x1080 with step 8/8
        [7]: 'VYUY' (VYUY 4:2:2)
                Size: Stepwise 64x64 - 1920x1080 with step 8/8
```

#### **5.4.3.3、摄像头预览**
```plain
root@ok3588-buildroot:/#  gst-launch-1.0 v4l2src device=/dev/video22 ! video/x-raw, format=NV12, width=1920,height=1080, framerate=30/1 ! waylandsink		
Setting pipeline to PAUSED ...
Using mplane plugin for capture
Pipeline is live and does not need PREROLL ...
Pipeline is PREROLLED ...
Setting pipeline to PLAYING ...
New clock: GstSystemClock
Redistribute latency...
0:00:32.4 / 99:99:99.
```



### 5.4.4 HDMI IN 测试
#### 5.4.4.1 HDMIIN 格式支持查询
摄像头识别检测

```plain
root@ok3588-buildroot:/# v4l2-ctl --list-devices    // 可见/dev/video73为HDMI IN结点
rk_hdmirx (fdee0000.hdmirx-controller):
        /dev/video73

rkisp-statistics (platform: rkisp):
        /dev/video62
        /dev/video63
        /dev/video71
        /dev/video72

rkcif-mipi-lvds (platform:rkcif):
        /dev/media0
        /dev/media1
        /dev/media2
        /dev/media3
        /dev/media4
```

格式支持查询

```plain
root@ok3588-buildroot:/# v4l2-ctl --list-formats-ext -d /dev/video73//查看HDMI RX支持的格式
ioctl: VIDIOC_ENUM_FMT
        Type: Video Capture Multiplanar

        [0]: 'BGR3' (24-bit BGR 8-8-8)
        [1]: 'NV24' (Y/CbCr 4:4:4)
        [2]: 'NV16' (Y/CbCr 4:2:2)
        [3]: 'NV12' (Y/CbCr 4:2:0)
```



#### 5.4.4.2摄像头采集格式查询和修改
摄像头采集格式查询

```plain
root@ok3588-buildroot:/# v4l2-ctl -V -d /dev/video73
Format Video Capture Multiplanar:
        Width/Height      : 1920/1080
        Pixel Format      : 'BGR3' (24-bit BGR 8-8-8)
        Field             : None
        Number of planes  : 1
        Flags             : premultiplied-alpha, set-csc, 0x000000fc
        Colorspace        : sRGB
        Transfer Function : Default
        YCbCr/HSV Encoding: Unknown (0x000000ff)
        Quantization      : Limited Range
        Plane 0           :
           Bytes per Line : 5760
           Size Image     : 6220800
```

#### 5.4.4.3摄像头图像预览
```plain
root@ok3588-buildroot:/# gst-launch-1.0  v4l2src device=/dev/video73 ! videoconvert ! kmssink
Setting pipeline to PAUSED ...
Using mplane plugin for capture
Pipeline is live and does not need PREROLL ...
Pipeline is PREROLLED ...
Setting pipeline to PLAYING ...
New clock: GstSystemClock
Redistribute latency...
0:00:22.1 / 99:99:99.
```

⁉️ 注意：当前版本请不要使用waylandsink显示，使用gst-launch-1.0 编码会卡顿。



# 06_烧写系统

OK3588-C开发板目前支持OTG和TF卡两种烧写方式。在用户资料中提供了相应的烧写工具，用户可选择任意一种方式进行镜像烧写。

## 6.1 OTG烧写系统
### 6.1.1 OTG驱动安装
🛤️ <font style="color:#000000;">路径：OK3588-C（Linux）用户资料\Linux\工具</font>DriverAssitant_v5.11.zip</font>

将上述路径文件解压到任意目录，以管理员权限运行

打开DriverInstall.exe 程序。

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954770958-7280a596-73c8-4d3b-8dd9-1b700589b2ee.png)

点击“驱动安装”。

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954771127-ac31e017-7d41-4796-982f-a0df857b0b02.png)

### 6.1.2 OTG完全烧写测试
#### **6.1.2.1 RKDevTool烧写测试**
🛤️ <font style="color:#000000;">路径：OK3588-C（Linux）用户资料\Linux\工具</font>RKDevTool_Release_v2.84.zip</font>

这是瑞芯微提供的一款开发工具，使用前将其解压到全英文路径下，用Type-C线连接开发板TYPE-C0口和主机，按住开发板的recovery键不要松开，然后按一下reset键系统复位，大约两秒后松开recovery键。瑞芯微开发工具上将提示发现loader设备。

⁉️ 注意：识别设备的操作是开发板上电时recover按键是按下的状态。

⁉️ 注意：理论上瑞芯微开发工具解压目录随意，但有用户反馈瑞芯微开发工具解压目录需为全英文，若打开开发工具后与下图不一致，请考虑解压其在全英文目录下。

打开瑞芯微开发工具：

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954771331-3c66878d-d73a-47c8-865f-9a4eb5f49209.png)

点击“升级固件”选项卡，点击“固件”按钮选择完整的升级镜像update.img。程序将对固件进行解析，因此需要等待一会。

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954771591-5d774abb-6e41-40e1-8d0d-73340b5643f8.png)

点击“切换“等待一会进入LOADER设备，点击“擦除Flash”进行擦除操作。然后点击“升级”按钮进行升级。

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954771969-5ba39de6-62b5-4379-9452-3f3739805ae4.png)

**MASKROM模式介绍**

<font style="color:#000000;">如果loader损坏无法进入Loader模式时，可以按住底板上maskrom键（底板RTC电池座右边）然后按复位键进入maskrom模式进行烧写。</font>

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954772220-bc93846b-eb6c-4c2b-b2e1-38ddd588d30d.png)

此时系统将提示发现一个maskrom设备，烧写流程与loader模式一致，最好使用update.img烧写。

⁉️ 注意：maskrom模式下不要点击“设备分区表”，为无效操作。

⁉️ 注意：maskrom模式下单独烧写不会清除UBOOT环境变量。

**下载单独镜像功能介绍**

此功能适用于需要下载单独镜像的时候。该功能只能在loader烧写模式下适用。

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954342599-b1262b6f-1982-49ad-a6f5-fddbcd9c3a23.png)

1. 点击①下载镜像选项卡
2. 点击②设备分区表读取镜像分区位置
3. 点击③复选框选择需要单独烧录的镜像
4. 点击④这里选择镜像
5. 点击⑤执行进行烧写
6. 烧写完成重启即可

#### **6.1.2.2 FactoryTool烧写测试**
FactoryTool是工厂批量OTG烧写时使用到的工具，其不需要读取镜像，可以批量烧写，另外其可烧写某些较大的镜像文件，若RKDevTool兼容性不满足时，亦可尝试该方式，使用前将其解压到全英文路径下，用Type-C线连接开发板和主机，按住开发板的recover键不要松开，然后按一下reset键系统复位，大约两秒后松开recover键。瑞芯微开发工具上将提示发现loader设备。

⁉️ 注意：识别设备的操作是开发板上电时recover按键是按下的状态。

⁉️ 注意：理论上解压目录随意，但有用户反馈瑞芯微开发工具解压目录需为全英文，若打开开发工具后与下图不一致，请考虑解压其在全英文目录下。

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954772473-26bee7ca-3b03-43c8-92e1-d2c4ff28924f.png)

点击选择固件，点击启动，此时识别到loader设备将自动开始烧写。

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954772819-25bc8c6e-5cb3-4e8c-9dad-94a807f63371.png)

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954773204-75771ece-ead6-47b3-8eba-234d2c216f69.png)

## 6.2  TF卡烧写系统
烧写TF卡制作与烧写测试

⁉️ 注意：测试TF卡容量最大为32G，使用32G以上TF卡可能会烧写失败。

将用户资料工具目录的SDDiskTool_v1.69.zip拷贝到windows任意目录。以管理员权限运行SD_Firmware_Tool.exe。

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954773532-d168a0e4-cdcd-4da0-bca8-404343bc90d8.png)

选择磁盘设备，勾选“固件升级”，并选择update.img。点击开始创建。

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954773716-99d4dd8c-0a74-47ce-afde-dc7bef62ad5e.png)

![](https://cdn.nlark.com/yuque/0/2024/png/45535139/1718954773901-c73f5df7-46e8-4a58-b766-073778b22e1c.png)

将TF卡插入开发板并启动，系统将自动进入烧写流程。烧写完成后屏幕和串口都将提示：

Please remove SD CARD!!!, wait for reboot.

此时，拔出TF卡，系统自动重新启动(请勿直接断电)。

批量生产时，可以根据核心板的心跳灯来判断烧写是否完成，烧写过程中的心跳灯变化如下：

1. 内核启动阶段：心跳灯模式，规律的间歇性闪烁。
2. 烧写准备阶段：EMMC指示灯，熄灭。
3. 烧写进行阶段：EMMC指示灯，常亮。
4. 烧写完成阶段：心跳灯模式，规律的间歇性闪烁。

烧写状态串口信息：

![](https://cdn.nlark.com/yuque/0/2024/png/49874024/1731053233110-9ea4d541-929c-4ed9-af30-ca082a9f0b70.png)

若移除TF未自动重启，手动重启也可完成烧写。烧写过程中请耐心等待。



