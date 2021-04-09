package com.uncompress.data.usecase

import com.uncompress.domain.enum.Compatibility
import com.uncompress.infra.adapters.Extractable
import java.io.File
import java.io.IOException

abstract class IDecompressUseCase {
  abstract val engines: List<Extractable>

  val compatibilities: List<Compatibility> get() = engines.flatMap { it.compatibilities }

  @Throws(IOException::class)
  fun extract(
    filePath: String,
    destination: String,
    override: Boolean = true,
    password: String? = null
  ) {
    val extension = getFileExtension(filePath)
    val engine = selectEngineAt(extension)
    engine.extract(filePath, destination, override, password)
  }

  private fun getFileExtension(filePath: String): String {
    return File(filePath).extension
  }

  @Throws(IOException::class)
  private fun selectEngineAt(fileExtension: String): Extractable {
    val compatibility = Compatibility.compatibilityWith(fileExtension)
    val engine = engines.singleOrNull { e -> e.compatibilities.contains(compatibility) }

    if (engine != null) {
      return engine
    } else {
      throw IOException("Não há engine para esse tipo de arquivo")
    }
  }
}
