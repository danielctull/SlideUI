
import SlideUI
import SwiftUI

extension CodeHighlighting where Self == XcodeClassicDark {
    public static var xcodeClassicDark: XcodeClassicDark { XcodeClassicDark() }
}

public struct XcodeClassicDark: CodeHighlighting {

    public func color(for token: Token) -> Color {
        switch token.classification {
        case .attribute: Color(red: 0.750686, green: 0.521157, blue: 0.334756, opacity: 1)
        case .character: Color(red: 0.814983, green: 0.749393, blue: 0.412334, opacity: 1)
        case .comment: Color(red: 0.449401, green: 0.654752, blue: 0.304596, opacity: 1)
        case .commentDoc: Color(red: 0.449401, green: 0.654752, blue: 0.304596, opacity: 1)
        case .commentDocKeyword: Color(red: 0.635294, green: 0.894118, blue: 0.454902, opacity: 1)
        case .declarationOther: Color(red: 0.253946, green: 0.630134, blue: 0.754779, opacity: 1)
        case .declarationType: Color(red: 0.362946, green: 0.846428, blue: 0.998966, opacity: 1)
        case .identifierClass: Color(red: 0.621449, green: 0.943864, blue: 0.868194, opacity: 1)
        case .identifierClassSystem: Color(red: 0.816806, green: 0.656917, blue: 0.999271, opacity: 1)
        case .identifierConstant: Color(red: 0.405383, green: 0.717051, blue: 0.642088, opacity: 1)
        case .identifierConstantSystem: Color(red: 0.632318, green: 0.402193, blue: 0.901151, opacity: 1)
        case .identifierFunction: Color(red: 0.405383, green: 0.717051, blue: 0.642088, opacity: 1)
        case .identifierFunctionSystem: Color(red: 0.632318, green: 0.402193, blue: 0.901151, opacity: 1)
        case .identifierMacro: Color(red: 0.991311, green: 0.560764, blue: 0.246107, opacity: 1)
        case .identifierMacroSystem: Color(red: 0.991311, green: 0.560764, blue: 0.246107, opacity: 1)
        case .identifierType: Color(red: 0.621449, green: 0.943864, blue: 0.868194, opacity: 1)
        case .identifierTypeSystem: Color(red: 0.816806, green: 0.656917, blue: 0.999271, opacity: 1)
        case .identifierVariable: Color(red: 0.405383, green: 0.717051, blue: 0.642088, opacity: 1)
        case .identifierVariableSystem: Color(red: 0.632318, green: 0.402193, blue: 0.901151, opacity: 1)
        case .keyword: Color(red: 0.988394, green: 0.37355, blue: 0.638329, opacity: 1)
        case .mark: Color(red: 0.635294, green: 0.894118, blue: 0.454902, opacity: 1)
        case .markupCode: Color(red: 0.665, green: 0.052, blue: 0.569, opacity: 1)
        case .number: Color(red: 0.814983, green: 0.749393, blue: 0.412334, opacity: 1)
        case .plain: Color(red: 1, green: 1, blue: 1, opacity: 0.85)
        case .preprocessor: Color(red: 0.991311, green: 0.560764, blue: 0.246107, opacity: 1)
        case .regex: Color(red: 0.989117, green: 0.41558, blue: 0.365684, opacity: 1)
        case .regexCapturename: Color(red: 0.405383, green: 0.717051, blue: 0.642088, opacity: 1)
        case .regexCharname: Color(red: 0.632318, green: 0.402193, blue: 0.901151, opacity: 1)
        case .regexNumber: Color(red: 0.814983, green: 0.749393, blue: 0.412334, opacity: 1)
        case .regexOther: Color(red: 1, green: 1, blue: 1, opacity: 0.85)
        case .string: Color(red: 0.989117, green: 0.41558, blue: 0.365684, opacity: 1)
        case .url: Color(red: 0.330191, green: 0.511266, blue: 0.998589, opacity: 1)
        default: Color(red: 0, green: 0, blue: 0, opacity: 0.85)
        }
    }
}
