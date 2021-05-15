package com.uncompress.main.factories

import com.uncompress.data.usecase.ExtractUseCase
import com.uncompress.data.usecase.IsProtectedUseCase
import com.uncompress.infra.adapters.rar.RarExtractor
import com.uncompress.infra.adapters.zip.ZipExtractor
import com.uncompress.presentation.components.Uncompress

final class ComponentsFactory {

  companion object {
    private val engines = listOf(ZipExtractor(), RarExtractor())

    fun makeUncompress(): Uncompress {
      val isProtectedUseCase = IsProtectedUseCase(engines)
      val extractable = ExtractUseCase(engines)

      return Uncompress(extractable, isProtectedUseCase)
    }
  }

}
