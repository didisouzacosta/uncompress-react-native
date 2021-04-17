package com.uncompress.domain.enum

import java.io.IOException
import java.lang.Exception


enum class Compatibility {
  ZIP, CBZ, RAR, CBR;

  companion object {
    @Throws(Error::class)
    fun compatibilityWith(extension: String): Compatibility {
      return when(extension.toLowerCase()) {
        "zip" -> Compatibility.ZIP
        "cbz" -> Compatibility.CBZ
        "rar" -> Compatibility.RAR
        "cbr" -> Compatibility.CBR
        else -> throw Error("$extension is not supported");
      }
    }
  }
}
