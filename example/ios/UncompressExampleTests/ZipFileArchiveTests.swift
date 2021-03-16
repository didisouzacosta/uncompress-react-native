//
//  ZipFileArchiveTests.swift
//  UncompressExampleTests
//
//  Created by Adriano Souza Costa on 14/03/21.
//

import XCTest
import Nimble
import uncompress

class ZipFileArchiveTests: XCTestCase {
    
  private let fileManager = FileManager()
  private let tempDirectory = NSTemporaryDirectory()
  
  private var defaultFile: String {
    return Bundle.test.path(forResource: "mononoke", ofType: "jpg")!
  }
  
  private var zipFilePath: String {
    return Bundle.test.path(forResource: "mononoke", ofType: "zip")!
  }
  
  private var protectedZipFilePath: String {
    return Bundle.test.path(forResource: "mononoke_protected", ofType: "zip")!
  }
  
  private var failZipFilePath: String {
    return Bundle.test.path(forResource: "zip_fail", ofType: "zip")!
  }
  
  override func setUp() {
    do {
      try fileManager.clearTempDirectory()
    } catch {
      print(error)
    }
  }

  func testExtractFileIfDecompressSucessful() throws {
    try ZipFileArquive.decompress(
      zipFilePath,
      to: tempDirectory
    )
    
    let contents = try fileManager.contentsOfDirectory(atPath: tempDirectory)
    
    expect(contents.contains("mononoke.jpg")) == true
  }
  
  func testExtractFileIfDecompressWithPasswordSucessful() throws {
    var progressSpy: Double = 0
    
    try ZipFileArquive.decompress(
      protectedZipFilePath,
      to: tempDirectory,
      password: "123"
    ) { progress in
      progressSpy = progress
    }
    
    let contents = try fileManager.contentsOfDirectory(atPath: tempDirectory)
    
    expect(contents.contains("mononoke.jpg")) == true
    expect(progressSpy) == 1
  }
  
  func testThrowErrorIfExtractFileIfDecompressFails() {
    do {
      try ZipFileArquive.decompress(
        failZipFilePath,
        to: tempDirectory
      )
      
      fail()
    } catch {
      expect(error.localizedDescription) == "The operation couldn’t be completed. (Zip.ZipError error 1.)"
    }
  }
  
  func testGenerateZipFileIfCompressSucessful() throws {
    var progressSpy: Double = 0
    
    try ZipFileArquive.compress(
      defaultFile,
      to: tempDirectory
    ) { progress in
        progressSpy = progress
    }

    let contents = try fileManager.contentsOfDirectory(atPath: tempDirectory)

    expect(contents) == ["mononoke.zip"]
    expect(progressSpy) == 1
  }
  
  func testGenerateZipProtectedFileIfCompressSucessful() throws {
    var progressSpy: Double = 0
    
    try ZipFileArquive.compress(
      defaultFile,
      to: tempDirectory,
      password: "1234"
    ) { progress in
        progressSpy = progress
    }
    
    let contents = try fileManager.contentsOfDirectory(atPath: tempDirectory)
    
    expect(contents) == ["mononoke.zip"]
    expect(progressSpy) == 1
  }

}
