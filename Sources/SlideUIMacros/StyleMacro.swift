import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

package enum StyleMacro: PeerMacro {

    package static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {

        let structDecl = try declaration.as(StructDeclSyntax.self, "Can only be attached to struct declarations.")

        return [
            #"""
            /// A type that applies a custom appearance to all
            /// \#(raw: structDecl.name.text.lowercased()) views within a view hierarchy.
            ///
            /// To configure the current \#(raw: structDecl.name.text.lowercased()) style for a view hierarchy, use the
            /// ``View/\#(raw: structDecl.name.text.lowercased())Style(_:)`` modifier.
            public protocol \#(raw: structDecl.name)Style: DynamicProperty {

                typealias Configuration = \#(raw: structDecl.name)StyleConfiguration
                associatedtype Body: View

                /// Creates a view that represents the body of a \#(raw: structDecl.name) view.
                ///
                /// The system calls this method for each ``\#(raw: structDecl.name)``
                /// instance in a view hierarchy where this style is the current code style.
                ///
                /// - Parameter configuration: The properties of the \#(raw: structDecl.name) view.
                @ViewBuilder
                func makeBody(configuration: Configuration) -> Body
            }
            """#,
        ]
    }
}

extension DeclSyntaxProtocol {

    func `as`<Syntax: DeclSyntaxProtocol>(
        _ type: Syntax.Type,
        _ message: @autoclosure () -> String
    ) throws -> Syntax {

        guard let syntax = self.as(Syntax.self) else {
            throw Failure(description: message())
        }

        return syntax
    }
}
