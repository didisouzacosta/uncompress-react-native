package com.uncompress.infra.adapters

import com.uncompress.domain.enum.Compatibility

interface Extractable {
  val compatibilities: ArrayList<Compatibility>
  
  fun extract(filePath: String, destination: String, override: Boolean, password: String?)
}
