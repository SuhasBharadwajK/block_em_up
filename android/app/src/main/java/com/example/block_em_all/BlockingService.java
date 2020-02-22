package com.example.block_em_all;

import android.app.Service;
import android.content.Intent;
import android.os.Build;
import android.os.IBinder;

import androidx.annotation.Nullable;
import androidx.core.app.NotificationCompat;

import com.example.block_em_up.R;

public class BlockingService extends Service {

    @Override
    public void onCreate() {
        super.onCreate();

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationCompat.Builder builder = new NotificationCompat.Builder(this, "messages")
                    .setContentText("This is running in the background")
                    .setContentTitle("Blocking 'em all up!")
                    .setSmallIcon(R.drawable.ic_noun_block_2659466);

            startForeground(101, builder.build());
        }
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}
