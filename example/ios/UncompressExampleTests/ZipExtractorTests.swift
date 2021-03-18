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
  private let tempDirectory = URL(string: NSTemporaryDirectory())!
  private let zipExtractor = ZipExtractor()
  
  private var defaultFile: URL {
    let path = Bundle.test.path(forResource: "mononoke", ofType: "jpg")!
    return URL(string: path)!
  }
  
  private var zipFilePath: URL {
    let path = Bundle.test.path(forResource: "mononoke", ofType: "zip")!
    return URL(string: path)!
  }
  
  private var protectedZipFilePath: URL {
    let path = Bundle.test.path(forResource: "mononoke_protected", ofType: "cbz")!
    return URL(string: path)!
  }
  
  private var failZipFilePath: URL {
    let path = Bundle.test.path(forResource: "zip_fail", ofType: "zip")!
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
    let compatibilities = zipExtractor.compatibilities
    expect(compatibilities) == [.zip, .cbz]
  }

  func testExtractFileIfDecompressSucessful() throws {
    try zipExtractor.extract(
      zipFilePath,
      to: tempDirectory
    )
    
    let contents = try fileManager.contentsOfDirectory(atPath: tempDirectory.absoluteString)
    
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
    
    let contents = try fileManager.contentsOfDirectory(atPath: tempDirectory.absoluteString)
    
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
    } catch {}
  }
  
  func testThrowErrorIfFilePathIsInvalid() {
    do {
      try zipExtractor.extract(
        URL(string: "fail/path")!,
        to: tempDirectory
      )
      
      fail()
    } catch {}
  }
  
  func testThrowErrorIfDestinationIsInvalid() {
    do {
      try zipExtractor.extract(
        failZipFilePath,
        to: URL(string: "fail/destination")!
      )
      
      fail()
    } catch {}
  }

}
