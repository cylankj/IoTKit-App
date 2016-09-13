# 开始工作
1.首先到 http://yf.robotscloud.com/ 官网注册贵司账号。运营时需要到http://yun.robotscloud.com/上面注册。

2.在企业信息中接入贵司的应用,注意安装包的签名必须要填上，即使是debug包也要，需要包含':'。如果没有签名，SDK报一个运行时异常"Not signed in this apk !"。

3.在android Manifests 中填入vid,和vkey。注意程序包名要与在平台中注册的一样。
![](assets/vid.png)

4.加载静态库。

```java
 static {
     System.loadLibrary("jfgsdk");
     System.loadLibrary("sqlcipher");
 }
```
5.初始化SDK。 需要传入 Context,AppCallBack,日志路径 3个参数。
```java
JfgAppCmd.initJfgAppCmd(context, callBack, path);
```
6.绝大部分API 都带返回值。如果返回值不为0，则说明操作此API异常，比如未登陆即调用绑定设备之类的接口。返回值情况，情况错误码。