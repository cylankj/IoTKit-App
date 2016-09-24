//
//  JFGSDKEfamilyMsgpack.h
//  JFGSDK
//
//  Created by 杨利 on 16/9/13.
//  Copyright © 2016年 yangli. All rights reserved.
//

#include "msgpack.hpp"

class MsgHeader
{
public:
    MSGPACK_DEFINE(mId, mCaller, mCallee, mSeq);
    
    MsgHeader() {}
    MsgHeader(int id)
    : mId(id),
    mSeq(0){}
    MsgHeader(int id, std::string caller, std::string callee)
    : mId(id),
    mCaller(caller),
    mCallee(callee),
    mSeq(0){}
    
    virtual ~MsgHeader() {}
    
    /// ��Ϣid, ��Чid �� #JFG_MSGPACK_ID
    int mId;
    /// ��Ϣ��Դ, ����Ϊ������,����ͷCID,�ͻ���session
    std::string mCaller;
    /// ��ϢĿ�ĵ�,Ϊ���ص�����ͷCID���ͻ���session
    std::string mCallee;
    uint64_t mSeq;
    
};

template <typename T>
static std::string getBuff(T v){
    msgpack::sbuffer sbuff;
    msgpack::pack(sbuff, v);
    return std::string(sbuff.data(), sbuff.size());
}





