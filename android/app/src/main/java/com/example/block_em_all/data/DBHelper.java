package com.example.block_em_all.data;

import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import com.example.block_em_all.models.BlockedNumber;

import java.util.ArrayList;

public class DBHelper extends SQLiteOpenHelper {

    private static DBHelper currentInstance;

    public static String DatabaseName;
    public static String TableName;

    public static final String BLOCKED_NUMBERS_COLUMN_BLOCKING_PATTERN = "blockingPattern";
    public static final String BLOCKED_NUMBERS_COLUMN_IS_BLOCKING_ACTIVE = "isBlockingActive";

    private static ArrayList<BlockedNumber> blockedNumbers;

    public DBHelper(Context context) {
        super(context, DBHelper.DatabaseName,  null, 1);
    }

    public static DBHelper getCurrentInstance(Context context) {
        if (currentInstance == null) {
            currentInstance = new DBHelper(context);
        }

        return currentInstance;
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
    }

    public ArrayList<BlockedNumber> getAllBlockedNumbers() {

        if (blockedNumbers != null) {
            return  blockedNumbers;
        }

        SQLiteDatabase db = this.getReadableDatabase();
        blockedNumbers = new ArrayList();

        try {
            Cursor cursor =  db.rawQuery("SELECT * FROM " + DBHelper.TableName, null);
            try {
                if (cursor.moveToFirst()) {
                    do {
                        BlockedNumber blockedNumber = new BlockedNumber();
                        blockedNumber.blockingPattern = cursor.getString(cursor.getColumnIndex(BLOCKED_NUMBERS_COLUMN_BLOCKING_PATTERN));
                        blockedNumber.isBlockingActive = cursor.getInt(cursor.getColumnIndex(BLOCKED_NUMBERS_COLUMN_IS_BLOCKING_ACTIVE)) == 1;

                        blockedNumbers.add(blockedNumber);
                    } while (cursor.moveToNext());
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            finally {
                try { cursor.close(); } catch (Exception ignore) {}
            }
        }
        finally {
            try { db.close(); } catch (Exception ignore) {}
        }

        return blockedNumbers;
    }

    public void appendNumbers(ArrayList<BlockedNumber> numbers) {
        if (blockedNumbers == null) {
            blockedNumbers = new ArrayList();
        }

        blockedNumbers.addAll(numbers);
    }

    public void setNumbers(ArrayList<BlockedNumber> numbers) {
        blockedNumbers = numbers;
    }
}
