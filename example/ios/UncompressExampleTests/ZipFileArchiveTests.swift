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
    
  private let zip = ZipFileArquive()
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
  
  override func setUp() {
    do {
      try fileManager.clearTempDirectory()
    } catch {
      print(error)
    }
  }

  func testShouldBeReturnFalseToIsFilePasswordProtectedWhenFileIsNotProtected() throws {
    let status = zip.isFilePasswordProtected(zipFilePath)
    expect(status) == false
  }
  
  func testShouldBeReturnTrueToIsFilePasswordProtectedWhenFileIsProtected() throws {
    let status = zip.isFilePasswordProtected(protectedZipFilePath)
    expect(status) == true
  }
  
  func testExtractFileIfDecompressSucessful() throws {
    try zip.decompress(
      zipFilePath,
      to: tempDirectory
    )
    
    let contents = try fileManager.contentsOfDirectory(atPath: tempDirectory)
    
    expect(contents) == ["mononoke.jpg"]
  }
  
  func testCompressFileIfCompressSucessful() throws {
//    try zip.compress(defaultFile, to: tempDirectory)

    let contents = try fileManager.contentsOfDirectory(atPath: tempDirectory)

    expect(contents) == ["mononoke.zip"]
  }

}
