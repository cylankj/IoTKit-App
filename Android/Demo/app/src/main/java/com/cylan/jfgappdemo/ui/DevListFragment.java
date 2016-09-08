package com.cylan.jfgappdemo.ui;

import android.content.Intent;
import android.databinding.DataBindingUtil;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v7.widget.LinearLayoutManager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Toast;

import com.cylan.constants.JfgConstants;
import com.cylan.entity.jniCall.JFGDPMsg;
import com.cylan.entity.jniCall.JFGDevBaseValue;
import com.cylan.entity.jniCall.JFGDevice;
import com.cylan.entity.jniCall.RobotoGetDataRsp;
import com.cylan.jfgapp.jni.JfgAppCmd;
import com.cylan.jfgappdemo.JFGAppliction;
import com.cylan.jfgappdemo.JfgEvent;
import com.cylan.jfgappdemo.R;
import com.cylan.jfgappdemo.adapter.DevsAdapter;
import com.cylan.jfgappdemo.databinding.FragmentDevListBinding;
import com.cylan.jfgappdemo.datamodel.BindDevBean;
import com.cylan.jfgappdemo.datamodel.IntAndString;
import com.cylan.jfgappdemo.datamodel.StringAndInt;
import com.superlog.SLog;

import org.greenrobot.eventbus.EventBus;
import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;
import org.msgpack.MessagePack;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;
import java.util.TimeZone;

/**
 * Created by lxh on 16-7-23.
 */
public class DevListFragment extends BaseFragment {

    /**
     * The Binding.
     */
    FragmentDevListBinding binding;
    /**
     * The Adapter.
     */
    DevsAdapter adapter;

    /**
     * Gets instance.
     *
     * @param bundle the bundle
     * @return the instance
     */
    public static DevListFragment getInstance(Bundle bundle) {
        DevListFragment fragment = new DevListFragment();
        fragment.setArguments(bundle);
        return fragment;
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        binding = DataBindingUtil.inflate(inflater, R.layout.fragment_dev_list, container, false);
        return binding.getRoot();
    }


    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        // 模拟数据
        JFGDevice[] devs = new JFGDevice[0];
        adapter = new DevsAdapter(devs);
        binding.rvDevList.setLayoutManager(new LinearLayoutManager(getContext()));
        binding.rvDevList.setAdapter(adapter);
        adapter.setSimpleListener(new DevsAdapter.SimpleListener() {
            @Override
            public void onClick(View v) {
                if (v.getTag() != null && v.getTag() instanceof Integer) {
                    final int position = (int) v.getTag();
                    JFGDevice d = adapter.getDevice()[position];
                    if (d.pid == 86 || d.pid == 18) {
                        Intent intent = new Intent(getContext(), VRPlayActivity.class);
                        intent.putExtra("device", d);
                        getContext().startActivity(intent);
                    } else {
                        PlayFragment fragment = PlayFragment.getInstance(getBundle(d));
                        showOtherFragment(fragment);
                    }
                }
            }
        });
    }

    @NonNull
    private Bundle getBundle(JFGDevice d) {
        Bundle bundle = new Bundle();
        bundle.putSerializable("device", d); // put device
        return bundle;
    }

    private void showOtherFragment(BaseFragment fragment) {
        getFragmentManager().beginTransaction()
                .add(R.id.fl_container, fragment, fragment.getClass().getName())
                .addToBackStack("devs_list")
                .hide(DevListFragment.this).commit();
    }

    @Override
    public void onStart() {
        super.onStart();
        addLinstener();
        EventBus.getDefault().register(this);
    }

    @Override
    public void onResume() {
        super.onResume();
    }

    @Override
    public void onPause() {
        super.onPause();

    }

    @Override
    public void onStop() {
        super.onStop();
        SLog.e("onStop");
        EventBus.getDefault().unregister(this);
    }

    /**
     * Add linstener.
     */
    private void addLinstener() {
        binding.ivAddDev.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // show add dev fragment
                getFragmentManager().beginTransaction()
                        .hide(DevListFragment.this).addToBackStack("list")
                        .add(R.id.fl_container, AddDevFragment.getInstance()).commit();
            }
        });
    }


    /**
     * On update devs.
     *
     * @param devs the devs
     */
    @Subscribe(threadMode = ThreadMode.MAIN)
    public void onUpdateDevs(JFGDevice[] devs) {
        if (!isResumed()) return;
        SLog.i("update devs");
        adapter.setDevice(devs);
        adapter.notifyDataSetChanged();
        // 开始查dataPoint;
        for (JFGDevice dev : devs) {
            getDataPoint(dev.uuid);
        }
    }

    /**
     * Gets data point.
     *
     * @param peer the peer
     */
    private void getDataPoint(String peer) {
        ArrayList<JFGDPMsg> dp = new ArrayList<>();
        JFGDPMsg msg = new JFGDPMsg(201, 0);  // query dev network
        dp.add(msg);
        long seq = JfgAppCmd.getInstance().robotGetData(peer, dp, 1, false, 0);
        SLog.i(peer + " seq:" + seq);
    }

    /**
     * On robot get data rsp.
     *
     * @param rsp the event
     */
    @Subscribe(threadMode = ThreadMode.MAIN)
    public void OnRobotGetDataRsp(RobotoGetDataRsp rsp) throws IOException {
        if (!isResumed())
            return;
        SLog.i(rsp.identity + " seq: " + rsp.seq);
        int index = adapter.getPositionBySn(rsp.identity);
        if (index == -1) return;
        JFGDevice dev = adapter.getDevice()[index];
        if (dev == null) return;
        for (Map.Entry<Integer, ArrayList<JFGDPMsg>> entry : rsp.map.entrySet()) {
            if (201 != entry.getKey()) continue;
            if (entry.getValue() == null) continue;
            JFGDPMsg dp = entry.getValue().get(0);
            MessagePack pack = new MessagePack();
            pack.register(Object.class);
            IntAndString values = new MessagePack().read(dp.packValue, IntAndString.class);
            SLog.i("intValue:" + values.intValue + " , strValue:" + values.strValue);
            pack.unregister();
            // baseValue
            dev.base = new JFGDevBaseValue(); // 判断base 是否为空。
            dev.base.netType = values.intValue;
            dev.base.netName = values.strValue;
            adapter.notifyItemChanged(index);
        }
    }


    /**
     * On result.
     *
     * @param resultEvent the result event
     */
    @Subscribe(threadMode = ThreadMode.MAIN)
    public void onResult(JfgEvent.ResultEvent resultEvent) {
        switch (resultEvent.event) {
            case JfgEvent.ResultEvent.JFG_RESULT_LOGIN:
                if (resultEvent.code == JfgConstants.RESULT_OK
                        && JFGAppliction.bindModel && JFGAppliction.bindBean != null) {
                    sendBindDeviceMsg();
                }
                break;
            case JfgEvent.ResultEvent.JFG_RESULT_BINDDEV:
                SLog.i("bind dev resutl: " + resultEvent.code);
                Toast.makeText(getContext(), "bind dev result:" + resultEvent.code, Toast.LENGTH_SHORT).show();
                break;
            case JfgEvent.ResultEvent.JFG_RESULT_UNBINDDEV:
                SLog.i("unbind dev resutl: " + resultEvent.code);
                Toast.makeText(getContext(), "Ubind dev result:" + resultEvent.code, Toast.LENGTH_SHORT).show();
                if (resultEvent.code != 0) {
                    return;
                }
                int count = getFragmentManager().getBackStackEntryCount();
                for (int i = 0; i < count; i++) {
                    getFragmentManager().popBackStack();
                }
                break;
        }
    }

    @Subscribe()
    public void onRobotoSyncData(JfgEvent.RobotoSyncData data) throws IOException {
        SLog.i("sync data from dev %s, identity: %s ", data.fromDev, data.identity);
        int index = adapter.getPositionBySn(data.identity);
        if (index == -1) return;
        JFGDevice dev = adapter.getDevice()[index];
        if (data.list != null && data.list.size() > 0) {
            for (JFGDPMsg msg : data.list) {
                SLog.w("sync dpId:" + msg.id);
                if (msg.id != 201) continue;  // 此处判断网络类型。
                IntAndString values = new MessagePack().read(msg.packValue, IntAndString.class);
                SLog.i("sync int Value:" + values.intValue + " , sync String Value:" + values.strValue);
                // baseValue
                if (dev.base == null) {
                    dev.base = new JFGDevBaseValue(); // 判断base 是否为空。
                }
                dev.base.netType = values.intValue;
                dev.base.netName = values.strValue;
                adapter.notifyItemChanged(index);
            }
        }

    }


    private void sendBindDeviceMsg() {
        // send bind msg
        BindDevBean bean = JFGAppliction.bindBean;
        SLog.w("bean.BindCode:" + bean.bindCode);
        JfgAppCmd.getInstance().bindDevice(bean.cid, bean.bindCode); // send bind msg
        // send timezone datapoint
        ArrayList<JFGDPMsg> dps = new ArrayList<>();
        JFGDPMsg msg = new JFGDPMsg(214, System.currentTimeMillis());
        StringAndInt pack = new StringAndInt();
        pack.intValue = TimeZone.getDefault().getRawOffset() / 1000;  // 单位为 秒 。
        pack.strValue = TimeZone.getDefault().getID();  // 时区，如： shanghai
        msg.packValue = pack.toBytes();
        dps.add(msg);
        JfgAppCmd.getInstance().robotSetData(bean.cid, dps);
        JFGAppliction.bindBean = null;
        JFGAppliction.bindModel = false;
        EventBus.getDefault().post(new AddDevFragment.ExitFragmentEvent());
    }

}