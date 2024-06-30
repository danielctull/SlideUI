
import SlideUI
import SwiftUI

extension CodeHighlighting where Self == XcodePrinting {
    public static var xcodePrinting: XcodePrinting { XcodePrinting() }
}

public struct XcodePrinting: CodeHighlighting {

    public func color(for token: Token) -> Color {
        switch token.classification {
        case .attribute: Color(red: 0.429761, green: 0.429761, blue: 0.429761, opacity: 1)
        case .character: Color(red: 0.214024, green: 0.214024, blue: 0.214024, opacity: 1)
        case .comment: Color(red: 0.366137, green: 0.366137, blue: 0.366137, opacity: 1)
        case .commentDoc: Color(red: 0.366137, green: 0.366137, blue: 0.366137, opacity: 1)
        case .commentDocKeyword: Color(red: 0.366137, green: 0.366137, blue: 0.366137, opacity: 1)
        case .declarationOther: Color(red: 0.309039, green: 0.309039, blue: 0.309039, opacity: 1)
        case .declarationType: Color(red: 0.226532, green: 0.226532, blue: 0.226532, opacity: 1)
        case .identifierClass: Color(red: 0.395311, green: 0.395311, blue: 0.395311, opacity: 1)
        case .identifierClassSystem: Color(red: 0.268741, green: 0.268741, blue: 0.268741, opacity: 1)
        case .identifierConstant: Color(red: 0.253295, green: 0.253295, blue: 0.253295, opacity: 1)
        case .identifierConstantSystem: Color(red: 0.150324, green: 0.150324, blue: 0.150324, opacity: 1)
        case .identifierFunction: Color(red: 0.253295, green: 0.253295, blue: 0.253295, opacity: 1)
        case .identifierFunctionSystem: Color(red: 0.150324, green: 0.150324, blue: 0.150324, opacity: 1)
        case .identifierMacro: Color(red: 0.263665, green: 0.263665, blue: 0.263665, opacity: 1)
        case .identifierMacroSystem: Color(red: 0.263665, green: 0.263665, blue: 0.263665, opacity: 1)
        case .identifierType: Color(red: 0.395311, green: 0.395311, blue: 0.395311, opacity: 1)
        case .identifierTypeSystem: Color(red: 0.268741, green: 0.268741, blue: 0.268741, opacity: 1)
        case .identifierVariable: Color(red: 0.395311, green: 0.395311, blue: 0.395311, opacity: 1)
        case .identifierVariableSystem: Color(red: 0.268741, green: 0.268741, blue: 0.268741, opacity: 1)
        case .keyword: Color(red: 0.348522, green: 0.348522, blue: 0.348522, opacity: 1)
        case .mark: Color(red: 0.366137, green: 0.366137, blue: 0.366137, opacity: 1)
        case .markupCode: Color(red: 0.348522, green: 0.348522, blue: 0.348522, opacity: 1)
        case .number: Color(red: 0.214024, green: 0.214024, blue: 0.214024, opacity: 1)
        case .plain: Color(red: 0, green: 0, blue: 0, opacity: 1)
        case .preprocessor: Color(red: 0.263665, green: 0.263665, blue: 0.263665, opacity: 1)
        case .regex: Color(red: 0.365291, green: 0.365291, blue: 0.365291, opacity: 1)
        case .regexCapturename: Color(red: 0.253295, green: 0.253295, blue: 0.253295, opacity: 1)
        case .regexCharname: Color(red: 0.150324, green: 0.150324, blue: 0.150324, opacity: 1)
        case .regexNumber: Color(red: 0.214024, green: 0.214024, blue: 0.214024, opacity: 1)
        case .regexOther: Color(red: 0, green: 0, blue: 0, opacity: 1)
        case .string: Color(red: 0.365291, green: 0.365291, blue: 0.365291, opacity: 1)
        case .url: Color(red: 0.26147, green: 0.26147, blue: 0.26147, opacity: 1)
        default: Color(red: 0, green: 0, blue: 0, opacity: 0.85)
        }
    }
}
