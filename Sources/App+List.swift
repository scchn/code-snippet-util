//
//  App+List.swift
//  
//
//  Created by scchn on 2023/4/29.
//

import Foundation
import ArgumentParser

extension App {
    
    struct List: AsyncParsableCommand {
        
        static var configuration = CommandConfiguration(abstract: "List all code snippets.")
        
        @Argument(help: "GitHub user name")
        var user: String
        
        @Argument(help: "GitHub repo name")
        var repo: String
        
        @Option(help: "Folder path")
        var folder: String?
        
        @Flag(help: "Code snippet details")
        var details: Bool = false
        
        func run() async throws {
            try await listRemoteCodeSnippets()
        }
        
        private func listRemoteCodeSnippets() async throws {
            print("💠 Fetching file list...")
            print()
            
            let files: [GitHubFile] = try await GitHubAPI.fetchFileList(user: user, repo: repo, folder: folder)
            
            guard !files.isEmpty else {
                print("🫨 No code snippets found.")
                Self.exit()
            }
            
            print("🤩 Found \(files.count) file\(files.count > 1 ? "s" : "").")
            
            for (index, file) in files.enumerated() {
                if details {
                    print()
                    print("[\(index + 1)] \(file.name)")
                    
                    do {
                        let codeSnippet = try await GitHubAPI.fetchCodeSnippet(from: file)
                        
                        printCodeSnippetInfo(codeSnippet)
                    } catch {
                        print("  ERROR: \(error.localizedDescription)")
                    }
                } else {
                    let spacing = files.count.description.count
                    let numberText = String(format: "%\(spacing)d", index + 1)
                    
                    if index == 0 {
                        print()
                    }
                    
                    print("[\(numberText)] \(file.name)")
                }
            }
        }
        
        private func printCodeSnippetInfo(_ codeSnippet: CodeSnippet) {
            let placeholder = "<Empty>"
            let completionScopesDescription = (
                codeSnippet.completionScopes.isEmpty
                ? placeholder
                : codeSnippet.completionScopes.map(\.description).joined(separator: ", ")
            )
            
            print("""
              Title:        \(codeSnippet.title.ifEmpty(placeholder))
              Summary:      \(codeSnippet.summary.ifEmpty(placeholder))
              Platform:     \(codeSnippet.platformFamily?.description ?? "All")
              Completion:   \(codeSnippet.completion.ifEmpty(placeholder))
              Availability: \(completionScopesDescription)
            """)
        }
        
    }
    
}
