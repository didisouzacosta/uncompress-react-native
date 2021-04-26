//
//  RarExtractorTests.swift
//  UncompressExampleTests
//
//  Created by Adriano Souza Costa on 14/03/21.
//

import XCTest
import Nimble
import Uncompress

class RarExtractorTests: XCTestCase {

  private let fileManager = FileManager()
  private let tempDirectory = URL(string: NSTemporaryDirectory())!
  private let rarExtractor = RarExtractor()

  private var defaultFile: URL {
    let path = Bundle.test.path(forResource: "zelda", ofType: "jpeg")!
    return URL(string: path)!
  }

  private var rarFilePath: URL {
    let path = Bundle.test.path(forResource: "zelda", ofType: "rar")!
    return URL(string: path)!
  }

  private var protectedRarFilePath: URL {
    let path = Bundle.test.path(forResource: "zelda_protected", ofType: "cbr")!
    return URL(string: path)!
  }

  private var failRarFilePath: URL {
    let path = Bundle.test.path(forResource: "rar_fail", ofType: "rar")!
    return URL(string: path)!
  }

  override func setUp() {
    do {
      try fileManager.clearTempDirectory()
    } catch {
      print(error)
    }
  }

  func testEnsureCompatibilities() {
    let compatibilities = rarExtractor.compatibilities
    expect(compatibilities) == [.rar, .cbr]
  }
  
  func testShouldReturnTrueIfFileIsProtected() throws {
    let isProctected = try rarExtractor.isProtected(protectedRarFilePath)
    expect(isProctected) == true
  }
  
  func testShouldReturnFalseIfFileNotIsProtected() throws {
    let isProctected = try rarExtractor.isProtected(rarFilePath)
    expect(isProctected) == false
  }

  func testDecompressFileIfExtractSuccessful() throws {
    try rarExtractor.extract(
      rarFilePath,
      to: tempDirectory
    )

    let contents = try fileManager.contentsOfDirectory(atPath: tempDirectory.absoluteString)

    expect(contents.contains("zelda.jpeg")) == true
  }

  func testDecompressFileIfExtractWithPasswordSucessful() throws {
    try rarExtractor.extract(
      protectedRarFilePath,
      to: tempDirectory,
      password: "123"
    )

    let contents = try fileManager.contentsOfDirectory(atPath: tempDirectory.absoluteString)

    expect(contents.contains("zelda.jpeg")) == true
  }

  func testThrowErrorIfExtractFileFails() {
    do {
      try rarExtractor.extract(
        failRarFilePath,
        to: tempDirectory
      )

      fail()
    } catch {}
  }

  func testThrowErrorIfFilePathIsInvalid() {
    do {
      try rarExtractor.extract(
        URL(string: "fail/path")!,
        to: tempDirectory
      )

      fail()
    } catch {}
  }

  func testThrowErrorIfDestinationIsInvalid() {
    do {
      try rarExtractor.extract(
        failRarFilePath,
        to: URL(string: "fail/destination")!
      )

      fail()
    } catch {}
  }

}
