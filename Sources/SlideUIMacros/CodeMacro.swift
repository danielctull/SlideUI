
import SwiftSyntax
import SwiftSyntaxMacros

public struct CodeMacro: ExpressionMacro {

    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {

        guard let closure = node.trailingClosure else {
            throw Failure(description: "Does not have a trailing closure.")
        }

        return """
            Code {
                \(closure.statements)
            } code: {
                #LegacyCode {
                    \(closure.statements)
                }
            }
            """
    }
}
