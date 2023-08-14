package com.zrh.example.flutter_demo

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {

    private lateinit var helloPlugin: HelloPlugin

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        helloPlugin = HelloPlugin(this)
        helloPlugin.onAttachedToEngine(flutterEngine!!)
    }

    override fun onDestroy() {
        super.onDestroy()
        helloPlugin.onDetachedFromEngine()
    }
}
