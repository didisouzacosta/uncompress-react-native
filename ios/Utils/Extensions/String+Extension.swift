//
//  String+Extension.swift
//  DoubleConversion
//
//  Created by Adriano Souza Costa on 18/03/21.
//

import Foundation

extension String {
    
    var fileExtension: String? {
        let lastPath = (self as NSString).lastPathComponent
        
        guard let fileExtension = lastPath.split(separator: ".").last else {
            return nil
        }
        
        return String(fileExtension)
    }
    
}

extension String: LocalizedError {
    
    public var errorDescription: String? {
        return self
    }
    
}
