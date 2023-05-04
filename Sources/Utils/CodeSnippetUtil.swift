//
//  CodeSnippetUtil.swift
//  
//
//  Created by scchn on 2023/4/29.
//

import Foundation
import UniformTypeIdentifiers

extension CodeSnippetUtil {
    enum UpdateResult {
        case update
        case add
    }
}

struct CodeSnippetUtil {
    
    static let shared = CodeSnippetUtil()
    
    let codeSnippetsDirURL: URL
    
    private init() {
        let libDirURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0]
        let codeSnippetsDirURL = libDirURL.appending(component: "Developer/Xcode/UserData/CodeSnippets")
        
        self.codeSnippetsDirURL = codeSnippetsDirURL
    }
    
    func checkCodeSnippetsDir() -> Bool {
        let found = FileManager.default.fileExists(atPath: codeSnippetsDirURL.path())
        let isDir = (try? codeSnippetsDirURL.resourceValues(forKeys: [.isDirectoryKey]).isDirectory) ?? false
        
        return found && isDir
    }
    
    func update(fileName: String, codeSnippet: CodeSnippet) throws -> (URL, UpdateResult) {
        let fileURL = codeSnippetsDirURL
            .appending(component: fileName)
        let isUpdate = FileManager.default.fileExists(atPath: fileURL.path())
        let encoder = PropertyListEncoder()
        
        encoder.outputFormat = .xml
        
        let fileContents = try encoder.encode(codeSnippet)
        
        try fileContents.write(to: fileURL)
        
        return (fileURL, isUpdate ? .update : .add)
    }
    
}
