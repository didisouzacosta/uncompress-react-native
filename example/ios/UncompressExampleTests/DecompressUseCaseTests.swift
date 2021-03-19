//
//  DecompressUseCaseTests.swift
//  UncompressExampleTests
//
//  Created by Adriano Souza Costa on 19/03/21.
//

import XCTest
import Nimble
import uncompress

class DecompressUseCaseTests: XCTestCase {
  
  private let engine = ExtractableSpy()
  
  func testEnsureCompatibilities() throws {
    let rarEngine = ExtractableSpy()
    let zipEngine = ExtractableSpy()
    
    zipEngine.compatibilities = [.zip, .cbz]
    rarEngine.compatibilities = [.rar, .cbr]
    
    let useCase = DecompressUseCase(engines: [zipEngine, rarEngine])
    
    expect(useCase.compatibilities) == [.zip, .cbz, .rar, .cbr]
  }

}
