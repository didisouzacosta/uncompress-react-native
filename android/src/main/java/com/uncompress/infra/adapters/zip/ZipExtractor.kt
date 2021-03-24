package com.uncompress.infra.adapters.zip

import com.uncompress.domain.enum.Compatibility
import com.uncompress.infra.adapters.Extractable
import java.io.IOException

final class ZipExtractor: Extractable {

  override val compatibilities: Array<Compatibility>
    get() = arrayOf(Compatibility.CBZ, Compatibility.ZIP)

  @Throws(IOException::class)
  override fun extract(
    filePath: String,
    destination: String,
    override: Boolean,
    password: String?
  ) {
    TODO("Not yet implemented")
  }

}
