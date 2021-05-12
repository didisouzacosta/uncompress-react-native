//
//  IsProtectedUseCaseTests.swift
//  UncompressExampleTests
//
//  Created by Adriano Souza Costa on 19/03/21.
//

import XCTest
import Nimble
import Uncompress

class IsProtectedUseCaseTests: XCTestCase {

  func testShouldUseCorrectlyEngineAtFileExtension() throws {
    let rarEngine = ExtractableSpy()
    let zipEngine = ExtractableSpy()

    rarEngine.compatibilities = [.rar, .cbr]
    zipEngine.compatibilities = [.zip, .cbz]

    let useCase = IsProctectedUseCase(engines: [rarEngine, zipEngine])

    _ = try useCase.run("test.rar")

    expect(rarEngine.filePath?.absoluteString) == "test.rar"
    expect(zipEngine.filePath).to(beNil())
  }

  func testThrowErrorIfIsProtectedFails() throws {
    let rarEngine = ExtractableSpy()
    rarEngine.compatibilities = [.zip, .cbz]
    rarEngine.error = "Error simulation"

    let useCase = IsProctectedUseCase(engines: [rarEngine])

    do {
      _ = try useCase.run("test.zip")
      fail()
    } catch {
      expect(error.localizedDescription) == "Error simulation"
    }
  }

  func testThrowErrorIfPathIsInvalid() throws {
    let rarEngine = ExtractableSpy()
    rarEngine.compatibilities = [.rar, .cbr]

    let useCase = IsProctectedUseCase(engines: [rarEngine])

    do {
      _ = try useCase.run("")
      fail()
    } catch {
      expect(error.localizedDescription) == "The file path is invalid"
    }
  }

  func testThrowErrorIfExtensionDoesNotSupported() throws {
    let rarEngine = ExtractableSpy()
    rarEngine.compatibilities = [.rar, .cbr]

    let useCase = IsProctectedUseCase(engines: [rarEngine])

    do {
      _ = try useCase.run("file.7zip")
      fail()
    } catch {
      expect(error.localizedDescription) == "Does not have a 7zip extension engine"
    }
  }

}
