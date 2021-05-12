package com.uncompress.data.usecase

import com.uncompress.data.intefaces.Extractable
import com.uncompress.data.intefaces.IIsProtectedUseCase

class IsProtectedUseCase(override val engines: List<Extractable>) : IIsProtectedUseCase() {}
