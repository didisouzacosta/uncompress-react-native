package com.uncompress.infra.adapters.zip

import com.uncompress.domain.enum.Compatibility
import com.uncompress.infra.adapters.Extractable
import net.lingala.zip4j.ZipFile
import net.lingala.zip4j.exception.ZipException
import java.io.IOException

final class ZipExtractor: Extractable {

  override val compatibilities: List<Compatibility>
    get() = listOf(Compatibility.CBZ, Compatibility.ZIP)

  @Throws(IOException::class)
  override fun extract(
    filePath: String,
    destination: String,
    override: Boolean,
    password: String?
  ) {
    try {
      ZipFile(filePath, password?.toCharArray()).extractAll(destination)
    } catch(e: Exception) {
      throw e
    }
  }

}
