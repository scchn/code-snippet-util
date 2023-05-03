//
//  App+Update.swift
//  
//
//  Created by scchn on 2023/4/29.
//

import Foundation
import ArgumentParser

extension App {
    
    enum UpdateError: LocalizedError {
        case codeSnippetsDirNotFound
        
        var errorDescription: String? {
            switch self {
            case .codeSnippetsDirNotFound:
                let path = CodeSnippetUtil.shared.codeSnippetsDirURL.path()
                
                return "\"\(path)\" not found."
            }
        }
    }
    
    struct Update: AsyncParsableCommand {
        
        static var configuration = CommandConfiguration(abstract: "Update code snippets.")
        
        @Argument(help: "GitHub user name")
        var user: String
        
        @Argument(help: "GitHub repo name")
        var repo: String
        
        @Option(help: "Folder path")
        var folder: String?
        
        func run() async throws {
            guard CodeSnippetUtil.shared.checkCodeSnippetsDir() else {
                Self.exit(withError: UpdateError.codeSnippetsDirNotFound)
            }
            
            print("💠 Fetching file list...")
            print()
            
            let files: [GitHubFile] = try await GitHubAPI.fetchFileList(user: user, repo: repo, folder: folder)
            
            guard !files.isEmpty else {
                print("🫨 No code snippets found.")
                Self.exit()
            }
            
            print("🤩 Found \(files.count) code snippet\(files.count > 1 ? "s" : "").")
            
            for file in files {
                print()
                await downloadAndUpdateCodeSnippet(from: file)
            }
            
            print()
            print("🎉 Finished updating code snippets!")
        }
        
        private func downloadAndUpdateCodeSnippet(from file: GitHubFile) async {
            print("💠 Downloading \(file.name)...")
            
            do {
                let codeSnippet = try await GitHubAPI.fetchCodeSnippet(from: file)
                let (url, result) = try CodeSnippetUtil.shared.update(fileName: file.name, codeSnippet: codeSnippet)
                
                if result == .update {
                    print("  [*] \(url.path())")
                } else {
                    print("  [+] \(url.path())")
                }
            } catch {
                print("  ERROR: \(error.localizedDescription)")
            }
        }
        
    }
    
}
