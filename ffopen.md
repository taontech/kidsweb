通用界面接入协议
=============
version: **0.1**

此协议规约第三方组件接入广场详情的方式，使开发者能够为广场开发组件，广场方可以使用第三方组件来组合自己广场的功能，开发者可以使用飞凡提供的广场组件和API来开发组件，也可使用第三方api来的开发特殊功能。
## 1.飞凡入口容器接入方式
入口容器目前采用 [React Native](https://github.com/facebook/react-native) 的方式，下面规约接入必须要提供的内容。
### 1.1 入口
飞凡提供一个通用的app接入入口View,可能的形式如下：

![入口]( http://taontech.github.io/kidsweb/rukou.png )

入口view本身以Native编写，便于集成到现有项目中，内部逻辑依旧采用RN编写，使用RN动态的便利性为app容器提供灵活配置。

 ![]( http://taontech.github.io/kidsweb/appCon.png =350x)


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
		apilist:		["提供api列表"]
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
### 1.2 组件类型
组件类型包含**页面**和**纯功能**。
####页面
完整的界面逻辑，输出类型如下面事例：

```
var weathercell = React.createClass({
    getInitialState: function() {
			....
    },
    render:function(){
        return (
            <View
						....
            </View>
        );

    },
    executeQuery: function () {
      .....
});
module.exports = weathercell;
```
####纯功能组件
输出可以是**函数和数据**，不包含界面逻辑

如下面代码包含数据和函数等输出：

``` 
const plazastyles = {};
plazalist.forEach(plaza => {
  plazastyles[plaza.key] = plaza.style;
});
function getplazastyle(plazaID){
  var style = plazastyles[plazaID];
  return style;
};
const plazas = {
  plazalist,
  plazastyles,
  getplazastyle,
}
module.exports = plazas;
```



### 1.4 功能限定
UF 命名打头，用于区分第三方开发者组件和飞凡内部组件，提供不同的权限控制。对第三方组件开放的功能有：

+ 飞凡全部的开放api（限定飞凡域名）
+ 无登录态的飞凡数据（广场、商户）
+ 室内定位
+ 飞凡对开发者开放的js组件


## 广场详情组件接入方式
广场详情目前提供组件容器，开放着可以开发只针对广场的组件，广场管理者可以选择自己广场使用的组件，为自己广场提供不同的展示效果和功能

### js文件命名
每个组件限定一个js文件，可以import RN系统组件,可以引用飞凡提供的组件。文件的命名规则如下：

>（组件分类) _ (组件功能分类)_ (具体类型).js

> 举例：'**UF_weather_beijing.js**'
> 其中 UF 代表第三方组件，飞凡自有组件以FF表示；weather代表功能是天气；beijing表示是北京的天气。

如下图所示:

![入口]( http://taontech.github.io/kidsweb/typelist.png )

我们可以为同一功能的组件提供多个选择，其中可能包含样式的不同或者具体功能的区别。可以通过**UF_weather**来区分组件的大功能分类。



组件按照标准RN类的写法，必须提供以下方法：

```
var weathercell = React.createClass({

	// 组件信息
    getInfo:function(){
    ...
    }
    // 渲染布局函数
    render:function(){
    ...
    },
});
module.exports = weathercell;
```
getInfo函数返回组件的信息，用于展示和配置时：

```
    getInfo:function(){
    return {
    	title: "需要显示的组件名称-非必选"，
    	icon: 	"组件图标"，
    	height: 100, // 组件高度，宽度不用指定，以手机宽度为准
    	discription: "组件功能描述"，
    	disImgs:["http://img1.ffan.com/2.png",...], // 组件截图
    	AuthorKey: "开发者标识"
    }

```

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

## mock app 供开发调试
为方便开发者调试，我们需要为开发者提供mock app来展示组件，此app接受开发者输入的js地址，输出开发者组件的样式和功能。app中包含飞凡提供的所有开放组件和api，以及需要的mock数据，比如广场详情等。在此app中运行的组件和在飞凡上运行效果一致。
## 品牌组件接入方式
## 飞凡提供的组件
api 白名单方式调用，统一api调用方式，不单独开放js api 接口，而是以反射的方式来请求。
