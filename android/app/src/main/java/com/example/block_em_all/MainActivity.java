package com.example.block_em_all;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import java.util.Arrays;
import java.util.List;

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

    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), "com.example.block_em_up").setMethodCallHandler(
      (call, result) -> {
        if (call.method.equals("startService")) {
          startService();
          result.success("Hooray! Service started");
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
}
