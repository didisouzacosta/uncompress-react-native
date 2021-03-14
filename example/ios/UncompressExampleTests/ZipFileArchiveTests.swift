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
  
  private var zipFilePath: String {
    return Bundle.test!.path(forResource: "mononoke", ofType: "zip")!
  }
  
  private var protectedZipFilePath: String {
    return Bundle.test!.path(forResource: "mononoke_protected", ofType: "zip")!
  }

  func testShouldBeReturnFalseToIsFilePasswordProtectedWhenFileIsNotProtected() throws {
    let status = zip.isFilePasswordProtected(zipFilePath)
    expect(status) == false
  }
  
  func testShouldBeReturnTrueToIsFilePasswordProtectedWhenFileIsProtected() throws {
    let status = zip.isFilePasswordProtected(protectedZipFilePath)
    expect(status) == true
  }

}
