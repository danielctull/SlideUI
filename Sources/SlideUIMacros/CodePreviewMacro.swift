
import SwiftSyntax
import SwiftSyntaxMacros

public struct CodePreviewMacro: ExpressionMacro {

    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {

        guard let closure = node.trailingClosure else {
            throw Failure(description: "Does not have a trailing closure.")
        }

        return """
            CodePreview {
                \(closure.statements)
            } code: {
                \(literal: closure.statements.description)
            }
            """
    }
}
