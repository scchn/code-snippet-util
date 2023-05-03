//
//  GitHubError.swift
//  
//
//  Created by scchn on 2023/5/3.
//

import Foundation

extension GitHubError {
    
    enum CodingKeys: String, CodingKey {
        case message
        case documentationURL = "documentation_url"
    }
    
}

struct GitHubError: LocalizedError, Codable {
    
    var message: String
    var documentationURL: String
    var errorDescription: String? {
        message
    }
    
}
