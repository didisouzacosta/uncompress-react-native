package com.uncompress

import com.google.common.truth.Truth.assertThat
import com.uncompress.data.usecase.IsProtectedUseCase
import com.uncompress.domain.enum.Compatibility
import com.uncompress.spy.ExtractableSpy
import junit.framework.Assert.fail
import org.junit.Test

class IsProtectedUseCaseTest {

  @Test
  fun `should use correctly engine at file extension`() {
    val rarEngine = ExtractableSpy()
    val zipEngine = ExtractableSpy()

    rarEngine.compatibilities = listOf(Compatibility.CBR, Compatibility.RAR)
    zipEngine.compatibilities = listOf(Compatibility.ZIP, Compatibility.CBZ)

    val useCase = IsProtectedUseCase(listOf(rarEngine, zipEngine))

    useCase.run("test.rar")

    assertThat(rarEngine.filePath).isEqualTo("test.rar")
    assertThat(zipEngine.filePath).isNull()
  }

  @Test
  fun `throw error if is protected fails`() {
    val engine = ExtractableSpy()
    engine.compatibilities = listOf(Compatibility.ZIP, Compatibility.RAR)
    engine.error = Error("Error simulation")

    val useCase = IsProtectedUseCase(listOf(engine))

    try {
      useCase.run("test.rar")
      fail()
    } catch(e: Throwable) {
      assertThat(e.message).isEqualTo("Error simulation")
    }
  }

  @Test
  fun `throw error if file path is invalid`() {
    val engine = ExtractableSpy()
    engine.compatibilities = listOf(Compatibility.ZIP, Compatibility.RAR)

    val useCase = IsProtectedUseCase(listOf(engine))

    try {
      useCase.run("")
      fail()
    } catch(e: Throwable) {
      assertThat(e.message).isEqualTo("The file path is invalid")
    }
  }

  @Test
  fun `throw error if extension does not supported`() {
    val engine = ExtractableSpy()
    engine.compatibilities = listOf(Compatibility.ZIP, Compatibility.RAR)

    val useCase = IsProtectedUseCase(listOf(engine))

    try {
      useCase.run("file.7zip")
      fail()
    } catch(e: Throwable) {
      assertThat(e.message).isEqualTo("7zip is not supported")
    }
  }

}
