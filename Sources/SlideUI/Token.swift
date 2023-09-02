
// MARK: - Token

public struct Token {
    public let value: String
    public let classification: Classification
}

extension Token {
    static func attribute(_ value: String) -> Self { Self(value: value, classification: .attribute) }
    static func character(_ value: String) -> Self { Self(value: value, classification: .character) }
    static func comment(_ value: String) -> Self { Self(value: value, classification: .comment) }
    static func commentDoc(_ value: String) -> Self { Self(value: value, classification: .commentDoc) }
    static func commentDocKeyword(_ value: String) -> Self { Self(value: value, classification: .commentDocKeyword) }
    static func declarationOther(_ value: String) -> Self { Self(value: value, classification: .declarationOther) }
    static func declarationType(_ value: String) -> Self { Self(value: value, classification: .declarationType) }
    static func identifierClass(_ value: String) -> Self { Self(value: value, classification: .identifierClass) }
    static func identifierClassSystem(_ value: String) -> Self { Self(value: value, classification: .identifierClassSystem) }
    static func identifierConstant(_ value: String) -> Self { Self(value: value, classification: .identifierConstant) }
    static func identifierConstantSystem(_ value: String) -> Self { Self(value: value, classification: .identifierConstantSystem) }
    static func identifierFunction(_ value: String) -> Self { Self(value: value, classification: .identifierFunction) }
    static func identifierFunctionSystem(_ value: String) -> Self { Self(value: value, classification: .identifierFunctionSystem) }
    static func identifierMacro(_ value: String) -> Self { Self(value: value, classification: .identifierMacro) }
    static func identifierMacroSystem(_ value: String) -> Self { Self(value: value, classification: .identifierMacroSystem) }
    static func identifierType(_ value: String) -> Self { Self(value: value, classification: .identifierType) }
    static func identifierTypeSystem(_ value: String) -> Self { Self(value: value, classification: .identifierTypeSystem) }
    static func identifierVariable(_ value: String) -> Self { Self(value: value, classification: .identifierVariable) }
    static func identifierVariableSystem(_ value: String) -> Self { Self(value: value, classification: .identifierVariableSystem) }
    static func keyword(_ value: String) -> Self { Self(value: value, classification: .keyword) }
    static func mark(_ value: String) -> Self { Self(value: value, classification: .mark) }
    static func markupCode(_ value: String) -> Self { Self(value: value, classification: .markupCode) }
    static func number(_ value: String) -> Self { Self(value: value, classification: .number) }
    static func plain(_ value: String) -> Self { Self(value: value, classification: .plain) }
    static func preprocessor(_ value: String) -> Self { Self(value: value, classification: .preprocessor) }
    static func regex(_ value: String) -> Self { Self(value: value, classification: .regex) }
    static func regexCapturename(_ value: String) -> Self { Self(value: value, classification: .regexCapturename) }
    static func regexCharname(_ value: String) -> Self { Self(value: value, classification: .regexCharname) }
    static func regexNumber(_ value: String) -> Self { Self(value: value, classification: .regexNumber) }
    static func regexOther(_ value: String) -> Self { Self(value: value, classification: .regexOther) }
    static func string(_ value: String) -> Self { Self(value: value, classification: .string) }
    static func url(_ value: String) -> Self { Self(value: value, classification: .url) }
}

// MARK: - Token.Classification

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

extension Token.Classification: CustomStringConvertible {
    public var description: String { name }
}
