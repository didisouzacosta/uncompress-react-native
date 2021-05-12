package com.uncompress.main.factories

import com.uncompress.data.usecase.ExtractUseCase
import com.uncompress.data.usecase.IsProtectedUseCase
import com.uncompress.infra.adapters.rar.RarExtractor
import com.uncompress.infra.adapters.zip.ZipExtractor

class UseCaseFactory {

  companion object {
    private val engines = listOf(ZipExtractor(), RarExtractor())

    fun makeExtractUseCase(): ExtractUseCase {
      return ExtractUseCase(engines)
    }

    fun makeIsProtectedUseCase(): IsProtectedUseCase {
      return IsProtectedUseCase(engines)
    }
  }

}
