//
//  FileUncompress.swift
//  uncompress
//
//  Created by Adriano Souza Costa on 17/03/21.
//

import Foundation

final class FileUncompress {
        
    // MARK: - Private Properties
    
    private let _engines: [Extractable]
    
    // MARK: - Public Methods
    
    public init(engines: [Extractable]) {
        self._engines = engines
    }
    
}

extension FileUncompress: Uncompress {
    
    var engines: [Extractable] {
        return _engines
    }
    
}
