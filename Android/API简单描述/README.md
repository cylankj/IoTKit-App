# JFG Android SDK Document

  此帮助文档主要介绍加菲狗Android SDK的大致逻辑。

 #3.0.133
   1. JFGAccount 类添加一个 resetFlag() 方法。用来清空内部的一个标志。需要在setAccount之后调用。
   2.因为修改手机号必须要有token ，所以将两个参数合并。 setPhone(String phone,String token);

 #3.0.132
   1.添加一个MessagePack的工具类 ‘JfgMessagePackUtils’。
   
 #3.0.131
   1.将DatePoint 中 id 的数据类型为 long 类型。

 #3.0.130
  1.修复setAccount中因为空值导致的崩溃。

 #3.0.118
  1.为了便于以后扩展，修改onResult回调接口，参数改为JFGResult 类。
  2.忘记密码，重置密码，修改密码接口。
  3.分享设备，分享列表。---分享类接口。
  
