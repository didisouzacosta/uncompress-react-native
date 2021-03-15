//
//  FileManager+Extension.swift
//  UncompressExampleTests
//
//  Created by Adriano Souza Costa on 15/03/21.
//

import Foundation

extension FileManager {
  
  func clearTempDirectory() throws {
    let contents = try contentsOfDirectory(atPath: NSTemporaryDirectory())
    try contents.forEach { file in
      try removeItem(atPath: file)
    }
  }
  
}
