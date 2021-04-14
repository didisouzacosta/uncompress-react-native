//
//  ExtractUseCaseTests.swift
//  UncompressExampleTests
//
//  Created by Adriano Souza Costa on 19/03/21.
//

import XCTest
import Nimble
import uncompress

class ExtractUseCaseTests: XCTestCase {

  private let engine = ExtractableSpy()

  func testEnsureCompatibilities() throws {
    let rarEngine = ExtractableSpy()
    let zipEngine = ExtractableSpy()

    rarEngine.compatibilities = [.rar, .cbr]
    zipEngine.compatibilities = [.zip, .cbz]

    let useCase = ExtractUseCase(engines: [zipEngine, rarEngine])

    expect(useCase.compatibilities) == [.zip, .cbz, .rar, .cbr]
  }

  func testShouldUseCorrectlyEngineAtFileExtension() throws {
    let rarEngine = ExtractableSpy()
    let zipEngine = ExtractableSpy()

    rarEngine.compatibilities = [.rar, .cbr]
    zipEngine.compatibilities = [.zip, .cbz]

    let useCase = ExtractUseCase(engines: [rarEngine, zipEngine])

    try useCase.run(
      "test.rar",
      to: "temp/fake",
      overwrite: true,
      password: "123"
    )

    expect(rarEngine.filePath?.absoluteString) == "test.rar"
    expect(rarEngine.destination?.absoluteString) == "temp/fake"
    expect(rarEngine.overwrite) == true
    expect(rarEngine.password) == "123"

    expect(zipEngine.filePath).to(beNil())
    expect(zipEngine.destination).to(beNil())
    expect(zipEngine.overwrite) == true
    expect(zipEngine.password).to(beNil())
  }

  func testThrowErrorIfExtractFails() throws {
    let rarEngine = ExtractableSpy()
    rarEngine.compatibilities = [.zip, .cbz]
    rarEngine.error = "Error simulation"

    let useCase = ExtractUseCase(engines: [rarEngine])

    do {
      try useCase.run(
        "test.zip",
        to: "temp/fake",
        overwrite: true,
        password: "123"
      )
      fail()
    } catch {
      expect(error.localizedDescription) == "Error simulation"
    }
  }

  func testThrowErrorIfPathIsInvalid() throws {
    let rarEngine = ExtractableSpy()
    rarEngine.compatibilities = [.rar, .cbr]

    let useCase = ExtractUseCase(engines: [rarEngine])

    do {
      try useCase.run(
        "",
        to: "temp/fake",
        overwrite: true,
        password: "123"
      )
      fail()
    } catch {
      expect(error.localizedDescription) == "The file path is invalid"
    }
  }

  func testThrowErrorIfDestinationIsInvalid() throws {
    let rarEngine = ExtractableSpy()
    rarEngine.compatibilities = [.rar, .cbr]

    let useCase = ExtractUseCase(engines: [rarEngine])

    do {
      try useCase.run(
        "file.zip",
        to: "",
        overwrite: true,
        password: "123"
      )
      fail()
    } catch {
      expect(error.localizedDescription) == "The destination path is invalid"
    }
  }

  func testThrowErrorIfExtensionDoesNotSupported() throws {
    let rarEngine = ExtractableSpy()
    rarEngine.compatibilities = [.rar, .cbr]

    let useCase = ExtractUseCase(engines: [rarEngine])

    do {
      try useCase.run(
        "file.7zip",
        to: "temp/comics",
        overwrite: true,
        password: "123"
      )
      fail()
    } catch {
      expect(error.localizedDescription) == "7zip is not supported"
    }
  }

}
