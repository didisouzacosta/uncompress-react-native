package com.uncompress.infra.adapters.rar

import com.github.junrar.Archive
import com.github.junrar.Junrar
import com.uncompress.domain.enum.Compatibility
import com.uncompress.data.intefaces.Extractable
import java.io.File

final class RarExtractor: Extractable {

  override val compatibilities: List<Compatibility>
    get() = listOf(Compatibility.CBR, Compatibility.RAR)

  @Throws(Throwable::class)
  override fun extract(
    filePath: String,
    destination: String,
    override: Boolean,
    password: String?
  ) {
    super.extract(filePath, destination, override, password)
    Junrar.extract(filePath, destination, password)
  }

  @Throws(Throwable::class)
  override fun isProtected(filePath: String): Boolean {
    val archive = Archive(File(filePath))
    return archive.isEncrypted
  }
}
