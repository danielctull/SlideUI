
import Foundation

public struct Theme: Equatable, Hashable, Sendable {
    public let textSyntaxColors: TextSyntaxColors
}

extension Theme {

    public init(_ data: Data) throws {
        self.init(try PropertyListDecoder().decode(DecodableTheme.self, from: data))
    }
}

public struct Color: Equatable, Hashable, Sendable {
    public let red: String
    public let green: String
    public let blue: String
    public let opacity: String
}

public struct TextSyntaxColors: Equatable, Hashable, Sendable {
    public let attribute: Color
    public let character: Color
    public let comment: Color
    public let commentDoc: Color
    public let commentDocKeyword: Color
    public let declarationOther: Color
    public let declarationType: Color
    public let identifierClass: Color
    public let identifierClassSystem: Color
    public let identifierConstant: Color
    public let identifierConstantSystem: Color
    public let identifierFunction: Color
    public let identifierFunctionSystem: Color
    public let identifierMacro: Color
    public let identifierMacroSystem: Color
    public let identifierType: Color
    public let identifierTypeSystem: Color
    public let identifierVariable: Color
    public let identifierVariableSystem: Color
    public let keyword: Color
    public let mark: Color
    public let markupCode: Color
    public let number: Color
    public let plain: Color
    public let preprocessor: Color
    public let regex: Color
    public let regexCapturename: Color
    public let regexCharname: Color
    public let regexNumber: Color
    public let regexOther: Color
    public let string: Color
    public let url: Color
}

// MARK: - Decodable

struct DecodableTheme: Decodable {

    enum CodingKeys: String, CodingKey {
        case textSyntaxColors = "DVTSourceTextSyntaxColors"
    }

    let textSyntaxColors: DecodableTextSyntaxColors
}

struct DecodableTextSyntaxColors: Decodable {

    let attribute: String
    let character: String
    let comment: String
    let commentDoc: String
    let commentDocKeyword: String
    let declarationOther: String
    let declarationType: String
    let identifierClass: String
    let identifierClassSystem: String
    let identifierConstant: String
    let identifierConstantSystem: String
    let identifierFunction: String
    let identifierFunctionSystem: String
    let identifierMacro: String
    let identifierMacroSystem: String
    let identifierType: String
    let identifierTypeSystem: String
    let identifierVariable: String
    let identifierVariableSystem: String
    let keyword: String
    let mark: String
    let markupCode: String
    let number: String
    let plain: String
    let preprocessor: String
    let regex: String
    let regexCapturename: String
    let regexCharname: String
    let regexNumber: String
    let regexOther: String
    let string: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case attribute = "xcode.syntax.attribute"
        case character = "xcode.syntax.character"
        case comment = "xcode.syntax.comment"
        case commentDoc = "xcode.syntax.comment.doc"
        case commentDocKeyword = "xcode.syntax.comment.doc.keyword"
        case declarationOther = "xcode.syntax.declaration.other"
        case declarationType = "xcode.syntax.declaration.type"
        case identifierClass = "xcode.syntax.identifier.class"
        case identifierClassSystem = "xcode.syntax.identifier.class.system"
        case identifierConstant = "xcode.syntax.identifier.constant"
        case identifierConstantSystem = "xcode.syntax.identifier.constant.system"
        case identifierFunction = "xcode.syntax.identifier.function"
        case identifierFunctionSystem = "xcode.syntax.identifier.function.system"
        case identifierMacro = "xcode.syntax.identifier.macro"
        case identifierMacroSystem = "xcode.syntax.identifier.macro.system"
        case identifierType = "xcode.syntax.identifier.type"
        case identifierTypeSystem = "xcode.syntax.identifier.type.system"
        case identifierVariable = "xcode.syntax.identifier.variable"
        case identifierVariableSystem = "xcode.syntax.identifier.variable.system"
        case keyword = "xcode.syntax.keyword"
        case mark = "xcode.syntax.mark"
        case markupCode = "xcode.syntax.markup.code"
        case number = "xcode.syntax.number"
        case plain = "xcode.syntax.plain"
        case preprocessor = "xcode.syntax.preprocessor"
        case regex = "xcode.syntax.regex"
        case regexCapturename = "xcode.syntax.regex.capturename"
        case regexCharname = "xcode.syntax.regex.charname"
        case regexNumber = "xcode.syntax.regex.number"
        case regexOther = "xcode.syntax.regex.other"
        case string = "xcode.syntax.string"
        case url = "xcode.syntax.url"
    }
}


// MARK: - Conversion

extension Theme {

    init(_ theme: DecodableTheme) {
        self.init(textSyntaxColors: TextSyntaxColors(theme.textSyntaxColors))
    }
}

extension TextSyntaxColors {
    init(_ colors: DecodableTextSyntaxColors) {
        self.init(
            attribute: Color(colors.attribute),
            character: Color(colors.character),
            comment: Color(colors.comment),
            commentDoc: Color(colors.commentDoc),
            commentDocKeyword: Color(colors.commentDocKeyword),
            declarationOther: Color(colors.declarationOther),
            declarationType: Color(colors.declarationType),
            identifierClass: Color(colors.identifierClass),
            identifierClassSystem: Color(colors.identifierClassSystem),
            identifierConstant: Color(colors.identifierConstant),
            identifierConstantSystem: Color(colors.identifierConstantSystem),
            identifierFunction: Color(colors.identifierFunction),
            identifierFunctionSystem: Color(colors.identifierFunctionSystem),
            identifierMacro: Color(colors.identifierMacro),
            identifierMacroSystem: Color(colors.identifierMacroSystem),
            identifierType: Color(colors.identifierType),
            identifierTypeSystem: Color(colors.identifierTypeSystem),
            identifierVariable: Color(colors.identifierVariable),
            identifierVariableSystem: Color(colors.identifierVariableSystem),
            keyword: Color(colors.keyword),
            mark: Color(colors.mark),
            markupCode: Color(colors.markupCode),
            number: Color(colors.number),
            plain: Color(colors.plain),
            preprocessor: Color(colors.preprocessor),
            regex: Color(colors.regex),
            regexCapturename: Color(colors.regexCapturename),
            regexCharname: Color(colors.regexCharname),
            regexNumber: Color(colors.regexNumber),
            regexOther: Color(colors.regexOther),
            string: Color(colors.string),
            url: Color(colors.url))
    }
}

extension Color {

    init(_ string: String) {
        let array = string.split(separator: " ")
        precondition(array.count == 4)
        self.init(
            red: String(array[0]),
            green: String(array[1]),
            blue: String(array[2]),
            opacity: String(array[3]))
    }
}
