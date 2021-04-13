package com.uncompress.data.intefaces

import com.uncompress.domain.enum.Compatibility
import java.io.File
import java.io.IOException

interface Extractable {
  val compatibilities: List<Compatibility>

  @Throws(IOException::class)
  fun extract(
    filePath: String,
    destination: String,
    override: Boolean,
    password: String?
  ) {
    resolveOverride(destination, override)
  }

  @Throws(IOException::class)
  private fun resolveOverride(destination: String, override: Boolean) {
    val file = File(destination)
    val exists = file.exists()

    if (!override) return;
    if (!exists) return;

    if (!file.deleteRecursively()) {
      throw IOException("Não foi possível deletar o arquivo já existente")
    }

    createIfNotExistsDestination(destination)
  }

  @Throws(IOException::class)
  private fun createIfNotExistsDestination(destination: String) {
    val file = File(destination)

    if(file.exists()) return;

    if (!file.mkdir()) {
      throw IOException("Não foi possível criar o diretório $destination")
    }
  }
}
