package com.cylan.jfgappdemo.datamodel;

import org.msgpack.annotation.Index;

/**
 * Created by lxh on 16-7-27.
 */
public class SingleLong extends BaseDataPoint{
    /**
     * The long Value.
     */
    @Index(0)
    public  long value;
}
