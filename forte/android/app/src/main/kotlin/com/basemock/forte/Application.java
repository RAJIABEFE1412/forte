package com.basemock.forte;

import io.flutter.app.FlutterApplication;
import android.content.Context;
import androidx.multidex.MultiDex;
import io.flutter.embedding.android.FlutterActivity;


public class Application extends FlutterApplication {

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
        MultiDex.install(this);
    }
}