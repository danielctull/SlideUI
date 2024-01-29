
import SlideUI
import SwiftUI

extension CodeHighlighting where Self == XcodeHighContrastLight {
    public static var xcodeHighContrastLight: XcodeHighContrastLight { XcodeHighContrastLight() }
}

public struct XcodeHighContrastLight: CodeHighlighting {

    public func color(for token: Token) -> Color {
        switch token.classification {
        case .attribute: Color(red: 0.354233, green: 0.262985, blue: 0.0064115, opacity: 1)
        case .character: Color(red: 0.110384, green: 0.00801942, blue: 0.810116, opacity: 1)
        case .comment: Color(red: 0.103171, green: 0.323647, blue: 0.00347844, opacity: 1)
        case .commentDoc: Color(red: 0.103171, green: 0.323647, blue: 0.00347844, opacity: 1)
        case .commentDocKeyword: Color(red: 0.101961, green: 0.32549, blue: 0.00392157, opacity: 1)
        case .declarationOther: Color(red: 0.030375, green: 0.263533, blue: 0.56285, opacity: 1)
        case .declarationType: Color(red: 0.015819, green: 0.181914, blue: 0.374826, opacity: 1)
        case .identifierClass: Color(red: 0.0759885, green: 0.196611, blue: 0.208366, opacity: 1)
        case .identifierClassSystem: Color(red: 0.201361, green: 0, blue: 0.562816, opacity: 1)
        case .identifierConstant: Color(red: 0.161212, green: 0.29426, blue: 0.307032, opacity: 1)
        case .identifierConstantSystem: Color(red: 0.359223, green: 0.148247, blue: 0.601912, opacity: 1)
        case .identifierFunction: Color(red: 0.161212, green: 0.29426, blue: 0.307032, opacity: 1)
        case .identifierFunctionSystem: Color(red: 0.359223, green: 0.148247, blue: 0.601912, opacity: 1)
        case .identifierMacro: Color(red: 0.391471, green: 0.220311, blue: 0.124457, opacity: 1)
        case .identifierMacroSystem: Color(red: 0.391471, green: 0.220311, blue: 0.124457, opacity: 1)
        case .identifierType: Color(red: 0.0759885, green: 0.196611, blue: 0.208366, opacity: 1)
        case .identifierTypeSystem: Color(red: 0.201361, green: 0, blue: 0.562816, opacity: 1)
        case .identifierVariable: Color(red: 0.161212, green: 0.29426, blue: 0.307032, opacity: 1)
        case .identifierVariableSystem: Color(red: 0.359223, green: 0.148247, blue: 0.601912, opacity: 1)
        case .keyword: Color(red: 0.534402, green: 0, blue: 0.495754, opacity: 1)
        case .mark: Color(red: 0.101961, green: 0.32549, blue: 0.00392157, opacity: 1)
        case .markupCode: Color(red: 0.665, green: 0.052, blue: 0.569, opacity: 1)
        case .number: Color(red: 0.110384, green: 0.00801942, blue: 0.810116, opacity: 1)
        case .plain: Color(red: 0, green: 0, blue: 0, opacity: 1)
        case .preprocessor: Color(red: 0.391471, green: 0.220311, blue: 0.124457, opacity: 1)
        case .regex: Color(red: 0.607402, green: 0.0194132, blue: 0.0336452, opacity: 1)
        case .regexCapturename: Color(red: 0.161212, green: 0.29426, blue: 0.307032, opacity: 1)
        case .regexCharname: Color(red: 0.359223, green: 0.148247, blue: 0.601912, opacity: 1)
        case .regexNumber: Color(red: 0.110384, green: 0.00801942, blue: 0.810116, opacity: 1)
        case .regexOther: Color(red: 0, green: 0, blue: 0, opacity: 1)
        case .string: Color(red: 0.607402, green: 0.0194132, blue: 0.0336452, opacity: 1)
        case .url: Color(red: 0.052237, green: 0.056613, blue: 0.934436, opacity: 1)
        default: Color(red: 0, green: 0, blue: 0, opacity: 0.85)
        }
    }
}