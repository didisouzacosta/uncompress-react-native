//
//  ZipExtractorTests.swift
//  UncompressExampleTests
//
//  Created by Adriano Souza Costa on 14/03/21.
//

import XCTest
import Nimble
import uncompress

class ZipExtractorTests: XCTestCase {
    
  private let fileManager = FileManager()
  private let tempDirectory = NSTemporaryDirectory()
  private let zipExtractor = ZipExtractor()
  
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
    try zipExtractor.extract(
      zipFilePath,
      to: tempDirectory
    )
    
    let contents = try fileManager.contentsOfDirectory(atPath: tempDirectory)
    
    expect(contents.contains("mononoke.jpg")) == true
  }
  
  func testExtractFileIfDecompressWithPasswordSucessful() throws {
    var progressSpy: Double = 0
    
    try zipExtractor.extract(
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
      try zipExtractor.extract(
        failZipFilePath,
        to: tempDirectory
      )
      
      fail()
    } catch {
      expect(error.localizedDescription) == "The operation couldn’t be completed. (Zip.ZipError error 1.)"
    }
  }

}
