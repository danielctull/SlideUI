
import SlideUI
import SwiftUI

struct ContentView: View {

    var body: some View {
        Presentation {
            Slide(header: "Slide 1") {

                TokenView(tokens: [
                    .comment("// This is a comment"),
                    .plain("\n"),
                    .keyword("func"),
                    .plain(" "),
                    .identifierFunction("foo"),
                    .plain("() {\n"),
                    .plain("    "),
                    .identifierFunctionSystem("print"),
                    .plain("("),
                    .string(#""Hello, world!""#),
                    .plain(")\n"),
                    .plain("}"),
                ])
            }
            Slide(header: "Slide 2") {
                Text("This is how to make a red square.")
                #Code(Color.red.frame(width: 100, height: 100))
            }
            Slide(header: "Slide 3") { Text("This is some content three") }
        }
        .codeStyle(.mine)
        .slideStyle(CustomSlideStyle())
    }
}

extension CodeStyle {

    static let mine = CodeStyle { token in
        switch token.kind {
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
    } font: { token in
        switch token.kind {
        case .comment: .system(size: .font, weight: .light, design: .monospaced)
        case .commentDoc: .system(size: .font, weight: .light, design: .monospaced).italic()
        case .commentDocKeyword: .system(size: .font, weight: .light, design: .monospaced).italic()
        case .mark: .system(size: .font, weight: .semibold, design: .monospaced)
        default: .system(size: .font, weight: .regular, design: .monospaced)
        }
    }
}

extension CGFloat {
    fileprivate static let font = Self(40)
}

struct CustomSlideStyle: SlideStyle {

    func makeBody(configuration: Configuration) -> some View {
        VStack {

            configuration.header
                .fontWidth(.expanded)
                .textCase(.uppercase)
                .font(.system(size: 100, weight: .ultraLight))
                .foregroundColor(.yellow)
                .frame(maxWidth: .infinity, alignment: .leading)

            configuration.content
                .font(.system(size: 60, weight: .light))
                .frame(maxHeight: .infinity)

            configuration.footer
                .font(.system(size: 30, weight: .light))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(30)
        .foregroundColor(.black)
        .background(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
