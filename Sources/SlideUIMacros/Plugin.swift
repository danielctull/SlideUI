
import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct SlideUIPlugin: CompilerPlugin {

    let providingMacros: [Macro.Type] = [
        StringifyMacro.self,
    ]
}
