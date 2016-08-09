# User Register

1.注册主要有两种方式。手机注册和邮箱注册。

2.手机注册：

（1） 首先需要获取到短信验证码。

```java
JfgAppCmd.getInstance().sendCheckCode(phoneNumber, "cylan");  
```


 然后短信验证码的发送情况在此回调中，判断resultType为 JfgEvent.ResultEvent.JFG_RESULT_SENDSMS，就是短信发送的回调。接着判断resultCode为0即可。

```java
public void OnResult(int resultType, int resultCode);
```

（2）注册，传入用户名，密码，公司标识，注册方式，验证码。

```java
JfgAppCmd.getInstance().register(account, pwd, "cylan", JfgEvent.REGISTER_TYPE_PHONE, code);

```

3.邮箱注册，只需改变注册方式为邮箱，验证码为空即可。

