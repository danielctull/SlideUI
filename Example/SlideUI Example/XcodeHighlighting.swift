
import SlideUI
import SwiftUI

extension CodeHighlighting where Self == XcodeHighlighting {
    static var xcode: XcodeHighlighting { XcodeHighlighting() }
}

struct XcodeHighlighting: CodeHighlighting {

    func color(for token: Token) -> Color {
        .black
    }
}

extension XcodeHighlighting {
    var classic: XcodeClassicLight { XcodeClassicLight() }
}

struct XcodeClassicLight: CodeHighlighting {

    func color(for token: Token) -> Color {
        switch token.classification {
        case .attribute: Color(red: 0.505801, green: 0.371396, blue: 0.012096, opacity: 1)
        case .character: Color(red: 0.11, green: 0, blue: 0.81, opacity: 1)
        case .comment: Color(red: 0, green: 0.456, blue: 0, opacity: 1)
        case .commentDoc: Color(red: 0, green: 0.456, blue: 0, opacity: 1)
        case .commentDocKeyword: Color(red: 0.008, green: 0.239, blue: 0.063, opacity: 1)
        case .declarationOther: Color(red: 0.0588235, green: 0.407843, blue: 0.627451, opacity: 1)
        case .declarationType: Color(red: 0.0431373, green: 0.309804, blue: 0.47451, opacity: 1)
        case .identifierClass: Color(red: 0.109812, green: 0.272761, blue: 0.288691, opacity: 1)
        case .identifierClassSystem: Color(red: 0.224543, green: 0, blue: 0.628029, opacity: 1)
        case .identifierConstant: Color(red: 0.194184, green: 0.429349, blue: 0.454553, opacity: 1)
        case .identifierConstantSystem: Color(red: 0.421903, green: 0.212783, blue: 0.663785, opacity: 1)
        case .identifierFunction: Color(red: 0.194184, green: 0.429349, blue: 0.454553, opacity: 1)
        case .identifierFunctionSystem: Color(red: 0.421903, green: 0.212783, blue: 0.663785, opacity: 1)
        case .identifierMacro: Color(red: 0.391471, green: 0.220311, blue: 0.124457, opacity: 1)
        case .identifierMacroSystem: Color(red: 0.391471, green: 0.220311, blue: 0.124457, opacity: 1)
        case .identifierType: Color(red: 0.109812, green: 0.272761, blue: 0.288691, opacity: 1)
        case .identifierTypeSystem: Color(red: 0.224543, green: 0, blue: 0.628029, opacity: 1)
        case .identifierVariable: Color(red: 0.194184, green: 0.429349, blue: 0.454553, opacity: 1)
        case .identifierVariableSystem: Color(red: 0.421903, green: 0.212783, blue: 0.663785, opacity: 1)
        case .keyword: Color(red: 0.607592, green: 0.137526, blue: 0.576284, opacity: 1)
        case .mark: Color(red: 0.14902, green: 0.458824, blue: 0.027451, opacity: 1)
        case .markupCode: Color(red: 0.665, green: 0.052, blue: 0.569, opacity: 1)
        case .number: Color(red: 0.11, green: 0, blue: 0.81, opacity: 1)
        case .plain: Color(red: 0, green: 0, blue: 0, opacity: 0.85)
        case .preprocessor: Color(red: 0.391471, green: 0.220311, blue: 0.124457, opacity: 1)
        case .regex: Color(red: 0.77, green: 0.102, blue: 0.086, opacity: 1)
        case .regexCapturename: Color(red: 0.194184, green: 0.429349, blue: 0.454553, opacity: 1)
        case .regexCharname: Color(red: 0.421903, green: 0.212783, blue: 0.663785, opacity: 1)
        case .regexNumber: Color(red: 0.11, green: 0, blue: 0.81, opacity: 1)
        case .regexOther: Color(red: 0, green: 0, blue: 0, opacity: 0.85)
        case .string: Color(red: 0.77, green: 0.102, blue: 0.086, opacity: 1)
        case .url: Color(red: 0.055, green: 0.055, blue: 1, opacity: 1)
        default: Color(red: 0, green: 0, blue: 0, opacity: 0.85)
        }
    }
}
