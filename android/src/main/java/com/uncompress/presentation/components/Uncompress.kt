package com.uncompress.presentation.components

import com.uncompress.data.intefaces.IExtractUseCase
import com.uncompress.data.intefaces.IIsProtectedUseCase

data class Uncompress(private val extractUseCase: IExtractUseCase, private val isProtectedUseCase: IIsProtectedUseCase) {

  @Throws(Throwable::class)
  fun extract(
    filePath: String,
    destination: String,
    override: Boolean = true,
    password: String? = null
  ) {
    extractUseCase.run(filePath, destination, override, password)
  }

  @Throws(Throwable::class)
  fun isProtected(filePath: String): Boolean {
    return isProtected(filePath)
  }

}
