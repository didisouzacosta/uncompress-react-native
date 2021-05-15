//
//  ExtractableSpy.swift
//  UncompressExampleTests
//
//  Created by Adriano Souza Costa on 19/03/21.
//

import Foundation
import Uncompress

final class ExtractableSpy: Extractable {
  
  var compatibilities: [Compatibility] = []
  var filePath: URL?
  var destination: URL?
  var overwrite: Bool?
  var password: String?
  var isProtected: Bool?
  var error: Error?

  func extract(
    _ filePath: URL,
    to destination: URL,
    overwrite: Bool,
    password: String?
  ) throws {
    self.filePath = filePath
    self.destination = destination
    self.overwrite = overwrite
    self.password = password
    
    if let error = error {
      throw error
    }
  }
  
  func isProtected(_ filePath: URL) throws -> Bool {
    self.filePath = filePath
    
    if let error = error {
      throw error
    }
    
    return isProtected ?? false
  }

}
