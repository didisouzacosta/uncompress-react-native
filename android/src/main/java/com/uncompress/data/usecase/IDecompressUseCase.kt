package com.uncompress.data.usecase

import com.uncompress.domain.enum.Compatibility
import com.uncompress.infra.adapters.Extractable
import java.io.IOException

abstract class IDecompressUseCase {
  abstract val engines: List<Extractable>

  val compatibilities: List<Compatibility> get() = engines.flatMap { it.compatibilities }

  @Throws(IOException::class)
  fun extract(
    filePath: String,
    destination: String,
    override: Boolean,
    password: String?
  ) {

  }
}
