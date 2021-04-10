package com.uncompress.infra.adapters.rar

import com.github.junrar.Junrar
import com.uncompress.domain.enum.Compatibility
import com.uncompress.data.intefaces.Extractable
import java.io.File
import java.io.IOException

final class RarExtractor: Extractable {

  override val compatibilities: List<Compatibility>
    get() = listOf(Compatibility.CBR, Compatibility.RAR)

  @Throws(IOException::class)
  override fun extract(
    filePath: String,
    destination: String,
    override: Boolean,
    password: String?
  ) {
    resolveOverride(destination, override)
    Junrar.extract(filePath, destination, password)
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
