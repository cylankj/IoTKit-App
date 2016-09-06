package com.cylan.jfgappdemo.ui;

import android.databinding.DataBindingUtil;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Toast;

import com.cylan.constants.JfgConstants;
import com.cylan.jfgapp.jni.JfgAppCmd;
import com.cylan.jfgappdemo.JfgEvent;
import com.cylan.jfgappdemo.R;
import com.cylan.jfgappdemo.databinding.FragmentLoginBinding;
import com.superlog.SLog;

import org.greenrobot.eventbus.EventBus;
import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;


/**
 * 此页面负责登陆。
 * 逻辑处理如下：
 * <p/>
 * Created by lxh on 16-7-14.
 */
public class LoginFragment extends BaseFragment {

    /**
     * The Binding.
     */
    FragmentLoginBinding binding;

    /**
     * Gets instance.
     *
     * @param bundle the bundle
     * @return the instance
     */
    public static LoginFragment getInstance(Bundle bundle) {
        LoginFragment fragment = new LoginFragment();
        fragment.setArguments(bundle);
        return fragment;
    }


    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        binding = DataBindingUtil.inflate(inflater, R.layout.fragment_login, container, false);
        View view = binding.getRoot();
        return view;
    }

    @Override
    public void onStart() {
        super.onStart();
        setListener();
    }

    @Override
    public void onResume() {
        super.onResume();
        EventBus.getDefault().register(this);
        binding.etPwd.setText("88888888");
        binding.etUserName.setText("cleverdog@cylan.com.cn");
        binding.etUserName.setSelection(binding.etUserName.getText().length());
    }

    /**
     * Sets listener.
     */
    public void setListener() {
        binding.btnLogin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String pwd = binding.etPwd.getText().toString().trim();
                String userName = binding.etUserName.getText().toString().trim();
                Toast.makeText(getContext(), "login: " + userName, Toast.LENGTH_SHORT).show();
                SLog.i("name:%s,pwd:%s", userName, pwd);
                JfgAppCmd.getInstance().login(userName, pwd);
//                JfgAppCmd.getInstance().openLogin("testOpenLogin", "http://yf.cylan.com.cn");
            }
        });
        binding.tvRegister.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
//                 show register fragment
                RegisterFragment fragment = RegisterFragment.getInstance(null);
                getActivity().getSupportFragmentManager()
                        .beginTransaction().addToBackStack("login").hide(LoginFragment.this)
                        .add(R.id.fl_container, fragment).commit();
            }
        });
    }


    /**
     * On result.
     *
     * @param resultEvent the result event
     */
    @Subscribe(threadMode = ThreadMode.MAIN)
    public void onResult(JfgEvent.ResultEvent resultEvent) {
        if (resultEvent.event == JfgEvent.ResultEvent.JFG_RESULT_LOGIN) {
            Toast.makeText(getContext(), "login result: " + resultEvent.code, Toast.LENGTH_SHORT).show();
            SLog.i("login result: " + resultEvent.code);
            if (resultEvent.code == JfgConstants.RESULT_OK) {
                // login succeed show dev fragment
                DevListFragment fragment = DevListFragment.getInstance(null);
                getActivity().getSupportFragmentManager()
                        .beginTransaction().replace(R.id.fl_container, fragment).commit();
            }
        } else if (resultEvent.event == JfgEvent.ResultEvent.JFG_RESULT_REGISTER) {
            Toast.makeText(getContext(), "register: " + resultEvent.code, Toast.LENGTH_SHORT).show();
        }
    }


    @Override
    public void onPause() {
        super.onPause();
        EventBus.getDefault().unregister(this);
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
//        setFragmentShowState(false);
    }
}
