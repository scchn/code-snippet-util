//
//  CodeSnippet.swift
//  
//
//  Created by scchn on 2023/4/29.
//

import Foundation

extension CodeSnippet: Codable {
    
    enum CodingKeys: String, CodingKey {
        case identifier       = "IDECodeSnippetIdentifier"
        case version          = "IDECodeSnippetVersion"
        case userSnippet      = "IDECodeSnippetUserSnippet"
        case language         = "IDECodeSnippetLanguage"
        case platformFamily   = "IDECodeSnippetPlatformFamily"
        case title            = "IDECodeSnippetTitle"
        case summary          = "IDECodeSnippetSummary"
        case contents         = "IDECodeSnippetContents"
        case completion       = "IDECodeSnippetCompletionPrefix"
        case completionScopes = "IDECodeSnippetCompletionScopes"
    }
    
    enum CompletionScopes: String, Codable, CustomStringConvertible {
        case topLevel            = "TopLevel"
        case codeExpression      = "CodeExpression"
        case classImplementation = "ClassImplementation"
        case codeBlock           = "CodeBlock"
        case stringOrComment     = "StringOrComment"
        case all                 = "All"
        
        var description: String {
            switch self {
            case .topLevel:            return "Top Level"
            case .codeExpression:      return "Code Expression"
            case .classImplementation: return "Class Implementation"
            case .codeBlock:           return "Function or Method"
            case .stringOrComment:     return "String or Comment"
            case .all:                 return "All"
            }
        }
    }
    
    enum PlatformFamily: String, Codable, CustomStringConvertible {
        case iOS       = "iphoneos"
        case macOS     = "macosx"
        case tvOS      = "appletvos"
        case watchOS   = "watchos"
        case driverKit = "driverkit"
        
        var description: String {
            switch self {
            case .iOS:       return "iOS"
            case .macOS:     return "macOS"
            case .driverKit: return "Driver Kit"
            case .tvOS:      return "tvOS"
            case .watchOS:   return "watchOS"
            }
        }
    }
    
}

struct CodeSnippet {
    var identifier: UUID = .init()
    var version: Int = 2
    var userSnippet: Bool = true
    var language: String = "Xcode.SourceCodeLanguage.Swift"
    var platformFamily: PlatformFamily?
    var title: String
    var summary: String
    var contents: String
    var completion: String
    var completionScopes: [CompletionScopes]
}
