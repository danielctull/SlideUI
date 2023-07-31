
import SwiftSyntax
import SwiftSyntaxMacros

public struct SourceMacro: ExpressionMacro {

    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) -> ExprSyntax {

        guard let argument = node.argumentList.first?.expression else {
            fatalError("compiler bug: the macro does not have any arguments")
        }

        return """
            Source(source: \(literal: argument.description))
            """
    }
}
