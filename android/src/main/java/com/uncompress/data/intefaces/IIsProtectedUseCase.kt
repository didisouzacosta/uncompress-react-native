package com.uncompress.data.intefaces

import com.uncompress.domain.enum.Compatibility
import java.io.File

abstract class IIsProtectedUseCase {
  abstract val engines: List<Extractable>

  @Throws(Throwable::class)
  fun run(filePath: String): Boolean {
    if (filePath.isNullOrEmpty()) {
      throw Error("The file path is invalid")
    }

    val extension = getFileExtension(filePath)
    val engine = selectEngineAt(extension)
    return engine.isProtected(filePath)
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
