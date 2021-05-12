package com.uncompress

import com.google.common.truth.Truth
import com.google.common.truth.Truth.assertThat
import com.uncompress.domain.enum.Compatibility
import com.uncompress.infra.adapters.rar.RarExtractor
import org.junit.After
import org.junit.Assert.fail
import org.junit.Before
import org.junit.Test
import java.io.File


class RarExtractorTest {
  private val rarExtractor = RarExtractor()
  private val resourcesPath = "src/test/resources/com.uncompress/rar/"
  private val rarFile = File(resourcesPath + "sample_comic.cbr")
  private val protectedRarFile = File(resourcesPath + "protected_sample_comic.cbr")
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
    assertThat(compatibilities).isEqualTo(listOf(Compatibility.CBR, Compatibility.RAR))
  }

  @Test
  fun `should return true if file is protected`() {
    val isProtected = rarExtractor.isProtected(protectedRarFile.path)
    assertThat(isProtected).isTrue()
  }

  @Test
  fun `should return false if file is not protected`() {
    val isProtected = rarExtractor.isProtected(rarFile.path)
    assertThat(isProtected).isFalse()
  }

  @Test
  fun `decompress file if extract successful`() {
    val filePath = rarFile.path
    val directory = tempDirectory.path

    rarExtractor.extract(filePath, directory, true, null);
  }

  @Test
  fun `decompress file if extract with password successful`() {
    val filePath = protectedRarFile.path
    val directory = tempDirectory.path

    rarExtractor.extract(filePath, directory, true, "123");
  }

  @Test
  fun `create destination if destination not exists`() {
    val filePath = rarFile.path
    val directory = tempDirectory.path

    tempDirectory.deleteRecursively()

    rarExtractor.extract(filePath, directory, true, null)
  }

  @Test
  fun `throw error if extract fails`() {
    val filePath = failRarFile.path
    val directory = tempDirectory.path

    try {
      rarExtractor.extract(filePath, directory, true, null)
      fail("throw error if extract fail")
    } catch(e: Throwable) {}
  }

  @Test
  fun `throw error if file path is invalid`() {
    val directory = tempDirectory.path

    try {
      rarExtractor.extract("", directory, true, null)
      fail("throw error if file path is invalid fail")
    } catch(e: Throwable) {}
  }

  @Test
  fun `throw error if destination is invalid`() {
    val filePath = rarFile.path

    try {
      rarExtractor.extract(filePath, "", true, null)
      fail("throw error if destination is invalid fail")
    } catch(e: Throwable) {}
  }

}
