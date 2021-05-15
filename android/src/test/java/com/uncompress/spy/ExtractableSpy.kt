package com.uncompress.spy

import com.uncompress.data.intefaces.Extractable
import com.uncompress.domain.enum.Compatibility

class ExtractableSpy() : Extractable {
  override var compatibilities: List<Compatibility> = listOf()
  var filePath: String? = null
  var destination: String? = null
  var override: Boolean? = null
  var password: String? = null
  var isProtected: Boolean = false
  var error: Error? = null

  @Throws
  override fun extract(filePath: String, destination: String, override: Boolean, password: String?) {
    this.filePath = filePath
    this.destination = destination
    this.override = override
    this.password = password

    error?.let {
      throw it
    }
  }

  override fun isProtected(filePath: String): Boolean {
    this.filePath = filePath

    error?.let {
      throw it
    }

    return isProtected
  }
}
