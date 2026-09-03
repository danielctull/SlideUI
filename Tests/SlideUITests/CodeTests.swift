
import SlideUI
import SlideUIMacros
import SwiftSyntaxMacrosTestSupport
import Testing

@Suite("Code")
struct CodeTests {

  func `macro preserves trailing comments`() {
    assertMacroExpansion(
      """
      #Code {
        let value = "test" // these comments should remain
      }
      """,
      expandedSource: ##"""
      Code {
          #"let value = "test" // these comments should remain\#n"#
      }
      """##,
      macros: ["Code": CodeMacro.self])
  }
}
