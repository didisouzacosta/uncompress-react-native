package com.uncompress.infra.adapters

import com.uncompress.domain.enum.Compatibility
import java.io.IOException

interface Extractable {
  val compatibilities: List<Compatibility>

  @Throws(IOException::class)
  fun extract(
    filePath: String,
    destination: String,
    override: Boolean,
    password: String?
  )
}
