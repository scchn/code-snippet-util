//
//  GitHubFile.swift
//  
//
//  Created by scchn on 2023/4/29.
//

import Foundation

extension GitHubFile: Codable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case path
        case sha
        case size
        case url
        case htmlURL     = "html_url"
        case gitURL      = "git_url"
        case downloadURL = "download_url"
        case type
    }
    
}

struct GitHubFile {
    var name: String
    var path: String
    var sha: String
    var size: Int
    var url: URL
    var htmlURL: URL
    var gitURL: URL
    var downloadURL: URL?
    var type: String
}
