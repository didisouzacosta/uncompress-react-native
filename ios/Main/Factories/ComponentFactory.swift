//
//  ComponentFactory.swift
//  Uncompress
//
//  Created by Adriano Souza Costa on 05/05/21.
//

import Foundation

final class ComponentFactory {
    
    static func uncompressUseCase() -> Uncompress {
        let extractUseCase = UseCaseFactory.extractUseCase()
        let isProtectedUseCase = UseCaseFactory.isProtectedUseCase()
        
        return Uncompress(
            extractUseCase: extractUseCase,
            isProctedUseCase: isProtectedUseCase
        )
    }
    
}
