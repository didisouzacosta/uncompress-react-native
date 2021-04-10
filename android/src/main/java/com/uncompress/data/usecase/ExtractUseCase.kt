package com.uncompress.data.usecase

import com.uncompress.data.intefaces.Extractable
import com.uncompress.data.intefaces.IExtractUseCase

class ExtractUseCase(override val engines: List<Extractable>) : IExtractUseCase() {}
