package com.example.block_em_all;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import com.example.block_em_all.data.DBHelper;
import com.example.block_em_all.models.BlockedNumber;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

  private static final int PERMISSION_REQUEST_READ_PHONE_STATE = 1;

  private Intent serviceIntent;

  @RequiresApi(api = Build.VERSION_CODES.N)
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

    String[] requiredPermissions = {
            Manifest.permission.ANSWER_PHONE_CALLS,
            Manifest.permission.MODIFY_PHONE_STATE,
            Manifest.permission.READ_PHONE_STATE,
            Manifest.permission.CALL_PHONE,
            Manifest.permission.READ_CALL_LOG
    };

    if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.M) {
      boolean areAllPermissionsGiven = Arrays.stream(requiredPermissions).anyMatch(s -> checkSelfPermission(s) == PackageManager.PERMISSION_DENIED);
      if (areAllPermissionsGiven) {
        requestPermissions(requiredPermissions, PERMISSION_REQUEST_READ_PHONE_STATE);
      }
    }
  }

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);

    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), "com.example.block_em_up/startBlocking").setMethodCallHandler(
      (call, result) -> {
        if (call.method.equals("startService")) {
          ArrayList<String> arguments = (ArrayList<String>) call.arguments;
          DBHelper.DatabaseName = arguments.get(0);
          DBHelper.TableName = arguments.get(1);

          startService();
          result.success("Successfully started the background service!");
        } else if (call.method.equals("refreshBlockList")) {
          ArrayList<HashMap> blockedNumbersMap = (ArrayList<HashMap>)((HashMap) call.arguments).get("blockedNumbers");

          refreshBlockedNumbers(blockedNumbersMap);

          result.success("Successfully added to the block list!");
        }
      }
    );
  }

  private void startService() {
    serviceIntent = new Intent(MainActivity.this, BlockingService.class);
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
      startForegroundService(serviceIntent);
    }
    else {
      startService(serviceIntent);
    }
  }

  private void refreshBlockedNumbers(ArrayList<HashMap> blockedNumbersMap) {
    DBHelper helper = DBHelper.getCurrentInstance(this);

    for (HashMap value: blockedNumbersMap) {
      helper.appendNumber(new BlockedNumber((String)value.get("blockingPattern"), (boolean) value.get("isBlockingActive")));
    }
  }
}
