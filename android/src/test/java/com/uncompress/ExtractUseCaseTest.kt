package com.uncompress

import com.google.common.truth.Truth
import com.uncompress.data.usecase.ExtractUseCase
import com.uncompress.domain.enum.Compatibility
import com.uncompress.spy.ExtractableSpy
import junit.framework.Assert.fail
import org.junit.Test

class ExtractUseCaseTest {

  @Test
  fun `ensure compatibilities`() {
    val rarEngine = ExtractableSpy()
    val zipEngine = ExtractableSpy()

    rarEngine.compatibilities = listOf(Compatibility.CBR, Compatibility.RAR)
    zipEngine.compatibilities = listOf(Compatibility.ZIP, Compatibility.CBZ)

    val useCase = ExtractUseCase(listOf(rarEngine, zipEngine))

    Truth.assertThat(useCase.compatibilities).isEqualTo(listOf(Compatibility.CBR, Compatibility.RAR, Compatibility.ZIP, Compatibility.CBZ))
  }

  @Test
  fun `should use correctly engine at file extension`() {
    val rarEngine = ExtractableSpy()
    val zipEngine = ExtractableSpy()

    rarEngine.compatibilities = listOf(Compatibility.CBR, Compatibility.RAR)
    zipEngine.compatibilities = listOf(Compatibility.ZIP, Compatibility.CBZ)

    val useCase = ExtractUseCase(listOf(rarEngine, zipEngine))

    useCase.run("test.rar", "temp/fake", true, "123")

    Truth.assertThat(rarEngine.filePath).isEqualTo("test.rar")
    Truth.assertThat(rarEngine.destination).isEqualTo("temp/fake")
    Truth.assertThat(rarEngine.override).isEqualTo(true)
    Truth.assertThat(rarEngine.password).isEqualTo("123")

    Truth.assertThat(zipEngine.filePath).isNull()
    Truth.assertThat(zipEngine.destination).isNull()
    Truth.assertThat(zipEngine.override).isNull()
    Truth.assertThat(zipEngine.password).isNull()
  }

  @Test
  fun `throw error if extract fails`() {
    val rarEngine = ExtractableSpy()
    rarEngine.compatibilities = listOf(Compatibility.CBR, Compatibility.RAR)
    rarEngine.error = Error("Error Simulation")

    val useCase = ExtractUseCase(listOf(rarEngine))

    try {
      useCase.run("test.rar", "temp/fake", true, "123")
      fail()
    } catch(e: Throwable) {
      Truth.assertThat(e.message).isEqualTo("Error Simulation")
    }
  }

  @Test
  fun `throw error if filepath is invalid`() {
    val rarEngine = ExtractableSpy()
    rarEngine.compatibilities = listOf(Compatibility.CBR, Compatibility.RAR)

    val useCase = ExtractUseCase(listOf(rarEngine))

    try {
      useCase.run("", "temp/fake", true, "123")
      fail()
    } catch(e: Throwable) {
      Truth.assertThat(e.message).isEqualTo("The file path is invalid")
    }
  }

  @Test
  fun `throw error if destination is invalid`() {
    val rarEngine = ExtractableSpy()
    rarEngine.compatibilities = listOf(Compatibility.CBR, Compatibility.RAR)

    val useCase = ExtractUseCase(listOf(rarEngine))

    try {
      useCase.run("test.rar", "", true, "123")
      fail()
    } catch(e: Throwable) {
      Truth.assertThat(e.message).isEqualTo("The destination path is invalid")
    }
  }

  @Test
  fun `throw error if extension does not supported`() {
    val rarEngine = ExtractableSpy()
    rarEngine.compatibilities = listOf(Compatibility.CBR, Compatibility.RAR)

    val useCase = ExtractUseCase(listOf(rarEngine))

    try {
      useCase.run("test.7zip", "temp/fake", true, "123")
      fail()
    } catch(e: Throwable) {
      Truth.assertThat(e.message).isEqualTo("7zip is not supported")
    }
  }

}
