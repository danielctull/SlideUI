
import FileBuilder
import XcodeTheme

struct ThemeDefinition: File {

    let name: Name
    let theme: Theme

    var file: some File {
        TextFile(name.filename) {
            """

            import SlideUI
            import SwiftUI

            extension CodeHighlighting where Self == \(name) {
                public static var \(name.property): \(name) { \(name)() }
            }

            public struct \(name): CodeHighlighting {

            """
            Group {
                "public func color(for token: Token) -> Color {"
                Group {
                    "switch token.classification {"
                    Attribute(name: "attribute", color: theme.textSyntaxColors.attribute)
                    Attribute(name: "character", color: theme.textSyntaxColors.character)
                    Attribute(name: "comment", color: theme.textSyntaxColors.comment)
                    Attribute(name: "commentDoc", color: theme.textSyntaxColors.commentDoc)
                    Attribute(name: "commentDocKeyword", color: theme.textSyntaxColors.commentDocKeyword)
                    Attribute(name: "declarationOther", color: theme.textSyntaxColors.declarationOther)
                    Attribute(name: "declarationType", color: theme.textSyntaxColors.declarationType)
                    Attribute(name: "identifierClass", color: theme.textSyntaxColors.identifierClass)
                    Attribute(name: "identifierClassSystem", color: theme.textSyntaxColors.identifierClassSystem)
                    Attribute(name: "identifierConstant", color: theme.textSyntaxColors.identifierConstant)
                    Attribute(name: "identifierConstantSystem", color: theme.textSyntaxColors.identifierConstantSystem)
                    Attribute(name: "identifierFunction", color: theme.textSyntaxColors.identifierFunction)
                    Attribute(name: "identifierFunctionSystem", color: theme.textSyntaxColors.identifierFunctionSystem)
                    Attribute(name: "identifierMacro", color: theme.textSyntaxColors.identifierMacro)
                    Attribute(name: "identifierMacroSystem", color: theme.textSyntaxColors.identifierMacroSystem)
                    Attribute(name: "identifierType", color: theme.textSyntaxColors.identifierType)
                    Attribute(name: "identifierTypeSystem", color: theme.textSyntaxColors.identifierTypeSystem)
                    Attribute(name: "identifierVariable", color: theme.textSyntaxColors.identifierVariable)
                    Attribute(name: "identifierVariableSystem", color: theme.textSyntaxColors.identifierVariableSystem)
                    Attribute(name: "keyword", color: theme.textSyntaxColors.keyword)
                    Attribute(name: "mark", color: theme.textSyntaxColors.mark)
                    Attribute(name: "markupCode", color: theme.textSyntaxColors.markupCode)
                    Attribute(name: "number", color: theme.textSyntaxColors.number)
                    Attribute(name: "plain", color: theme.textSyntaxColors.plain)
                    Attribute(name: "preprocessor", color: theme.textSyntaxColors.preprocessor)
                    Attribute(name: "regex", color: theme.textSyntaxColors.regex)
                    Attribute(name: "regexCapturename", color: theme.textSyntaxColors.regexCapturename)
                    Attribute(name: "regexCharname", color: theme.textSyntaxColors.regexCharname)
                    Attribute(name: "regexNumber", color: theme.textSyntaxColors.regexNumber)
                    Attribute(name: "regexOther", color: theme.textSyntaxColors.regexOther)
                    Attribute(name: "string", color: theme.textSyntaxColors.string)
                    Attribute(name: "url", color: theme.textSyntaxColors.url)
                    "default: Color(red: 0, green: 0, blue: 0, opacity: 0.85)"
                    "}"
                }.indent()
                "}"
            }.indent()
            "}"
        }
    }
}

struct Attribute: Text {
    let name: String
    let color: Color

    var text: some Text {
        "case .\(name): Color(red: \(color.red), green: \(color.green), blue: \(color.blue), opacity: \(color.opacity))"
    }
}

// MARK: - Name

struct Name {
    let value: String

    var property: String {
        guard let first = value.first?.lowercased() else { return "" }
        return String("\(first)\(value.dropFirst())")
    }

    var filename: String {
        value + ".swift"
    }
}

extension Name: CustomStringConvertible {
    var description: String { value }
}
