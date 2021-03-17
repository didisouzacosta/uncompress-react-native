//
//  String+Extension.swift
//  UncompressExampleTests
//
//  Created by Adriano Souza Costa on 15/03/21.
//

import Foundation

extension String {

  var fileName: String {
    return (self as NSString).lastPathComponent
  }

}

extension String: LocalizedError {

    public var errorDescription: String? {
        return self
    }

}
