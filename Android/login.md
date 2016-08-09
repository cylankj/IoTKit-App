# User Login

登陆主要有两种方式，标准加菲狗客户端账号登陆和第三方账号登陆。

1.标准账号

```java
JfgAppCmd.getInstance().login(userName, pwd, "cylan");
```

登陆的回调结果,判断resultType为JfgEvent.ResultEvent.JFG_RESULT_LOGIN，接着判读resultCode为0即为成功。

```java
public void OnResult(int resultType, int resultCode);

```

2.第三方登录接口暂时未实现，敬请期待。