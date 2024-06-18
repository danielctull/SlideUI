
import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct SlideUIPlugin: CompilerPlugin {

    let providingMacros: [Macro.Type] = [
        CodePreviewMacro.self,
        LegacyCodeMacro.self,
    ]
}
