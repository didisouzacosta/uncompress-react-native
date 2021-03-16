//
//  RarFileArchiveTests.swift
//  UncompressExampleTests
//
//  Created by Adriano Souza Costa on 14/03/21.
//

import XCTest
import Nimble
import uncompress

class RarFileArchiveTests: XCTestCase {
    
  private let fileManager = FileManager()
  private let tempDirectory = NSTemporaryDirectory()
  
  private var defaultFile: String {
    return Bundle.test.path(forResource: "zelda", ofType: "jpeg")!
  }
  
  private var rarFilePath: String {
    return Bundle.test.path(forResource: "zelda", ofType: "rar")!
  }
  
  private var protectedRarFilePath: String {
    return Bundle.test.path(forResource: "zelda_protected", ofType: "rar")!
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

  func testExtractFileIfDecompressSucessful() throws {
    try RarFileArchive.decompress(
      rarFilePath,
      to: tempDirectory
    )
    
    let contents = try fileManager.contentsOfDirectory(atPath: tempDirectory)
    
    expect(contents.contains("zelda.jpeg")) == true
  }
  
  func testExtractFileIfDecompressWithPasswordSucessful() throws {
    var progressSpy: Double = 0
    
    try RarFileArchive.decompress(
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
      try RarFileArchive.decompress(
        failRarFilePath,
        to: tempDirectory
      )
      
      fail()
    } catch {
      expect(error.localizedDescription) == "The operation couldn’t be completed. (Zip.ZipError error 1.)"
    }
  }
  
  func testGenerateZipFileIfCompressSucessful() throws {
    var progressSpy: Double = 0
    
    try RarFileArchive.compress(
      defaultFile,
      to: tempDirectory
    ) { progress in
        progressSpy = progress
    }

    let contents = try fileManager.contentsOfDirectory(atPath: tempDirectory)

    expect(contents) == ["zelda.rar"]
    expect(progressSpy) == 1
  }
  
  func testGenerateZipProtectedFileIfCompressSucessful() throws {
    var progressSpy: Double = 0
    
    try RarFileArchive.compress(
      defaultFile,
      to: tempDirectory,
      password: "1234"
    ) { progress in
        progressSpy = progress
    }
    
    let contents = try fileManager.contentsOfDirectory(atPath: tempDirectory)
    
    expect(contents) == ["zelda.rar"]
    expect(progressSpy) == 1
  }

}
