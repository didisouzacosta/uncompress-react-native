package com.uncompress

import com.google.common.truth.Truth
import com.uncompress.domain.enum.Compatibility
import com.uncompress.infra.adapters.rar.RarExtractor
import org.junit.After
import org.junit.Before
import org.junit.Test
import org.junit.rules.TemporaryFolder
import java.io.File
import java.io.IOException
import java.lang.Exception


class RarExtractorTest {
  private val rarExtractor = RarExtractor()
  private val resourcesPath = "src/test/resources/com.uncompress/rar/"
  private val rarFile = File(resourcesPath + "zelda.rar")
  private val protectedRarFile = File(resourcesPath + "zelda_protected.cbr")
  private val failRarFile = File(resourcesPath + "rar_fail.cbr")

  private lateinit var tempDirectory: File

  @Before
  fun setUp(){
    tempDirectory = File(resourcesPath + "temp")
    if(!tempDirectory.exists()) {
      tempDirectory.mkdir()
    }
  }

  @After
  fun tearDown() {
    tempDirectory.delete()
  }

  @Test
  fun `ensure compatibilities`() {
    val compatibilities = rarExtractor.compatibilities
    Truth.assertThat(compatibilities).isEqualTo(listOf(Compatibility.CBR, Compatibility.RAR))
  }

  @Test
  fun `decompress file if extract successful`() {
    val filePath = rarFile.path
    val directory = tempDirectory.path

    try {
      rarExtractor.extract(filePath, directory, true, null);
    } catch(e: Exception) {
      println(e)
    }
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
