package com.uncompress.infra.adapters.rar

import com.uncompress.domain.enum.Compatibility
import com.uncompress.infra.adapters.Extractable
import net.lingala.zip4j.ZipFile
import net.lingala.zip4j.exception.ZipException
import java.io.IOException
import java.lang.Exception

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
    try {
      throw IOException("Componente de extração ainda não concluído")
    } catch(e: Exception) {
      throw e
    }
  }

}
