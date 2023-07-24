
import SwiftSyntax
import SwiftSyntaxMacros

public struct CodeOutputMacro: ExpressionMacro {

    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) -> ExprSyntax {

        guard let argument = node.argumentList.first?.expression else {
            fatalError("compiler bug: the macro does not have any arguments")
        }

        return """
            CodeOutputView {
                \(argument)
            } code: {
                \(literal: argument.description)
            }
            """
    }
}
