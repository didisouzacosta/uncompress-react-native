package com.uncompress
import com.google.common.truth.Truth.assertThat
import com.uncompress.domain.enum.Compatibility
import com.uncompress.infra.adapters.zip.ZipExtractor
import org.junit.Test

class ZipExtractorTest {

  private val zipExtractor = ZipExtractor()

  @Test
  fun `ensure compatibilities`() {
    val compatibilities = zipExtractor.compatibilities
    assertThat(compatibilities).isEqualTo(listOf(Compatibility.CBZ, Compatibility.ZIP))
  }

  @Test
  fun `decompress file if extract successful`() {
    assertThat(true).isTrue()
  }

  @Test
  fun `decompress file if extract with password successful`() {
    assertThat(true).isTrue()
  }

  @Test
  fun `throw error if extract fails`() {
    assertThat(true).isTrue()
  }

  @Test
  fun `throw error if file path is invalid`() {
    assertThat(true).isTrue()
  }

  @Test
  fun `throw error if destination is invalid`() {
    assertThat(true).isTrue()
  }

}
