
import SwiftFormat
import SwiftSyntax
import SwiftSyntaxMacros

struct Failure: Error {
    let description: String
}

public struct CodeMacro: ExpressionMacro {

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
            Code(\(literal: output))
            """
    }
}
