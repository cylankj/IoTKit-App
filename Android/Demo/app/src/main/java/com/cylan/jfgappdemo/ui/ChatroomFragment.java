package com.cylan.jfgappdemo.ui;

import android.databinding.DataBindingUtil;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Toast;

import com.cylan.entity.jniCall.JFGDevice;
import com.cylan.entity.jniCall.RobotMsg;
import com.cylan.jfgapp.jni.JfgAppCmd;
import com.cylan.jfgappdemo.JfgEvent;
import com.cylan.jfgappdemo.R;
import com.cylan.jfgappdemo.databinding.FragmentChatroomBinding;
import com.superlog.SLog;

import org.greenrobot.eventbus.EventBus;
import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

/**
 * 消息透传界面。
 * 此界面的消息，原样的发送到设备端。
 * Created by lxh on 16-8-15.
 */
public class ChatroomFragment extends BaseFragment {

    FragmentChatroomBinding binding;
    int sn;
    JFGDevice device;
    StringBuilder sb;

    public static ChatroomFragment getInstance(Bundle bundle) {
        ChatroomFragment fragment = new ChatroomFragment();
        fragment.setArguments(bundle);
        return fragment;
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        binding = DataBindingUtil.inflate(inflater, R.layout.fragment_chatroom, container, false);
        return binding.getRoot();
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
    }


    @Override
    public void onStart() {
        super.onStart();
        device = (JFGDevice) getArguments().getSerializable("Device");
        if (device == null) {
            // device must not null;
            Toast.makeText(getContext(), "Device is Null.", Toast.LENGTH_LONG).show();
            return;
        }
        sb = new StringBuilder();
        addLinstener();
    }


    private void addLinstener() {
        binding.btnCommintSend.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                sendMessage();
            }
        });
    }

    private void sendMessage() {
        String str = binding.etInput.getText().toString().trim();
        if (TextUtils.isEmpty(str)) return;
        RobotMsg robotMsg = new RobotMsg();
        robotMsg.msg = str;
        robotMsg.sn = sn;
        robotMsg.isAck = binding.cbIsack.isChecked();
        robotMsg.targets.add(device.uuid);
        JfgAppCmd.getInstance().robotTransmitMsg(robotMsg);
        sn++;
        sb.append("send: ").append(str).append("\n");
        binding.tvEchoMsg.setText(sb.toString());
        if (binding.cbClearText.isChecked()) {
            binding.etInput.getText().clear();
        }
    }

    @Override
    public void onResume() {
        super.onResume();
        EventBus.getDefault().register(this);
    }

    @Override
    public void onPause() {
        super.onPause();
        EventBus.getDefault().unregister(this);
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void OnRobotTransmitMsg(RobotMsg robotMsg) {
        if (robotMsg == null) {
            return;
        }
        sb.append("recv:").append(robotMsg.msg).append("\n");
        binding.tvEchoMsg.setText(sb.toString());
    }

    @Subscribe()
    public void onRobotTransmitMsgAck(JfgEvent.RobotMsgAck ack) {
        SLog.i("sn:" + ack.sn);
    }


}
