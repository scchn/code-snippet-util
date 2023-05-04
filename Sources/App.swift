import Foundation
import ArgumentParser

@main
struct App: AsyncParsableCommand {
    
    static var configuration = CommandConfiguration(
        commandName: "csdl",
        abstract: "Code Snippet Util",
        subcommands: [Update.self, List.self]
    )
    
}
