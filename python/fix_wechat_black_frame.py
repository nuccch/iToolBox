# -*- coding：utf-8 -*-

import wmctrl
from subprocess import getoutput


class MyWindow(wmctrl.Window):
    def close(self):
        """
        关闭窗口
        :param win:
        :return:
        """
        cmd = 'xdotool windowunmap {0}'.format(self.id)
        getoutput(cmd)


def closeWechatBlackFrame():
    """
    关闭微信小黑框
    :return:
    """
    for win in MyWindow.by_class('wechat.exe.Wine'):
        if win.wm_name == "" or win.wm_name == "ChatContactMenu":
            # print(win)
            win.close()


if __name__ == "__main__":
    closeWechatBlackFrame()

# 预先安装
# 1.python3
# 2.sudo apt-get install wmctrl xdotool
# 3.pip install wmctrl-python3
