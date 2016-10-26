# ubuntu自动配置脚本
 dongchangzhang 

create@2016.10.17

### 前言

写这个脚本**旨在减轻重装ubuntu系统后的配置压力**。在重装系统后可以运行这个脚本实现常用软件、主题、图标、字体、vim、zsh的配置，用户只需要在运行过程中输入确认信息即可。另，用户可以在程序中自动添加或删除需要的东西。

测试系统：ubuntu 16.04

### 结构

```
ubuntu-config
├── config  # 进行zsh、vim等配置
│   ├── config.sh
│   ├── my_zshrc
│   └── spf13-vim.sh
├── fonts # 进行字体配置
│   └── fonts.sh
├── installthings # 对软件、主题、图标进行安装
│   └── install.sh
├── log # 输出运行的日志 查看安装情况
│   └── run_log.txt
├── pics # github上显示的图片
│   ├── all.png
│   ├── fonts.png
│   ├── justopen.png
│   ├── none.png
│   ├── themes.png
│   └── UnityTweak.png
├── ppa # 用于添加ppa
│   ├── ppa_auto.sh
│   └── ppa.sh
├── README.md
├── resource # 资源文件，一个主题、两个字体
│   ├── Monaco
│   └── MyTheme
└── run.sh # 综合执行所有的配置脚本

```



### 运行

```shell
git clone git@github.com:dongchangzhang/ubuntu-config.git;
cd ubuntu-config;
chmod 755 run.sh
sudo ./run.sh
```

### 软件

* tree       # 查看目录结构
* ranger #终端文件管理
* git        # 这个。。。
* htop    # 任务管理
* vim     # 不用说了
* tlp    # 电源管理
* zsh    # 强大的命令解释工具
* autojump # zsh下的一个插件
* tmux # 强大的终端多窗口等
* guake # 下拉终端
* gitg # 可视化查看git历史
* vlc # 视频播放器
* unity-tweak-tool # unity配置管理
* shutter # 截图
* indicator-keylock # 大小写指示器
* classicmenu-indicator # 经典应用选择指示器
* albert # 快速搜索工具
* typora # 好用的markdown工具
* calibre # 电子书阅读
* okular # pdf阅读
* wiznote # 全平台笔记客户端
* catfish # 文件搜索
* python-pip # python2.7
* python3-pip # python3
* rar
* unrar

### 图标

* papirus-gtk-icon-theme #最好看的图标，可以搜索这个图标的github

### 主题

* MyTheme # 该主题基于numix


### 字体

* Monaco_YaHei #最好看的中英文字体，适合码代码

* Monaco

### 其它

* ZSH

  使用oh-my-zsh配置，并且包含一份可以命令高亮的.zshrc

* VIM

  使用spf13-vim配置vim



