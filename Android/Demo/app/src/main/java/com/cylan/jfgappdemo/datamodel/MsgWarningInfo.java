package com.cylan.jfgappdemo.datamodel;

import org.msgpack.annotation.Index;
import org.msgpack.annotation.Message;

/**
 * Created by lxh on 16-8-11.
 */
@Message
public class MsgWarningInfo extends BaseDataPoint {

    @Index(0)
    public long time;
    @Index(1)
    public int isRecode;
    @Index(2)
    public int files;
    @Index(3)
    public int type;


}
