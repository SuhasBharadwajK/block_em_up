package com.example.block_em_all.telephony;

import android.Manifest;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.telecom.TelecomManager;
import android.telephony.PhoneStateListener;
import android.telephony.TelephonyManager;

import androidx.annotation.RequiresApi;

import com.example.block_em_all.data.DBHelper;
import com.example.block_em_all.models.BlockedNumber;

import java.lang.reflect.Method;
import java.util.ArrayList;

public class IncomingCallHandler extends BroadcastReceiver {

    private ArrayList<BlockedNumber> blockedNumbers;

    @Override
    public void onReceive(Context context, Intent intent) {
        DBHelper dbHelper = DBHelper.getCurrentInstance(context);

        try {
            if (dbHelper == null) {
                dbHelper = new DBHelper(context);
            }

            this.blockedNumbers = dbHelper.getAllBlockedNumbers();

            String state = intent.getStringExtra(TelephonyManager.EXTRA_STATE);
            if (state.equalsIgnoreCase(TelephonyManager.EXTRA_STATE_RINGING)) {
                TelephonyManager tm = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);

                Method m = tm.getClass().getDeclaredMethod("getITelephony");

                m.setAccessible(true);

                tm.listen(new PhoneStateListener() {
                    @RequiresApi(api = Build.VERSION_CODES.M)
                    @Override
                    public void onCallStateChanged(int state, String phoneNumber) {
                        super.onCallStateChanged(state, phoneNumber);
                        callStateChangeHandler(state, phoneNumber, context);
                    }
                }, PhoneStateListener.LISTEN_CALL_STATE);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequiresApi(api = Build.VERSION_CODES.M)
    private void callStateChangeHandler(int state, String phoneNumber, Context context) {
        try {
            TelecomManager telecomManager = (TelecomManager) context.getSystemService(Context.TELECOM_SERVICE);
            if (phoneNumber != null && !phoneNumber.isEmpty() && state != 0 && this.isNumberBlocked(phoneNumber) && context.checkSelfPermission(Manifest.permission.ANSWER_PHONE_CALLS) == PackageManager.PERMISSION_GRANTED && Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                telecomManager.endCall();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private boolean isNumberBlocked(String incomingNumber) {
        for (BlockedNumber blockedNumber: this.blockedNumbers) {
            if (blockedNumber.isBlockingActive && (incomingNumber.startsWith(blockedNumber.blockingPattern) || incomingNumber.equals(blockedNumber.blockingPattern))) {
                return true;
            }
        }

        return false;
    }
}
