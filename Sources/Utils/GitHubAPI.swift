//
//  GitHubAPI.swift
//  
//
//  Created by scchn on 2023/4/29.
//

import Foundation
import Combine
import UniformTypeIdentifiers

enum GitHubAPIError: LocalizedError {
    case decodingError
    case invalidFile
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .decodingError: return "Error decoding data."
        case .invalidFile:   return "Invalid file."
        case .unknown:       return "Unknown"
        }
    }
}

enum GitHubAPI {
    
    private static func fetch<Target, Decoder>(_ type: Target.Type, from url: URL, decoder: Decoder) async throws -> Target
    where Target: Decodable, Decoder: TopLevelDecoder, Decoder.Input == Data {
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            let error = try? JSONDecoder().decode(GitHubError.self, from: data)
            
            throw error ?? GitHubAPIError.unknown
        }
        
        do {
            return try decoder.decode(Target.self, from: data)
        } catch {
            throw GitHubAPIError.decodingError
        }
    }
    
    static func fetchFileList(user: String, repo: String, folder: String? = nil) async throws -> [GitHubFile] {
        let url = URL(string: "https://api.github.com/repos/\(user)/\(repo)/contents")!
            .appending(component: folder ?? "")
        
        return try await fetch([GitHubFile].self, from: url, decoder: JSONDecoder())
            .filter { $0.downloadURL?.pathExtension == "codesnippet" }
    }
    
    static func fetchCodeSnippet(from file: GitHubFile) async throws -> CodeSnippet {
        guard let url = file.downloadURL else {
            throw GitHubAPIError.invalidFile
        }
        
        return try await fetch(CodeSnippet.self, from: url, decoder: PropertyListDecoder())
    }
    
}
