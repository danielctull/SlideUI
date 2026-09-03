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

        return """
            Code { \(literal: closure.formattedContents) }
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
                \(literal: closure.formattedContents)
            } preview: {
                \(closure.statements)
            }
            """
    }
}

extension ClosureExprSyntax {

  var formattedContents: String {
    String(description.dropFirst().dropLast())
  }
}
