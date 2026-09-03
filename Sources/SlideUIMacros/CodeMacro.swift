import Foundation
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

        return """
            Code { \(literal: try closure.formattedContents()) }
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
                \(literal: try closure.formattedContents())
            } preview: {
                \(closure.statements)
            }
            """
    }
}

extension ClosureExprSyntax {

  func formattedContents() throws -> String {
    var formatted = ""
    let formatter = SwiftFormatter(configuration: .init())
    let file = SourceFileSyntax(statements: statements)
    try formatter.format(syntax: file, operatorTable: .init(), assumingFileURL: nil, to: &formatted)

    let source = String(description.dropFirst().dropLast())
    let sourceLines = source.split(separator: "\n", omittingEmptySubsequences: false)
    var formattedLines = formatted.split(separator: "\n", omittingEmptySubsequences: false).map(String.init)
    var searchStart = formattedLines.startIndex

    for sourceLine in sourceLines {
      guard let commentRange = sourceLine.range(of: "//") else { continue }

      let code = sourceLine[..<commentRange.lowerBound]
      guard !code.trimmingCharacters(in: .whitespaces).isEmpty else { continue }

      let normalizedCode = code.filter { !$0.isWhitespace }
      guard let lineIndex = formattedLines[searchStart...].firstIndex(where: {
        $0.filter { !$0.isWhitespace }.hasPrefix(normalizedCode)
      }) else { continue }

      formattedLines[lineIndex] += " " + sourceLine[commentRange.lowerBound...]
      searchStart = formattedLines.index(after: lineIndex)
    }

    return formattedLines.joined(separator: "\n")
  }
}
