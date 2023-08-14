package com.zrh.example.flutter_demo

import android.content.Context
import android.os.Build
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

/**
 *
 * @author zrh
 * @date 2023/8/14
 *
 */
class HelloPlugin(val context:Context): MethodCallHandler {

    private lateinit var methodChannel:MethodChannel

    fun onAttachedToEngine(flutterEngine: FlutterEngine) {
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "hello")
        methodChannel.setMethodCallHandler(this)
    }

    fun onDetachedFromEngine() {
        methodChannel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when(call.method){
            "getPlatformVersion" -> result.success(Build.VERSION.RELEASE)
            "getAppVersion" -> result.success(getVersionName())
            else -> result.notImplemented()
        }
    }

    private fun getVersionName():String{
        return context.packageManager.getPackageInfo(context.packageName, 0).versionName
    }
}