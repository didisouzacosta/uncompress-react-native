package com.uncompress.data.usecase

import com.uncompress.infra.adapters.Extractable

class DecompressUseCase(override val engines: List<Extractable>) : IDecompressUseCase() {}
