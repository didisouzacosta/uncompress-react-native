package com.uncompress.data.intefaces

import com.uncompress.domain.enum.Compatibility
import java.io.File
import java.io.IOException

interface Extractable {
  val compatibilities: List<Compatibility>

  @Throws(Throwable::class)
  fun extract(
    filePath: String,
    destination: String,
    override: Boolean,
    password: String?
  ) {
    resolveOverride(destination, override)
  }

  @Throws(Throwable::class)
  private fun resolveOverride(destination: String, override: Boolean) {
    val file = File(destination)
    val exists = file.exists()

    if (!override) return
    if (!exists) return

    if (!file.deleteRecursively()) {
      throw Error("Could not delete file")
    }

    createIfNotExistsDestination(destination)
  }

  @Throws(Throwable::class)
  private fun createIfNotExistsDestination(destination: String) {
    val file = File(destination)

    if(file.exists()) return

    if (!file.mkdir()) {
      throw Error("Could not create directory $destination")
    }
  }
}
