package com.app.telecalling

import android.app.admin.DevicePolicyManager
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.app.telecalling/device_admin"
    private lateinit var dpm: DevicePolicyManager
    private lateinit var deviceAdmin: ComponentName

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        dpm = getSystemService(Context.DEVICE_POLICY_SERVICE) as DevicePolicyManager
        deviceAdmin = ComponentName(this, MyDeviceAdminReceiver::class.java)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "activateDeviceAdmin" -> {
                    activateDeviceAdmin()
                    result.success(null)
                }
                "preventUninstall" -> {
                    preventUninstall()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun activateDeviceAdmin() {
        val intent = Intent(DevicePolicyManager.ACTION_ADD_DEVICE_ADMIN)
        intent.putExtra(DevicePolicyManager.EXTRA_DEVICE_ADMIN, deviceAdmin)
        intent.putExtra(DevicePolicyManager.EXTRA_ADD_EXPLANATION, "Your explanation text")
        startActivityForResult(intent, 1)
    }

    private fun preventUninstall() {
        if (dpm.isAdminActive(deviceAdmin)) {
            dpm.setUninstallBlocked(deviceAdmin, packageName, true)
        }
    }
}
