package com.cagridurmus.system_screen_brightness

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** SystemScreenBrightnessPlugin */
class SystemScreenBrightnessPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  private val CHANNEL = "commm.cagridurmus.set_system_brightness"

  private lateinit var channel : MethodChannel
  private var appContext: Context? = null
  private lateinit var mActivity: Activity

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    appContext = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, CHANNEL)
    channel.setMethodCallHandler(this)


  }

  @RequiresApi(Build.VERSION_CODES.M)
  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when(call.method){
      "setSystemScreenBrightness" -> {
        val brightness: Int = call.argument("brightness")!!
        if (brightness == null) {
          result.error("-2", "Unexpected error on null brightness", null)
          return
        }
        setScreenBrightness(brightness)
      }
      "checkSystemWritePermission" -> result.success(checkSystemWritePermission())
      "openAndroidPermissionsMenu" -> result.success(openAndroidPermissionsMenu())
      "getSystemScreenBrightness" -> result.success(getScreenBrightness())
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    mActivity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {

  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    TODO("Not yet implemented")
  }

  override fun onDetachedFromActivity() {
    TODO("Not yet implemented")
  }

  private fun setScreenBrightness(brightness: Int){
    Settings.System.putInt(
      appContext?.contentResolver,
      Settings.System.SCREEN_BRIGHTNESS_MODE,
      Settings.System.SCREEN_BRIGHTNESS_MODE_MANUAL
    )
    Settings.System.putInt(
      appContext?.contentResolver,
      Settings.System.SCREEN_BRIGHTNESS, brightness
    )

  }



  private fun checkSystemWritePermission(): Boolean{
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M){
      if (Settings.System.canWrite(appContext)) return true else openAndroidPermissionsMenu()
    }
    return false
  }


  private fun openAndroidPermissionsMenu(){
    if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.M){
      val intent = Intent(Settings.ACTION_MANAGE_WRITE_SETTINGS)
      intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
      intent.data = Uri.parse("package:" + appContext?.packageName)
      appContext?.startActivity(intent)
    }
  }

  private fun getScreenBrightness(): Double {
    return Settings.System.getInt(appContext?.contentResolver, Settings.System.SCREEN_BRIGHTNESS) / 255.0
  }

}
