//
//  ZipExtractor.swift
//  uncompress
//
//  Created by Adriano Souza Costa on 14/03/21.
//

import Foundation
import Zip

public final class ZipExtractor: Extractable {
    
    public var compatibilities: [Compatibility] {
        return [.zip, .cbz]
    }
    
    public init() {}
    
    public func extract(
        _ filePath: URL,
        to destination: URL,
        overwrite: Bool = false,
        password: String? = nil
    ) throws {
        try Zip.unzipFile(
            filePath,
            destination: destination,
            overwrite: overwrite,
            password: password
        )
    }
    
    public func isProtected(_ filePath: URL) throws -> Bool {
        
//        NSInteger chunkSize = 1024     //Read 1KB chunks.
//        NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
//        NSData *fileData = [handle readDataOfLength:chunkSize];
//        NSData* generalBitFlag = [fileData subdataWithRange:NSMakeRange(6, 2)];
//        NSString* genralBitFlgStr = [generalBitFlag description];
//
//
//        if ([genralBitFlgStr characterAtIndex:2]!='0')
//        {
//            return true;
//        }
//        else
//        {
//            return false;
//        }
        
//        let chunkSize = 1024
//        let handle = NSFilehandle
        
        return true
    }
    
}
