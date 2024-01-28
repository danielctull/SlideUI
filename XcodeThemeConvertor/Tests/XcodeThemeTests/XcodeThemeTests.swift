
@testable import XcodeTheme
import XCTest

final class XcodeThemeTests: XCTestCase {

    func test() throws {
        let url = try XCTUnwrap(Bundle.module.url(forResource: "Classic (Light)", withExtension: "xccolortheme"))
        let theme = try Theme(Data(contentsOf: url))
        XCTAssertEqual(theme.textSyntaxColors.attribute, Color(red: "0.505801", green: "0.371396", blue: "0.012096", opacity: "1"))
        XCTAssertEqual(theme.textSyntaxColors.character, Color(red: "0.11", green: "0", blue: "0.81", opacity: "1"))
        XCTAssertEqual(theme.textSyntaxColors.comment, Color(red: "0.147709", green: "0.459527", blue: "0.0259144", opacity: "1"))
        XCTAssertEqual(theme.textSyntaxColors.commentDoc, Color(red: "0.147709", green: "0.459527", blue: "0.0259144", opacity: "1"))
        XCTAssertEqual(theme.textSyntaxColors.commentDocKeyword, Color(red: "0.14902", green: "0.458824", blue: "0.027451", opacity: "1"))
        XCTAssertEqual(theme.textSyntaxColors.declarationOther, Color(red: "0.056956", green: "0.406224", blue: "0.628174", opacity: "1"))
        XCTAssertEqual(theme.textSyntaxColors.declarationType, Color(red: "0.044773", green: "0.311521", blue: "0.474743", opacity: "1"))
        XCTAssertEqual(theme.textSyntaxColors.identifierClass, Color(red: "0.109812", green: "0.272761", blue: "0.288691", opacity: "1"))
        XCTAssertEqual(theme.textSyntaxColors.identifierClassSystem, Color(red: "0.224543", green: "0", blue: "0.628029", opacity: "1"))
        XCTAssertEqual(theme.textSyntaxColors.identifierConstant, Color(red: "0.194184", green: "0.429349", blue: "0.454553", opacity: "1"))
        XCTAssertEqual(theme.textSyntaxColors.identifierConstantSystem, Color(red: "0.421903", green: "0.212783", blue: "0.663785", opacity: "1"))
        XCTAssertEqual(theme.textSyntaxColors.identifierFunction, Color(red: "0.194184", green: "0.429349", blue: "0.454553", opacity: "1"))
        XCTAssertEqual(theme.textSyntaxColors.identifierFunctionSystem, Color(red: "0.421903", green: "0.212783", blue: "0.663785", opacity: "1"))
        XCTAssertEqual(theme.textSyntaxColors.identifierMacro, Color(red: "0.391471", green: "0.220311", blue: "0.124457", opacity: "1"))
        XCTAssertEqual(theme.textSyntaxColors.identifierMacroSystem, Color(red: "0.391471", green: "0.220311", blue: "0.124457", opacity: "1"))
        XCTAssertEqual(theme.textSyntaxColors.identifierType, Color(red: "0.109812", green: "0.272761", blue: "0.288691", opacity: "1"))
        XCTAssertEqual(theme.textSyntaxColors.identifierTypeSystem, Color(red: "0.224543", green: "0", blue: "0.628029", opacity: "1"))
        XCTAssertEqual(theme.textSyntaxColors.identifierVariable, Color(red: "0.194184", green: "0.429349", blue: "0.454553", opacity: "1"))
        XCTAssertEqual(theme.textSyntaxColors.identifierVariableSystem, Color(red: "0.421903", green: "0.212783", blue: "0.663785", opacity: "1"))
        XCTAssertEqual(theme.textSyntaxColors.keyword, Color(red: "0.607592", green: "0.137526", blue: "0.576284", opacity: "1"))
        XCTAssertEqual(theme.textSyntaxColors.mark, Color(red: "0.14902", green: "0.458824", blue: "0.027451", opacity: "1"))
        XCTAssertEqual(theme.textSyntaxColors.markupCode, Color(red: "0.665", green: "0.052", blue: "0.569", opacity: "1"))
        XCTAssertEqual(theme.textSyntaxColors.number, Color(red: "0.11", green: "0", blue: "0.81", opacity: "1"))
        XCTAssertEqual(theme.textSyntaxColors.plain, Color(red: "0", green: "0", blue: "0", opacity: "0.85"))
        XCTAssertEqual(theme.textSyntaxColors.preprocessor, Color(red: "0.391471", green: "0.220311", blue: "0.124457", opacity: "1"))
        XCTAssertEqual(theme.textSyntaxColors.regex, Color(red: "0.77", green: "0.102", blue: "0.086", opacity: "1"))
        XCTAssertEqual(theme.textSyntaxColors.regexCapturename, Color(red: "0.194184", green: "0.429349", blue: "0.454553", opacity: "1"))
        XCTAssertEqual(theme.textSyntaxColors.regexCharname, Color(red: "0.421903", green: "0.212783", blue: "0.663785", opacity: "1"))
        XCTAssertEqual(theme.textSyntaxColors.regexNumber, Color(red: "0.11", green: "0", blue: "0.81", opacity: "1"))
        XCTAssertEqual(theme.textSyntaxColors.regexOther, Color(red: "0", green: "0", blue: "0", opacity: "0.85"))
        XCTAssertEqual(theme.textSyntaxColors.string, Color(red: "0.77", green: "0.102", blue: "0.086", opacity: "1"))
        XCTAssertEqual(theme.textSyntaxColors.url, Color(red: "0.055", green: "0.055", blue: "1", opacity: "1"))
    }
}
