
import SlideUI
import SwiftUI

extension CodeHighlighting where Self == XcodeMidnight {
    public static var xcodeMidnight: XcodeMidnight { XcodeMidnight() }
}

public struct XcodeMidnight: CodeHighlighting {

    public func color(for token: Token) -> Color {
        switch token.classification {
        case .attribute: Color(red: 0.177359, green: 0.265488, blue: 0.608972, opacity: 1)
        case .character: Color(red: 0.469, green: 0.426, blue: 1, opacity: 1)
        case .comment: Color(red: 0.255, green: 0.801, blue: 0.27, opacity: 1)
        case .commentDoc: Color(red: 0.255, green: 0.801, blue: 0.27, opacity: 1)
        case .commentDocKeyword: Color(red: 0.255, green: 0.801, blue: 0.27, opacity: 1)
        case .declarationOther: Color(red: 0.254902, green: 0.631373, blue: 0.752941, opacity: 1)
        case .declarationType: Color(red: 0.362946, green: 0.846428, blue: 0.998966, opacity: 1)
        case .identifierClass: Color(red: 0.137, green: 1, blue: 0.512, opacity: 1)
        case .identifierClassSystem: Color(red: 0, green: 0.626, blue: 1, opacity: 1)
        case .identifierConstant: Color(red: 0.137, green: 1, blue: 0.512, opacity: 1)
        case .identifierConstantSystem: Color(red: 0, green: 0.626, blue: 1, opacity: 1)
        case .identifierFunction: Color(red: 0.137, green: 1, blue: 0.512, opacity: 1)
        case .identifierFunctionSystem: Color(red: 0, green: 0.626, blue: 1, opacity: 1)
        case .identifierMacro: Color(red: 0.896, green: 0.488, blue: 0.284, opacity: 1)
        case .identifierMacroSystem: Color(red: 0.896, green: 0.488, blue: 0.284, opacity: 1)
        case .identifierType: Color(red: 0.137, green: 1, blue: 0.512, opacity: 1)
        case .identifierTypeSystem: Color(red: 0, green: 0.626, blue: 1, opacity: 1)
        case .identifierVariable: Color(red: 0.137, green: 1, blue: 0.512, opacity: 1)
        case .identifierVariableSystem: Color(red: 0, green: 0.626, blue: 1, opacity: 1)
        case .keyword: Color(red: 0.828, green: 0.095, blue: 0.583, opacity: 1)
        case .mark: Color(red: 0.255, green: 0.801, blue: 0.27, opacity: 1)
        case .markupCode: Color(red: 0.665, green: 0.052, blue: 0.569, opacity: 1)
        case .number: Color(red: 0.469, green: 0.426, blue: 1, opacity: 1)
        case .plain: Color(red: 1, green: 1, blue: 1, opacity: 1)
        case .preprocessor: Color(red: 0.896, green: 0.488, blue: 0.284, opacity: 1)
        case .regex: Color(red: 1, green: 0.171, blue: 0.219, opacity: 1)
        case .regexCapturename: Color(red: 0.137, green: 1, blue: 0.512, opacity: 1)
        case .regexCharname: Color(red: 0, green: 0.626, blue: 1, opacity: 1)
        case .regexNumber: Color(red: 0.469, green: 0.426, blue: 1, opacity: 1)
        case .regexOther: Color(red: 1, green: 1, blue: 1, opacity: 1)
        case .string: Color(red: 1, green: 0.171, blue: 0.219, opacity: 1)
        case .url: Color(red: 0.255, green: 0.392, blue: 1, opacity: 1)
        default: Color(red: 0, green: 0, blue: 0, opacity: 0.85)
        }
    }
}