//
//  FileDescriptor.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 23/10/2023.
//

import Foundation

struct FileDescriptor: ~Copyable {
    
    private var fd: Int
    
    init(_ fd: Int) {
        self.fd = fd
    }
    
    func write(bytes: [Int8]) {
        //FileWrite(fd, bytes)
    }
    
    consuming func close() {
        //FileClose(fd)
        self.fd = 0
    }
}
