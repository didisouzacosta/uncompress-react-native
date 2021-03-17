//
//  String+Extension.swift
//  Pods
//
//  Created by Adriano Souza Costa on 16/03/21.
//

import Foundation

extension String: LocalizedError {
    
    public var errorDescription: String? {
        return self
    }
    
}
