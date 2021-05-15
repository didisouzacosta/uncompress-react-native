package com.uncompress

import com.google.common.truth.Truth.assertThat
import com.uncompress.domain.enum.Compatibility
import com.uncompress.infra.adapters.zip.ZipExtractor
import junit.framework.Assert.fail
import org.junit.After
import org.junit.Before
import org.junit.Test
import java.io.File

class ZipExtractorTest {

  private val zipExtractor = ZipExtractor()
  private val resourcesPath = "src/test/resources/com.uncompress/zip/"
  private val zipFile = File(resourcesPath + "mononoke.zip")
  private val protectedZipFile = File(resourcesPath + "mononoke_protected.cbz")
  private val failZipFile = File(resourcesPath + "zip_fail.zip")

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
    tempDirectory.deleteRecursively()
  }

  @Test
  fun `ensure compatibilities`() {
    val compatibilities = zipExtractor.compatibilities
    assertThat(compatibilities).isEqualTo(listOf(Compatibility.CBZ, Compatibility.ZIP))
  }

  @Test
  fun `should return true if file is protected`() {
    val isProtected = zipExtractor.isProtected(protectedZipFile.path)
    assertThat(isProtected).isTrue()
  }

  @Test
  fun `should return false if file is not protected`() {
    val isProtected = zipExtractor.isProtected(zipFile.path)
    assertThat(isProtected).isFalse()
  }

  @Test
  fun `decompress file if extract successful`() {
    val filePath = zipFile.path
    val directory = tempDirectory.path

    zipExtractor.extract(filePath, directory, true, null)
  }

  @Test
  fun `decompress file if extract with password successful`() {
    val filePath = protectedZipFile.path
    val directory = tempDirectory.path

    zipExtractor.extract(filePath, directory, true, "123")
  }

  @Test
  fun `create destination if destination not exists`() {
    val filePath = zipFile.path
    val directory = tempDirectory.path

    tempDirectory.deleteRecursively()

    zipExtractor.extract(filePath, directory, true, null)
  }

  @Test
  fun `throw error if extract fails`() {
    val filePath = failZipFile.path
    val directory = tempDirectory.path

    try {
      zipExtractor.extract(filePath, directory, true, null)
      fail("throw error if extract fail")
    } catch(e: Throwable) {}
  }

  @Test
  fun `throw error if file path is invalid`() {
    val directory = tempDirectory.path

    try {
      zipExtractor.extract("", directory, true, null)
      fail("throw error if file path is invalid fail")
    } catch(e: Throwable) {}
  }

  @Test
  fun `throw error if destination is invalid`() {
    val filePath = zipFile.path

    try {
      zipExtractor.extract(filePath, "", true, null)
      fail("throw error if destination is invalid fail")
    } catch(e: Throwable) {}
  }

}
