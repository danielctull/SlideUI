
import SlideUI
import SwiftUI

extension CodeHighlighting where Self == XcodeBasic {
    public static var xcodeBasic: XcodeBasic { XcodeBasic() }
}

public struct XcodeBasic: CodeHighlighting {

    public func color(for token: Token) -> Color {
        switch token.classification {
        case .attribute: Color(red: 0, green: 0, blue: 0, opacity: 1)
        case .character: Color(red: 0, green: 0, blue: 0, opacity: 1)
        case .comment: Color(red: 0, green: 0.502, blue: 0, opacity: 1)
        case .commentDoc: Color(red: 0.0577329, green: 0.43941, blue: 0.00537989, opacity: 1)
        case .commentDocKeyword: Color(red: 0, green: 0.502, blue: 0, opacity: 1)
        case .declarationOther: Color(red: 0.0588235, green: 0.407843, blue: 0.627451, opacity: 1)
        case .declarationType: Color(red: 0.0431373, green: 0.309804, blue: 0.47451, opacity: 1)
        case .identifierClass: Color(red: 0.169, green: 0.512, blue: 0.625, opacity: 1)
        case .identifierClassSystem: Color(red: 0.169, green: 0.512, blue: 0.625, opacity: 1)
        case .identifierConstant: Color(red: 0.169, green: 0.512, blue: 0.625, opacity: 1)
        case .identifierConstantSystem: Color(red: 0.169, green: 0.512, blue: 0.625, opacity: 1)
        case .identifierFunction: Color(red: 0.169, green: 0.512, blue: 0.625, opacity: 1)
        case .identifierFunctionSystem: Color(red: 0.169, green: 0.512, blue: 0.625, opacity: 1)
        case .identifierMacro: Color(red: 0, green: 0, blue: 1, opacity: 1)
        case .identifierMacroSystem: Color(red: 0, green: 0, blue: 1, opacity: 1)
        case .identifierType: Color(red: 0.169, green: 0.512, blue: 0.625, opacity: 1)
        case .identifierTypeSystem: Color(red: 0.169, green: 0.512, blue: 0.625, opacity: 1)
        case .identifierVariable: Color(red: 0.169, green: 0.512, blue: 0.625, opacity: 1)
        case .identifierVariableSystem: Color(red: 0.169, green: 0.512, blue: 0.625, opacity: 1)
        case .keyword: Color(red: 0, green: 0, blue: 1, opacity: 1)
        case .mark: Color(red: 0, green: 0.502, blue: 0, opacity: 1)
        case .markupCode: Color(red: 0.665, green: 0.052, blue: 0.569, opacity: 1)
        case .number: Color(red: 0, green: 0, blue: 0, opacity: 1)
        case .plain: Color(red: 0, green: 0, blue: 0, opacity: 1)
        case .preprocessor: Color(red: 0, green: 0, blue: 1, opacity: 1)
        case .regex: Color(red: 0.639, green: 0.082, blue: 0.082, opacity: 1)
        case .regexCapturename: Color(red: 0.169, green: 0.512, blue: 0.625, opacity: 1)
        case .regexCharname: Color(red: 0.169, green: 0.512, blue: 0.625, opacity: 1)
        case .regexNumber: Color(red: 0, green: 0, blue: 0, opacity: 1)
        case .regexOther: Color(red: 0, green: 0, blue: 0, opacity: 1)
        case .string: Color(red: 0.639, green: 0.082, blue: 0.082, opacity: 1)
        case .url: Color(red: 0, green: 0, blue: 1, opacity: 1)
        default: Color(red: 0, green: 0, blue: 0, opacity: 0.85)
        }
    }
}