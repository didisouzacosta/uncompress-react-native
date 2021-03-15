//
//  FileManager+Extension.swift
//  UncompressExampleTests
//
//  Created by Adriano Souza Costa on 15/03/21.
//

import Foundation

extension FileManager {
  
  func clearTempDirectory() throws {
    let tempDirectory = NSTemporaryDirectory()
    let contents = try contentsOfDirectory(atPath: tempDirectory)
    try contents.forEach { file in
      try removeItem(atPath: tempDirectory + file)
    }
  }
  
}
