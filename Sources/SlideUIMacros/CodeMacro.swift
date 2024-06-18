import SwiftFormat
import SwiftSyntax
import SwiftSyntaxMacros

struct Failure: Error {
    let description: String
}

public struct LegacyCodeMacro: ExpressionMacro {

    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {

        guard let closure = node.trailingClosure else {
            throw Failure(description: "Does not have a trailing closure.")
        }

        var output = ""
        let formatter = SwiftFormatter(configuration: .init())
        let file = SourceFileSyntax(statements: closure.statements)
        try formatter.format(syntax: file, operatorTable: .init(), assumingFileURL: nil, to: &output)

        return """
            LegacyCode { \(literal: output) }
            """
    }
}

public struct CodePreviewMacro: ExpressionMacro {

    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {

        guard let closure = node.trailingClosure else {
            throw Failure(description: "Does not have a trailing closure.")
        }

        return """
            Code {
                #LegacyCode {
                    \(closure.statements)
                }
            } preview: {
                \(closure.statements)
            }
            """
    }
}
