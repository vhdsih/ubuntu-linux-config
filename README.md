# ubuntu自动配置脚本

脚本**旨在减轻重装ubuntu系统后的配置压力**。在重装系统后可以运行这个脚本实现常用软件、主题、图标、字体、vim、zsh的配置，用户只需要在运行过程中输入确认信息即可。另及，用户可以在程序中自动添加或删除需要的东西。

测试系统：ubuntu 16.04

### 运行

```shell
git clone git@github.com:dongchangzhang/ubuntu-linux-config.git;
cd ubuntu-linux-config;
chmod 755 setup.sh
./setup.sh -你需要的参数(0,1...)
```
提示：运行之前请查看帮助