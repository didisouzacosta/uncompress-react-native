package com.uncompress.infra.adapters.rar

import com.github.junrar.Junrar
import com.uncompress.domain.enum.Compatibility
import com.uncompress.data.intefaces.Extractable
import java.io.File
import java.io.IOException

final class RarExtractor: Extractable {

  override val compatibilities: List<Compatibility>
    get() = listOf(Compatibility.CBR, Compatibility.RAR)

  @Throws(IOException::class)
  override fun extract(
    filePath: String,
    destination: String,
    override: Boolean,
    password: String?
  ) {
    super.extract(filePath, destination, override, password)
    Junrar.extract(filePath, destination, password)
  }
}
