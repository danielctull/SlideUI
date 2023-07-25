
import SwiftSyntax
import SwiftParser

extension Array<Token> {

    init(code: some StringProtocol) {
        let source = Parser.parse(source: String(code))
        let tokenizer = Tokenizer(viewMode: .sourceAccurate)
        _ = tokenizer.visit(source)
        self = tokenizer.tokens
    }
}

// MARK: - Token

public struct Token {
    public let value: String
    public let classification: Classification
}

extension Token {

    public struct Classification: Equatable, Hashable, Sendable {
        private let name: String
        private init(_ name: String) {
            self.name = name
        }
    }
}

extension Token.Classification {
    public static let attribute = Self("attribute")
    public static let character = Self("character")
    public static let comment = Self("comment")
    public static let commentDoc = Self("comment.doc")
    public static let commentDocKeyword = Self("comment.doc.keyword")
    public static let declarationOther = Self("declaration.other")
    public static let declarationType = Self("declaration.type")
    public static let identifierClass = Self("identifier.class")
    public static let identifierClassSystem = Self("identifier.class.system")
    public static let identifierConstant = Self("identifier.constant")
    public static let identifierConstantSystem = Self("identifier.constant.system")
    public static let identifierFunction = Self("identifier.function")
    public static let identifierFunctionSystem = Self("identifier.function.system")
    public static let identifierMacro = Self("identifier.macro")
    public static let identifierMacroSystem = Self("identifier.macro.system")
    public static let identifierType = Self("identifier.type")
    public static let identifierTypeSystem = Self("identifier.type.system")
    public static let identifierVariable = Self("identifier.variable")
    public static let identifierVariableSystem = Self("identifier.variable.system")
    public static let keyword = Self("keyword")
    public static let mark = Self("mark")
    public static let markupCode = Self("markup.code")
    public static let number = Self("number")
    public static let plain = Self("plain")
    public static let preprocessor = Self("preprocessor")
    public static let regex = Self("regex")
    public static let regexCapturename = Self("regex.capturename")
    public static let regexCharname = Self("regex.charname")
    public static let regexNumber = Self("regex.number")
    public static let regexOther = Self("regex.other")
    public static let string = Self("string")
    public static let url = Self("url")
}

extension Token {
    public static func attribute(_ value: String) -> Self { Self(value: value, classification: .attribute) }
    public static func character(_ value: String) -> Self { Self(value: value, classification: .character) }
    public static func comment(_ value: String) -> Self { Self(value: value, classification: .comment) }
    public static func commentDoc(_ value: String) -> Self { Self(value: value, classification: .commentDoc) }
    public static func commentDocKeyword(_ value: String) -> Self { Self(value: value, classification: .commentDocKeyword) }
    public static func declarationOther(_ value: String) -> Self { Self(value: value, classification: .declarationOther) }
    public static func declarationType(_ value: String) -> Self { Self(value: value, classification: .declarationType) }
    public static func identifierClass(_ value: String) -> Self { Self(value: value, classification: .identifierClass) }
    public static func identifierClassSystem(_ value: String) -> Self { Self(value: value, classification: .identifierClassSystem) }
    public static func identifierConstant(_ value: String) -> Self { Self(value: value, classification: .identifierConstant) }
    public static func identifierConstantSystem(_ value: String) -> Self { Self(value: value, classification: .identifierConstantSystem) }
    public static func identifierFunction(_ value: String) -> Self { Self(value: value, classification: .identifierFunction) }
    public static func identifierFunctionSystem(_ value: String) -> Self { Self(value: value, classification: .identifierFunctionSystem) }
    public static func identifierMacro(_ value: String) -> Self { Self(value: value, classification: .identifierMacro) }
    public static func identifierMacroSystem(_ value: String) -> Self { Self(value: value, classification: .identifierMacroSystem) }
    public static func identifierType(_ value: String) -> Self { Self(value: value, classification: .identifierType) }
    public static func identifierTypeSystem(_ value: String) -> Self { Self(value: value, classification: .identifierTypeSystem) }
    public static func identifierVariable(_ value: String) -> Self { Self(value: value, classification: .identifierVariable) }
    public static func identifierVariableSystem(_ value: String) -> Self { Self(value: value, classification: .identifierVariableSystem) }
    public static func keyword(_ value: String) -> Self { Self(value: value, classification: .keyword) }
    public static func mark(_ value: String) -> Self { Self(value: value, classification: .mark) }
    public static func markupCode(_ value: String) -> Self { Self(value: value, classification: .markupCode) }
    public static func number(_ value: String) -> Self { Self(value: value, classification: .number) }
    public static func plain(_ value: String) -> Self { Self(value: value, classification: .plain) }
    public static func preprocessor(_ value: String) -> Self { Self(value: value, classification: .preprocessor) }
    public static func regex(_ value: String) -> Self { Self(value: value, classification: .regex) }
    public static func regexCapturename(_ value: String) -> Self { Self(value: value, classification: .regexCapturename) }
    public static func regexCharname(_ value: String) -> Self { Self(value: value, classification: .regexCharname) }
    public static func regexNumber(_ value: String) -> Self { Self(value: value, classification: .regexNumber) }
    public static func regexOther(_ value: String) -> Self { Self(value: value, classification: .regexOther) }
    public static func string(_ value: String) -> Self { Self(value: value, classification: .string) }
    public static func url(_ value: String) -> Self { Self(value: value, classification: .url) }
}

// MARK: - Tokenizer

private final class Tokenizer: SyntaxRewriter {

    var tokens: [Token] = []

    override func visit(_ token: TokenSyntax) -> TokenSyntax {
        tokens.append(contentsOf: token.tokens)
        return super.visit(token)
    }
}

extension TokenSyntax {

    fileprivate var tokens: [Token] {
        let leading = leadingTrivia.pieces.map(Token.init)
        let token = Token.plain(text)
        let trailing = trailingTrivia.pieces.map(Token.init)
        return leading + [token] + trailing
    }
}

extension Token {

    fileprivate init(_ piece: TriviaPiece) {
        switch piece {
        case let .backslashes(count): self = .plain(repeating: "\\", count: count)
        case let .blockComment(string): self = .comment(string)
        case let .carriageReturns(count): self = .plain(repeating: "", count: count)
        case let .carriageReturnLineFeeds(count): self = .plain(repeating: "", count: count)
        case let .docBlockComment(string): self = .commentDoc(string)
        case let .docLineComment(string): self = .commentDoc(string)
        case let .formfeeds(count): self = .plain(repeating: "", count: count)
        case let .lineComment(string): self = .comment(string)
        case let .newlines(count): self = .plain(repeating: "\n", count: count)
        case let .pounds(count): self = .plain(repeating: "#", count: count)
        case let .shebang(string): self = .plain(string)
        case let .spaces(count): self = .plain(repeating: " ", count: count)
        case let .tabs(count): self = .plain(repeating: "\t", count: count)
        case let .unexpectedText(string): self = .plain(string)
        case let .verticalTabs(count): self = .plain(repeating: "", count: count)
        }
    }

    private static func plain(repeating string: String, count: Int) -> Self {
        .plain(String(repeating: string, count: count))
    }
}
