//
//  RarExtractorTests.swift
//  UncompressExampleTests
//
//  Created by Adriano Souza Costa on 14/03/21.
//

import XCTest
import Nimble
import uncompress

class RarExtractorTests: XCTestCase {
    
  private let fileManager = FileManager()
  private let tempDirectory = NSTemporaryDirectory()
  private let rarExtractor = RarExtractor()
  
  private var defaultFile: String {
    return Bundle.test.path(forResource: "zelda", ofType: "jpeg")!
  }
  
  private var rarFilePath: String {
    return Bundle.test.path(forResource: "zelda", ofType: "rar")!
  }
  
  private var protectedRarFilePath: String {
    return Bundle.test.path(forResource: "zelda_protected", ofType: "cbr")!
  }
  
  private var failRarFilePath: String {
    return Bundle.test.path(forResource: "rar_fail", ofType: "rar")!
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

  func testExtractFileIfDecompressSucessful() throws {
    try rarExtractor.extract(
      rarFilePath,
      to: tempDirectory
    )
    
    let contents = try fileManager.contentsOfDirectory(atPath: tempDirectory)
    
    expect(contents.contains("zelda.jpeg")) == true
  }
  
  func testExtractFileIfDecompressWithPasswordSucessful() throws {
    var progressSpy: Double = 0
    
    try rarExtractor.extract(
      protectedRarFilePath,
      to: tempDirectory,
      password: "123"
    ) { progress in
      progressSpy = progress
    }
    
    let contents = try fileManager.contentsOfDirectory(atPath: tempDirectory)
    
    expect(contents.contains("zelda.jpeg")) == true
    expect(progressSpy) == 1
  }
  
  func testThrowErrorIfExtractFileIfDecompressFails() {
    do {
      try rarExtractor.extract(
        failRarFilePath,
        to: tempDirectory
      )
      
      fail()
    } catch {
      expect(error.localizedDescription) == "File is not a valid RAR archive"
    }
  }

}
