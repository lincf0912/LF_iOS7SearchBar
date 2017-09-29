# LF_iOS7SearchBar

* 自定义搜索栏，模仿iOS7的搜索栏（UITextField+UIView）

## Installation 安装

* CocoaPods：pod 'LF_iOS7SearchBar'
* 手动导入：将LF_iOS7SearchBar\class文件夹拽入项目中，导入头文件：#import "LF_iOS7SearchBar.h"

## 调用代码

LF_iOS7SearchBar *searchBar = [[LF_iOS7SearchBar alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 44.f)];
searchBar.placeholder = @"搜索";
[searchBar setShowsCancelButton:YES animated:YES];
// 代理
searchBar.delegate = self;

## 图片展示

![image](https://github.com/lincf0912/LF_iOS7SearchBar/blob/master/ScreenShots/screenshot.gif)
