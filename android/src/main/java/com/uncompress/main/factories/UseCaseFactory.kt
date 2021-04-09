package com.uncompress.main.factories

import com.uncompress.data.usecase.DecompressUseCase
import com.uncompress.infra.adapters.rar.RarExtractor
import com.uncompress.infra.adapters.zip.ZipExtractor

final class UseCaseFactory {

  companion object {
    fun useCaseDecompress(): DecompressUseCase {
      return DecompressUseCase(listOf(ZipExtractor(), RarExtractor()))
    }
  }

}
