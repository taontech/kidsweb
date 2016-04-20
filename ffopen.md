# 通用界面接入协议
version: 0.1

此协议规约第三方组件接入广场详情的方式，使开发者能够为广场开发组件，广场方可以使用第三方组件来组合自己广场的功能，开发者可以使用飞凡提供的广场组件和API来开发组件，也可使用第三方api来的开发特殊功能。
## 飞凡入口容器接入方式
入口容器目前采用 [React Native](https://github.com/facebook/react-native) 的方式，下面规约接入必须要提供的内容。
### 入口
飞凡提供一个通用的app接入入口View,可能的形式如下：
![入口]( http://taontech.github.io/kidsweb/rukou.png )

开发者需要提供的如下配置信息：

```
	appconfig:{
		icon:         	"http://您app需要展示icon的地址"，
		name:         	"app的名称"，
		title:        	"展示的名称"
		appScheme:    	"点击App要跳转到的地址",
		jsboundleURI: 	"jsboundle下载地址",
		jsMD5:			"校验jsboundle的MD5，防止逻辑篡改绕过审核"
		author:       	"作者"
		appKey:		   	"飞凡为app提供的唯一appkey"
	}
/*	
	icon:         	120*120 png格式
	name:         	加ff和ff前缀，用于内部区分
	title：       	显示在容器中的名称,5个字符之内
	appScheme:    	跳转到app内部的入口URI，唯一
	jsboundleURI:  	jsbounde的下载地址
	appKey:		   	在线申请的app唯一key
*/
```
## 

## 广场详情组件接入方式

### 流程图

```flow
st=>start: 文件添加
e=>end
op=>operation: 扫描路径
cond=>condition: 是否有新增组件?
addfile=>operation: 扫描文件
mfile=>operation: 修改配置stylelist.js
formatCheck=>condition: 协议正确？
mdweb=>operation: 修改配置页面数据
mdplazadic=>operation: 修改广场配置plazadic.js

st->addfile->formatCheck
formatCheck(yes)->mfile
formatCheck(no)->e
mfile->mdweb
mfile->mdplazadic
mdweb->e
mdplazadic->e
```

###时序图

```sequence
文件监听->组件库: 监听类型文件
Note right of 文件监听: 符合协议
配置后台-->组件库: web组件选择
配置后台->广场配置文件: 影响类型选择
文件监听->广场配置文件: 修改广场页面
Note right of 广场配置文件: 页面显示元素
广场配置文件-->组件库: 运行时使用
```

## 品牌组件接入方式
## 飞凡提供的组件