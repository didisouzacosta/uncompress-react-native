package com.uncompress.infra.adapters.zip

import com.uncompress.data.intefaces.Extractable
import com.uncompress.domain.enum.Compatibility
import net.lingala.zip4j.ZipFile
import java.io.IOException


final class ZipExtractor: Extractable {

  override val compatibilities: List<Compatibility>
    get() = listOf(Compatibility.CBZ, Compatibility.ZIP)

  @Throws(java.lang.Exception::class)
  override fun extract(
    filePath: String,
    destination: String,
    override: Boolean,
    password: String?
  ) {
    super.extract(filePath, destination, override, password)
    ZipFile(filePath, password?.toCharArray()).extractAll(destination)
  }

}
