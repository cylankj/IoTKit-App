package com.cylan.jfgappdemo.datamodel;

import org.msgpack.annotation.Index;
import org.msgpack.annotation.Message;

/**
 * Created by lxh on 16-7-27.
 */
@Message
public class SingleBool extends BaseDataPoint{
    /**
     * The boolean Value.
     */
    @Index(0)
    public boolean value;
}
