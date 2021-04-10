package com.uncompress.data.usecase

import com.uncompress.infra.adapters.Extractable

class ExtractUseCase(override val engines: List<Extractable>) : IExtractUseCase() {}
