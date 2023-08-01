
import SwiftSyntax
import SwiftSyntaxMacros

struct Failure: Error {
    let description: String
}

public struct SourceMacro: ExpressionMacro {

    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {

        guard let closure = node.trailingClosure else {
            throw Failure(description: "Does not have a trailing closure.")
        }

        return """
            Source(source: \(literal: closure.statements.map(\.trimmedDescription).joined(separator: "\n")))
            """
    }
}
