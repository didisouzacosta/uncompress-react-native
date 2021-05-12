package com.uncompress

import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.Promise
import com.uncompress.main.factories.UseCaseFactory

class UncompressModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {

    override fun getName(): String {
        return "UncompressReactNative"
    }

    @ReactMethod
    fun extract(
      filePath: String,
      destination: String,
      overwrite: Boolean = true,
      password: String? = null,
      promise: Promise
    ) {
      val extractUseCase = UseCaseFactory.makeExtractUseCase()

      try {
        extractUseCase.run(filePath, destination, overwrite, password)
        promise.resolve(null)
      } catch(e: Exception) {
        promise.reject(e)
      }
    }

    @ReactMethod
    fun isProtected(filePath: String, promise: Promise) {
      val isProtectedUseCase = UseCaseFactory.makeIsProtectedUseCase()

      try {
        val isProtected = isProtectedUseCase.run(filePath)
        promise.resolve(isProtected)
      } catch(e: Exception) {
        promise.reject(e)
      }
    }

}
