
import ArgumentParser
import Foundation
import XcodeTheme

@main
struct XcodeThemeConvertor: ParsableCommand {

    @Argument(help: "The name of the theme.")
    var name: Name

    @Argument(help: "The location of the theme.")
    var path: Path

    func run() throws {
        let fm = FileManager()
        let theme = try Theme(Data(contentsOf: path.url))
        try ThemeDefinition(name: name, theme: theme)
            .write(in: fm.currentDirectory)
    }
}

// MARK: - Name

extension Name: ExpressibleByArgument {

    init?(argument: String) {
        self.init(value: argument)
    }
}

// MARK: - Path

struct Path: ExpressibleByArgument {
    let url: URL
    init?(argument: String) {
        url = URL(filePath: argument, relativeTo: FileManager().currentDirectory)
    }
}

// MARK: - FileManager

extension FileManager {

    fileprivate var currentDirectory: URL {
        URL(fileURLWithPath: currentDirectoryPath)
    }
}
