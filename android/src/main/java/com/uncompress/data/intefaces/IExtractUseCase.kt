package com.uncompress.data.intefaces

import android.webkit.URLUtil
import com.uncompress.domain.enum.Compatibility
import java.io.File
import java.io.IOException

abstract class IExtractUseCase {
  abstract val engines: List<Extractable>

  val compatibilities: List<Compatibility> get() = engines.flatMap { it.compatibilities }

  @Throws(Throwable::class)
  fun run(
    filePath: String,
    destination: String,
    override: Boolean = true,
    password: String? = null
  ) {
    if (filePath.isNullOrEmpty()) {
      throw Error("The file path is invalid")
    }

    if (destination.isNullOrEmpty()) {
      throw Error("The destination path is invalid")
    }

    val extension = getFileExtension(filePath)
    val engine = selectEngineAt(extension)
    engine.extract(filePath, destination, override, password)
  }

  private fun getFileExtension(filePath: String): String {
    return File(filePath).extension
  }

  @Throws(Throwable::class)
  private fun selectEngineAt(fileExtension: String): Extractable {
    val compatibility = Compatibility.compatibilityWith(fileExtension)
    val engine = engines.singleOrNull { e -> e.compatibilities.contains(compatibility) }

    if (engine != null) {
      return engine
    } else {
      throw Error("Does not have a $fileExtension extension engine")
    }
  }
}
