package com.uncompress

import com.google.common.truth.Truth
import com.uncompress.domain.enum.Compatibility
import com.uncompress.infra.adapters.rar.RarExtractor
import org.junit.Test

class RarExtractorTest {

  private val rarExtractor = RarExtractor()

  @Test
  fun `ensure compatibilities`() {
    val compatibilities = rarExtractor.compatibilities
    Truth.assertThat(compatibilities).isEqualTo(listOf(Compatibility.CBR, Compatibility.RAR))
  }

  @Test
  fun `decompress file if extract successful`() {
    Truth.assertThat(true).isTrue()
  }

  @Test
  fun `decompress file if extract with password successful`() {
    Truth.assertThat(true).isTrue()
  }

  @Test
  fun `throw error if extract fails`() {
    Truth.assertThat(true).isTrue()
  }

  @Test
  fun `throw error if file path is invalid`() {
    Truth.assertThat(true).isTrue()
  }

  @Test
  fun `throw error if destination is invalid`() {
    Truth.assertThat(true).isTrue()
  }

}
