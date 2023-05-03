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
        FileManager.default.fileExists(atPath: codeSnippetsDirURL.path())
    }
    
    func codeSnippets() -> [(URL, CodeSnippet)] {
        let enumerator = FileManager.default.enumerator(at: codeSnippetsDirURL, includingPropertiesForKeys: nil)
        let urls = (enumerator?.allObjects as? [URL] ?? [])
            .filter { url in
                UTType(filenameExtension: url.pathExtension) == .codeSnippet
            }
        
        return urls
            .compactMap { url -> (URL, CodeSnippet)? in
                guard let data = try? Data(contentsOf: url),
                      let codeSnippet = try? PropertyListDecoder().decode(CodeSnippet.self, from: data)
                else {
                    return nil
                }
                return (url, codeSnippet)
            }
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
