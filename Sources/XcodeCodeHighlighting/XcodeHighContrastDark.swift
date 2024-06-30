
import SlideUI
import SwiftUI

extension CodeHighlighting where Self == XcodeHighContrastDark {
    public static var xcodeHighContrastDark: XcodeHighContrastDark { XcodeHighContrastDark() }
}

public struct XcodeHighContrastDark: CodeHighlighting {

    public func color(for token: Token) -> Color {
        switch token.classification {
        case .attribute: Color(red: 0.882718, green: 0.655963, blue: 0.472558, opacity: 1)
        case .character: Color(red: 0.814725, green: 0.736529, blue: 0.335488, opacity: 1)
        case .comment: Color(red: 0.486721, green: 0.709574, blue: 0.330699, opacity: 1)
        case .commentDoc: Color(red: 0.486721, green: 0.709574, blue: 0.330699, opacity: 1)
        case .commentDocKeyword: Color(red: 0.67451, green: 0.941176, blue: 0.482353, opacity: 1)
        case .declarationOther: Color(red: 0.258594, green: 0.719796, blue: 0.877076, opacity: 1)
        case .declarationType: Color(red: 0.364706, green: 0.847059, blue: 1, opacity: 1)
        case .identifierClass: Color(red: 0.644022, green: 0.983529, blue: 0.901838, opacity: 1)
        case .identifierClassSystem: Color(red: 0.870275, green: 0.758393, blue: 0.999463, opacity: 1)
        case .identifierConstant: Color(red: 0.448484, green: 0.748715, blue: 0.682313, opacity: 1)
        case .identifierConstantSystem: Color(red: 0.75482, green: 0.539479, blue: 0.99907, opacity: 1)
        case .identifierFunction: Color(red: 0.448484, green: 0.748715, blue: 0.682313, opacity: 1)
        case .identifierFunctionSystem: Color(red: 0.75482, green: 0.539479, blue: 0.99907, opacity: 1)
        case .identifierMacro: Color(red: 0.991311, green: 0.560764, blue: 0.246107, opacity: 1)
        case .identifierMacroSystem: Color(red: 0.991311, green: 0.560764, blue: 0.246107, opacity: 1)
        case .identifierType: Color(red: 0.644022, green: 0.983529, blue: 0.901838, opacity: 1)
        case .identifierTypeSystem: Color(red: 0.870275, green: 0.758393, blue: 0.999463, opacity: 1)
        case .identifierVariable: Color(red: 0.448484, green: 0.748715, blue: 0.682313, opacity: 1)
        case .identifierVariableSystem: Color(red: 0.75482, green: 0.539479, blue: 0.99907, opacity: 1)
        case .keyword: Color(red: 0.988964, green: 0.421135, blue: 0.664991, opacity: 1)
        case .mark: Color(red: 0.67451, green: 0.941176, blue: 0.482353, opacity: 1)
        case .markupCode: Color(red: 0.665, green: 0.052, blue: 0.569, opacity: 1)
        case .number: Color(red: 0.814725, green: 0.736529, blue: 0.335488, opacity: 1)
        case .plain: Color(red: 1, green: 1, blue: 1, opacity: 1)
        case .preprocessor: Color(red: 0.991311, green: 0.560764, blue: 0.246107, opacity: 1)
        case .regex: Color(red: 0.989608, green: 0.453865, blue: 0.404471, opacity: 1)
        case .regexCapturename: Color(red: 0.448484, green: 0.748715, blue: 0.682313, opacity: 1)
        case .regexCharname: Color(red: 0.75482, green: 0.539479, blue: 0.99907, opacity: 1)
        case .regexNumber: Color(red: 0.814725, green: 0.736529, blue: 0.335488, opacity: 1)
        case .regexOther: Color(red: 1, green: 1, blue: 1, opacity: 1)
        case .string: Color(red: 0.989608, green: 0.453865, blue: 0.404471, opacity: 1)
        case .url: Color(red: 0.450366, green: 0.602412, blue: 0.998771, opacity: 1)
        default: Color(red: 0, green: 0, blue: 0, opacity: 0.85)
        }
    }
}
