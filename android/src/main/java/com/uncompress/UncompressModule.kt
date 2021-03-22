package com.uncompress

import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.Promise

import com.uncompress.main.factories.UseCaseFactory

class UncompressModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {

    override fun getName(): String {
        return "Uncompress"
    }

    @ReactMethod
    fun decompress(
      filePath: String,
      destination: String,
      overwrite: Boolean = true,
      password: String? = null,
      promise: Promise
    ) {
      UseCaseFactory.decompress()
      promise.resolve(null);
    }

}
