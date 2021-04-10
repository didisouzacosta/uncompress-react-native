package com.uncompress.main.factories

import com.uncompress.data.usecase.ExtractUseCase
import com.uncompress.infra.adapters.rar.RarExtractor
import com.uncompress.infra.adapters.zip.ZipExtractor

final class UseCaseFactory {

  companion object {
    fun makeExtractUseCase(): ExtractUseCase {
      return ExtractUseCase(listOf(ZipExtractor(), RarExtractor()))
    }
  }

}
