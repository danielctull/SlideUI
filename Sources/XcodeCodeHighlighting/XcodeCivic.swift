
import SlideUI
import SwiftUI

extension CodeHighlighting where Self == XcodeCivic {
    public static var xcodeCivic: XcodeCivic { XcodeCivic() }
}

public struct XcodeCivic: CodeHighlighting {

    public func color(for token: Token) -> Color {
        switch token.classification {
        case .attribute: Color(red: 0.335, green: 0.456, blue: 0.488, opacity: 1)
        case .character: Color(red: 0.454902, green: 0.427451, blue: 0.690196, opacity: 1)
        case .comment: Color(red: 0.269849, green: 0.733918, blue: 0.242487, opacity: 1)
        case .commentDoc: Color(red: 0.134715, green: 0.628894, blue: 0.33229, opacity: 1)
        case .commentDocKeyword: Color(red: 0.194431, green: 0.813269, blue: 0.446511, opacity: 1)
        case .declarationOther: Color(red: 0.254902, green: 0.631373, blue: 0.752941, opacity: 1)
        case .declarationType: Color(red: 0.362946, green: 0.846428, blue: 0.998966, opacity: 1)
        case .identifierClass: Color(red: 0.115602, green: 0.660894, blue: 0.635056, opacity: 1)
        case .identifierClassSystem: Color(red: 0.144404, green: 0.565295, blue: 0.554646, opacity: 1)
        case .identifierConstant: Color(red: 0.115602, green: 0.660894, blue: 0.635056, opacity: 1)
        case .identifierConstantSystem: Color(red: 0.144404, green: 0.565295, blue: 0.554646, opacity: 1)
        case .identifierFunction: Color(red: 0.115602, green: 0.660894, blue: 0.635056, opacity: 1)
        case .identifierFunctionSystem: Color(red: 0.144404, green: 0.565295, blue: 0.554646, opacity: 1)
        case .identifierMacro: Color(red: 0.780392, green: 0.478431, blue: 0.294118, opacity: 1)
        case .identifierMacroSystem: Color(red: 0.684784, green: 0.363489, blue: 0.218942, opacity: 1)
        case .identifierType: Color(red: 0.115602, green: 0.660894, blue: 0.635056, opacity: 1)
        case .identifierTypeSystem: Color(red: 0.144404, green: 0.565295, blue: 0.554646, opacity: 1)
        case .identifierVariable: Color(red: 0.115602, green: 0.660894, blue: 0.635056, opacity: 1)
        case .identifierVariableSystem: Color(red: 0.144404, green: 0.565295, blue: 0.554646, opacity: 1)
        case .keyword: Color(red: 0.843979, green: 0, blue: 0.559795, opacity: 1)
        case .mark: Color(red: 0.194431, green: 0.813269, blue: 0.446511, opacity: 1)
        case .markupCode: Color(red: 0.665, green: 0.052, blue: 0.569, opacity: 1)
        case .number: Color(red: 0.0784314, green: 0.611765, blue: 0.572549, opacity: 1)
        case .plain: Color(red: 0.88217, green: 0.885352, blue: 0.904267, opacity: 1)
        case .preprocessor: Color(red: 0.780392, green: 0.478431, blue: 0.294118, opacity: 1)
        case .regex: Color(red: 0.827451, green: 0.137255, blue: 0.180392, opacity: 1)
        case .regexCapturename: Color(red: 0.115602, green: 0.660894, blue: 0.635056, opacity: 1)
        case .regexCharname: Color(red: 0.144404, green: 0.565295, blue: 0.554646, opacity: 1)
        case .regexNumber: Color(red: 0.0784314, green: 0.611765, blue: 0.572549, opacity: 1)
        case .regexOther: Color(red: 0.88217, green: 0.885352, blue: 0.904267, opacity: 1)
        case .string: Color(red: 0.827451, green: 0.137255, blue: 0.180392, opacity: 1)
        case .url: Color(red: 0.318049, green: 0.142332, blue: 0.891432, opacity: 1)
        default: Color(red: 0, green: 0, blue: 0, opacity: 0.85)
        }
    }
}
