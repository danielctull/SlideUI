
import SwiftUI

@freestanding(expression)
public macro Code<V: View>(_ view: V) -> CodeView = #externalMacro(module: "SlideUIMacros", type: "CodeMacro")

public struct CodeView: View {

    let code: String
    let output: AnyView

    public init(@ViewBuilder output: () -> some View, code: () -> String) {
        self.code = code()
        self.output = AnyView(output())
    }

    public var body: some View {
        HStack {
            Color.clear.overlay {
                Text(code)
            }
            Color.clear.overlay {
                output
            }
        }
    }
}

public struct TokenView: View {
    
    @Environment(\.codeStyle) var style
    let tokens: [Token]
    
    public init(tokens: [Token]) {
        self.tokens = tokens
    }
    
    public var body: some View {
        tokens.reduce(Text("")) { accumulated, token in
            let text: Text = Text(token.value)
                .font(style.font(token))
                .foregroundColor(style.color(token))
            return accumulated + text
        }
    }
}

// MARK: - Token

public struct Token {
    public let value: String
    public let kind: Kind
}

extension Token {

    public struct Kind: Equatable, Hashable, Sendable {
        private let name: String
        private init(_ name: String) {
            self.name = name
        }
    }
}

extension Token.Kind {
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
    public static func attribute(_ value: String) -> Self { Self(value: value, kind: .attribute) }
    public static func character(_ value: String) -> Self { Self(value: value, kind: .character) }
    public static func comment(_ value: String) -> Self { Self(value: value, kind: .comment) }
    public static func commentDoc(_ value: String) -> Self { Self(value: value, kind: .commentDoc) }
    public static func commentDocKeyword(_ value: String) -> Self { Self(value: value, kind: .commentDocKeyword) }
    public static func declarationOther(_ value: String) -> Self { Self(value: value, kind: .declarationOther) }
    public static func declarationType(_ value: String) -> Self { Self(value: value, kind: .declarationType) }
    public static func identifierClass(_ value: String) -> Self { Self(value: value, kind: .identifierClass) }
    public static func identifierClassSystem(_ value: String) -> Self { Self(value: value, kind: .identifierClassSystem) }
    public static func identifierConstant(_ value: String) -> Self { Self(value: value, kind: .identifierConstant) }
    public static func identifierConstantSystem(_ value: String) -> Self { Self(value: value, kind: .identifierConstantSystem) }
    public static func identifierFunction(_ value: String) -> Self { Self(value: value, kind: .identifierFunction) }
    public static func identifierFunctionSystem(_ value: String) -> Self { Self(value: value, kind: .identifierFunctionSystem) }
    public static func identifierMacro(_ value: String) -> Self { Self(value: value, kind: .identifierMacro) }
    public static func identifierMacroSystem(_ value: String) -> Self { Self(value: value, kind: .identifierMacroSystem) }
    public static func identifierType(_ value: String) -> Self { Self(value: value, kind: .identifierType) }
    public static func identifierTypeSystem(_ value: String) -> Self { Self(value: value, kind: .identifierTypeSystem) }
    public static func identifierVariable(_ value: String) -> Self { Self(value: value, kind: .identifierVariable) }
    public static func identifierVariableSystem(_ value: String) -> Self { Self(value: value, kind: .identifierVariableSystem) }
    public static func keyword(_ value: String) -> Self { Self(value: value, kind: .keyword) }
    public static func mark(_ value: String) -> Self { Self(value: value, kind: .mark) }
    public static func markupCode(_ value: String) -> Self { Self(value: value, kind: .markupCode) }
    public static func number(_ value: String) -> Self { Self(value: value, kind: .number) }
    public static func plain(_ value: String) -> Self { Self(value: value, kind: .plain) }
    public static func preprocessor(_ value: String) -> Self { Self(value: value, kind: .preprocessor) }
    public static func regex(_ value: String) -> Self { Self(value: value, kind: .regex) }
    public static func regexCapturename(_ value: String) -> Self { Self(value: value, kind: .regexCapturename) }
    public static func regexCharname(_ value: String) -> Self { Self(value: value, kind: .regexCharname) }
    public static func regexNumber(_ value: String) -> Self { Self(value: value, kind: .regexNumber) }
    public static func regexOther(_ value: String) -> Self { Self(value: value, kind: .regexOther) }
    public static func string(_ value: String) -> Self { Self(value: value, kind: .string) }
    public static func url(_ value: String) -> Self { Self(value: value, kind: .url) }
}

// MARK: - Code Style

extension View {

    public func codeStyle(_ style: CodeStyle) -> some View {
        environment(\.codeStyle, style)
    }
}

private struct CodeStyleKey: EnvironmentKey {
    static var defaultValue = CodeStyle.plain
}

extension EnvironmentValues {

    fileprivate var codeStyle: CodeStyle {
        get { self[CodeStyleKey.self] }
        set { self[CodeStyleKey.self] = newValue }
    }
}

public struct CodeStyle {

    let color: (Token) -> Color
    let font: (Token) -> Font

    public init(
        color: @escaping (Token) -> Color,
        font: @escaping (Token) -> Font
    ) {
        self.color = color
        self.font = font
    }
}

extension CodeStyle {

    static let plain = Self(
        color: { _ in .black },
        font: { _ in .system(size: 18, weight: .regular, design: .monospaced) })
}
