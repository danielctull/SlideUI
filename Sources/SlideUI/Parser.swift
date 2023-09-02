
import SwiftIDEUtils
import SwiftSyntax
import SwiftParser

extension Array<Token> {

    init(code: some StringProtocol) {
        let source = Parser.parse(source: String(code))
        let tokenizer = Tokenizer(viewMode: .sourceAccurate)
        _ = tokenizer.visit(source)
        self = tokenizer.tokens
    }
}

final class Tokenizer: SyntaxRewriter {

    var tokens: [Token] = []

    override func visit(_ token: TokenSyntax) -> TokenSyntax {

        if let f = token.as(FunctionDeclSyntax.self) {
            print(f)
        }
//
        print(token, token.tokenKind, token.kind, token.tokenClassification.kind, "DETERMINED:", Token.Classification(token))
        tokens.append(contentsOf: token.tokens)
        return super.visit(token)
    }

    override func visit(_ node: FunctionCallExprSyntax) -> ExprSyntax {
//        for token in node.tokens(viewMode: viewMode) {
//            if token.text == node.calledExpression.description.trimmingCharacters(in: .whitespacesAndNewlines) {
//                if token.text.first?.isUppercase ?? false {
//                    tokens.append(Token(value: token.text, classification: .identifierTypeSystem))
//                } else {
//                    tokens.append(Token(value: token.text, classification: .identifierFunctionSystem))
//                }
//            } else {
//                tokens.append(contentsOf: token.tokens)
//            }
//        }

        return super.visit(node)
    }

//    override func visit(_ node: FunctionDeclSyntax) -> FunctionDeclSyntax {
//
//    }

     override func visit(_ node: FunctionParameterSyntax) -> FunctionParameterSyntax {

         return super.visit(node)
     }
}

// MARK: - Token Conversion

extension Token {

    fileprivate init(_ token: TokenSyntax) {
        switch token.kind {
        case .token: self = .plain(token.text)
//        case .accessesEffect: self = .plain(token.text)
        case .accessorBlock: self = .plain(token.text)
        case .accessorDecl: self = .plain(token.text)
        case .accessorEffectSpecifiers: self = .plain(token.text)
//        case .accessorInitEffects: self = .plain(token.text)
        case .accessorList: self = .plain(token.text)
        case .accessorParameter: self = .plain(token.text)
        case .actorDecl: self = .plain(token.text)
        case .arrayElementList: self = .plain(token.text)
        case .arrayElement: self = .plain(token.text)
        case .arrayExpr: self = .plain(token.text)
        case .arrayType: self = .plain(token.text)
        case .arrowExpr: self = .plain(token.text)
        case .asExpr: self = .plain(token.text)
        case .assignmentExpr: self = .plain(token.text)
        case .associatedtypeDecl: self = .plain(token.text)
        case .attributeList: self = .plain(token.text)
        case .attribute: self = .plain(token.text)
        case .attributedType: self = .plain(token.text)
        case .availabilityArgument: self = .plain(token.text)
        case .availabilityCondition: self = .plain(token.text)
        case .availabilityEntry: self = .plain(token.text)
        case .availabilityLabeledArgument: self = .plain(token.text)
        case .availabilitySpecList: self = .plain(token.text)
        case .availabilityVersionRestrictionListEntry: self = .plain(token.text)
        case .availabilityVersionRestrictionList: self = .plain(token.text)
        case .availabilityVersionRestriction: self = .plain(token.text)
        case .awaitExpr: self = .plain(token.text)
        case .backDeployedAttributeSpecList: self = .plain(token.text)
        case .binaryOperatorExpr: self = .plain(token.text)
        case .booleanLiteralExpr: self = .plain(token.text)
        case .borrowExpr: self = .plain(token.text)
        case .breakStmt: self = .plain(token.text)
        case .canImportExpr: self = .plain(token.text)
        case .canImportVersionInfo: self = .plain(token.text)
        case .caseItemList: self = .plain(token.text)
        case .caseItem: self = .plain(token.text)
        case .catchClauseList: self = .plain(token.text)
        case .catchClause: self = .plain(token.text)
        case .catchItemList: self = .plain(token.text)
        case .catchItem: self = .plain(token.text)
        case .classDecl: self = .plain(token.text)
        case .classRestrictionType: self = .plain(token.text)
        case .closureCaptureItemList: self = .plain(token.text)
        case .closureCaptureItemSpecifier: self = .plain(token.text)
        case .closureCaptureItem: self = .plain(token.text)
        case .closureCaptureSignature: self = .plain(token.text)
        case .closureExpr: self = .plain(token.text)
        case .closureParamList: self = .plain(token.text)
        case .closureParam: self = .plain(token.text)
        case .closureParameterClause: self = .plain(token.text)
        case .closureParameterList: self = .plain(token.text)
        case .closureParameter: self = .plain(token.text)
        case .closureSignature: self = .plain(token.text)
        case .codeBlockItemList: self = .plain(token.text)
        case .codeBlockItem: self = .plain(token.text)
        case .codeBlock: self = .plain(token.text)
        case .compositionTypeElementList: self = .plain(token.text)
        case .compositionTypeElement: self = .plain(token.text)
        case .compositionType: self = .plain(token.text)
        case .conditionElementList: self = .plain(token.text)
        case .conditionElement: self = .plain(token.text)
        case .conformanceRequirement: self = .plain(token.text)
        case .constrainedSugarType: self = .plain(token.text)
        case .continueStmt: self = .plain(token.text)
        case .conventionAttributeArguments: self = .plain(token.text)
        case .conventionWitnessMethodAttributeArguments: self = .plain(token.text)
        case .copyExpr: self = .plain(token.text)
        case .declModifierDetail: self = .plain(token.text)
        case .declModifier: self = .plain(token.text)
        case .declNameArgumentList: self = .plain(token.text)
        case .declNameArgument: self = .plain(token.text)
        case .declNameArguments: self = .plain(token.text)
        case .declName: self = .plain(token.text)
        case .deferStmt: self = .plain(token.text)
        case .deinitEffectSpecifiers: self = .plain(token.text)
        case .deinitializerDecl: self = .plain(token.text)
        case .derivativeRegistrationAttributeArguments: self = .plain(token.text)
        case .designatedTypeElement: self = .plain(token.text)
        case .designatedTypeList: self = .plain(token.text)
        case .dictionaryElementList: self = .plain(token.text)
        case .dictionaryElement: self = .plain(token.text)
        case .dictionaryExpr: self = .plain(token.text)
        case .dictionaryType: self = .plain(token.text)
        case .differentiabilityParamList: self = .plain(token.text)
        case .differentiabilityParam: self = .plain(token.text)
        case .differentiabilityParamsClause: self = .plain(token.text)
        case .differentiabilityParams: self = .plain(token.text)
        case .differentiableAttributeArguments: self = .plain(token.text)
        case .discardAssignmentExpr: self = .plain(token.text)
        case .discardStmt: self = .plain(token.text)
        case .doStmt: self = .plain(token.text)
        case .documentationAttributeArgument: self = .plain(token.text)
        case .documentationAttributeArguments: self = .plain(token.text)
        case .dynamicReplacementArguments: self = .plain(token.text)
        case .editorPlaceholderDecl: self = .plain(token.text)
        case .editorPlaceholderExpr: self = .plain(token.text)
        case .effectsArguments: self = .plain(token.text)
        case .enumCaseDecl: self = .plain(token.text)
        case .enumCaseElementList: self = .plain(token.text)
        case .enumCaseElement: self = .plain(token.text)
        case .enumCaseParameterClause: self = .plain(token.text)
        case .enumCaseParameterList: self = .plain(token.text)
        case .enumCaseParameter: self = .plain(token.text)
        case .enumDecl: self = .plain(token.text)
        case .exposeAttributeArguments: self = .plain(token.text)
        case .exprList: self = .plain(token.text)
        case .expressionPattern: self = .plain(token.text)
        case .expressionSegment: self = .plain(token.text)
        case .expressionStmt: self = .plain(token.text)
        case .extensionDecl: self = .plain(token.text)
        case .fallthroughStmt: self = .plain(token.text)
        case .floatLiteralExpr: self = .plain(token.text)
        case .forInStmt: self = .plain(token.text)
        case .forcedValueExpr: self = .plain(token.text)
        case .functionCallExpr: self = .plain(token.text)
        case .functionDecl: self = .plain(token.text)
        case .functionEffectSpecifiers: self = .plain(token.text)
        case .functionParameterList: self = .plain(token.text)
        case .functionParameter: self = .plain(token.text)
        case .functionSignature: self = .plain(token.text)
        case .functionType: self = .plain(token.text)
        case .genericArgumentClause: self = .plain(token.text)
        case .genericArgumentList: self = .plain(token.text)
        case .genericArgument: self = .plain(token.text)
        case .genericParameterClause: self = .plain(token.text)
        case .genericParameterList: self = .plain(token.text)
        case .genericParameter: self = .plain(token.text)
        case .genericRequirementList: self = .plain(token.text)
        case .genericRequirement: self = .plain(token.text)
        case .genericWhereClause: self = .plain(token.text)
        case .guardStmt: self = .plain(token.text)
        case .identifierExpr: self = .plain(token.text)
        case .identifierPattern: self = .plain(token.text)
        case .ifConfigClauseList: self = .plain(token.text)
        case .ifConfigClause: self = .plain(token.text)
        case .ifConfigDecl: self = .plain(token.text)
        case .ifExpr: self = .plain(token.text)
        case .implementsAttributeArguments: self = .plain(token.text)
        case .implicitlyUnwrappedOptionalType: self = .plain(token.text)
        case .importDecl: self = .plain(token.text)
//        case .importPath: self = .plain(token.text)
        case .importPathComponent: self = .plain(token.text)
        case .inOutExpr: self = .plain(token.text)
        case .infixOperatorExpr: self = .plain(token.text)
        case .inheritedTypeList: self = .plain(token.text)
        case .inheritedType: self = .plain(token.text)
        case .initializerClause: self = .plain(token.text)
        case .initializerDecl: self = .plain(token.text)
//        case .initializesEffect: self = .plain(token.text)
        case .integerLiteralExpr: self = .plain(token.text)
        case .isExpr: self = .plain(token.text)
        case .isTypePattern: self = .plain(token.text)
        case .keyPathComponentList: self = .plain(token.text)
        case .keyPathComponent: self = .plain(token.text)
        case .keyPathExpr: self = .plain(token.text)
        case .keyPathOptionalComponent: self = .plain(token.text)
        case .keyPathPropertyComponent: self = .plain(token.text)
        case .keyPathSubscriptComponent: self = .plain(token.text)
        case .labeledSpecializeEntry: self = .plain(token.text)
        case .labeledStmt: self = .plain(token.text)
        case .layoutRequirement: self = .plain(token.text)
        case .macroDecl: self = .plain(token.text)
        case .macroExpansionDecl: self = .plain(token.text)
        case .macroExpansionExpr: self = .plain(token.text)
        case .matchingPatternCondition: self = .plain(token.text)
        case .memberAccessExpr: self = .plain(token.text)
        case .memberDeclBlock: self = .plain(token.text)
        case .memberDeclListItem: self = .plain(token.text)
        case .memberDeclList: self = .plain(token.text)
        case .memberTypeIdentifier: self = .plain(token.text)
        case .metatypeType: self = .plain(token.text)
        case .missingDecl: self = .plain(token.text)
        case .missingExpr: self = .plain(token.text)
        case .missingPattern: self = .plain(token.text)
        case .missingStmt: self = .plain(token.text)
        case .missing: self = .plain(token.text)
        case .missingType: self = .plain(token.text)
        case .modifierList: self = .plain(token.text)
        case .moveExpr: self = .plain(token.text)
        case .multipleTrailingClosureElementList: self = .plain(token.text)
        case .multipleTrailingClosureElement: self = .plain(token.text)
        case .namedOpaqueReturnType: self = .plain(token.text)
        case .nilLiteralExpr: self = .plain(token.text)
        case .objCSelectorPiece: self = .plain(token.text)
        case .objCSelector: self = .plain(token.text)
        case .opaqueReturnTypeOfAttributeArguments: self = .plain(token.text)
        case .operatorDecl: self = .plain(token.text)
        case .operatorPrecedenceAndTypes: self = .plain(token.text)
        case .optionalBindingCondition: self = .plain(token.text)
        case .optionalChainingExpr: self = .plain(token.text)
        case .optionalType: self = .plain(token.text)
        case .originallyDefinedInArguments: self = .plain(token.text)
        case .packElementExpr: self = .plain(token.text)
        case .packExpansionExpr: self = .plain(token.text)
        case .packExpansionType: self = .plain(token.text)
        case .packReferenceType: self = .plain(token.text)
        case .parameterClause: self = .plain(token.text)
        case .patternBindingList: self = .plain(token.text)
        case .patternBinding: self = .plain(token.text)
        case .postfixIfConfigExpr: self = .plain(token.text)
        case .postfixUnaryExpr: self = .plain(token.text)
        case .poundSourceLocationArgs: self = .plain(token.text)
        case .poundSourceLocation: self = .plain(token.text)
        case .precedenceGroupAssignment: self = .plain(token.text)
        case .precedenceGroupAssociativity: self = .plain(token.text)
        case .precedenceGroupAttributeList: self = .plain(token.text)
        case .precedenceGroupDecl: self = .plain(token.text)
        case .precedenceGroupNameElement: self = .plain(token.text)
        case .precedenceGroupNameList: self = .plain(token.text)
        case .precedenceGroupRelation: self = .plain(token.text)
        case .prefixOperatorExpr: self = .plain(token.text)
        case .primaryAssociatedTypeClause: self = .plain(token.text)
        case .primaryAssociatedTypeList: self = .plain(token.text)
        case .primaryAssociatedType: self = .plain(token.text)
        case .protocolDecl: self = .plain(token.text)
        case .qualifiedDeclName: self = .plain(token.text)
        case .regexLiteralExpr: self = .plain(token.text)
        case .repeatWhileStmt: self = .plain(token.text)
        case .returnClause: self = .plain(token.text)
        case .returnStmt: self = .plain(token.text)
        case .sameTypeRequirement: self = .plain(token.text)
        case .sequenceExpr: self = .plain(token.text)
        case .simpleTypeIdentifier: self = .plain(token.text)
        case .sourceFile: self = .plain(token.text)
        case .specializeAttributeSpecList: self = .plain(token.text)
        case .specializeExpr: self = .plain(token.text)
        case .stringLiteralExpr: self = .plain(token.text)
        case .stringLiteralSegments: self = .plain(token.text)
        case .stringSegment: self = .plain(token.text)
        case .structDecl: self = .plain(token.text)
        case .subscriptDecl: self = .plain(token.text)
        case .subscriptExpr: self = .plain(token.text)
        case .superRefExpr: self = .plain(token.text)
        case .suppressedType: self = .plain(token.text)
        case .switchCaseLabel: self = .plain(token.text)
        case .switchCaseList: self = .plain(token.text)
        case .switchCase: self = .plain(token.text)
        case .switchDefaultLabel: self = .plain(token.text)
        case .switchExpr: self = .plain(token.text)
        case .targetFunctionEntry: self = .plain(token.text)
        case .ternaryExpr: self = .plain(token.text)
        case .throwStmt: self = .plain(token.text)
        case .tryExpr: self = .plain(token.text)
        case .tupleExprElementList: self = .plain(token.text)
        case .tupleExprElement: self = .plain(token.text)
        case .tupleExpr: self = .plain(token.text)
        case .tuplePatternElementList: self = .plain(token.text)
        case .tuplePatternElement: self = .plain(token.text)
        case .tuplePattern: self = .plain(token.text)
        case .tupleTypeElementList: self = .plain(token.text)
        case .tupleTypeElement: self = .plain(token.text)
        case .tupleType: self = .plain(token.text)
        case .typeAnnotation: self = .plain(token.text)
        case .typeEffectSpecifiers: self = .plain(token.text)
        case .typeExpr: self = .plain(token.text)
        case .typeInheritanceClause: self = .plain(token.text)
        case .typeInitializerClause: self = .plain(token.text)
        case .typealiasDecl: self = .plain(token.text)
        case .unavailableFromAsyncArguments: self = .plain(token.text)
        case .underscorePrivateAttributeArguments: self = .plain(token.text)
        case .unexpectedNodes: self = .plain(token.text)
        case .unresolvedAsExpr: self = .plain(token.text)
        case .unresolvedIsExpr: self = .plain(token.text)
        case .unresolvedPatternExpr: self = .plain(token.text)
        case .unresolvedTernaryExpr: self = .plain(token.text)
        case .valueBindingPattern: self = .plain(token.text)
        case .variableDecl: self = .plain(token.text)
        case .versionComponentList: self = .plain(token.text)
        case .versionComponent: self = .plain(token.text)
        case .versionTuple: self = .plain(token.text)
        case .whereClause: self = .plain(token.text)
        case .whileStmt: self = .plain(token.text)
        case .wildcardPattern: self = .plain(token.text)
        case .yieldExprListElement: self = .plain(token.text)
        case .yieldExprList: self = .plain(token.text)
        case .yieldList: self = .plain(token.text)
        case .yieldStmt: self = .plain(token.text)
        default: self = .plain(token.text)
        }
    }


    fileprivate init(_ piece: TriviaPiece) {
        switch piece {
        case let .backslashes(count): self = .plain(repeating: "\\", count: count)
        case let .blockComment(string): self = .comment(string)
        case let .carriageReturns(count): self = .plain(repeating: "", count: count)
        case let .carriageReturnLineFeeds(count): self = .plain(repeating: "", count: count)
        case let .docBlockComment(string): self = .commentDoc(string)
        case let .docLineComment(string): self = .commentDoc(string)
        case let .formfeeds(count): self = .plain(repeating: "", count: count)
        case let .lineComment(string): self = .comment(string)
        case let .newlines(count): self = .plain(repeating: "\n", count: count)
        case let .pounds(count): self = .plain(repeating: "#", count: count)
        case let .shebang(string): self = .plain(string)
        case let .spaces(count): self = .plain(repeating: " ", count: count)
        case let .tabs(count): self = .plain(repeating: "\t", count: count)
        case let .unexpectedText(string): self = .plain(string)
        case let .verticalTabs(count): self = .plain(repeating: "", count: count)
        }
    }

    private static func plain(repeating string: String, count: Int) -> Self {
        .plain(String(repeating: string, count: count))
    }
}

// MARK: - Tokenizer

final class T: SyntaxVisitor {
}


extension TokenSyntax {

    fileprivate var tokens: [Token] {
        let leading = leadingTrivia.pieces.map(Token.init)
        let token = Token(value: text, classification: Token.Classification(self))
        let trailing = trailingTrivia.pieces.map(Token.init)
        return leading + [token] + trailing
    }
}

extension Token.Classification {

    fileprivate init(_ token: TokenSyntax) {

        var previous: TokenKind? {
            token.previousToken(viewMode: .sourceAccurate)?.tokenKind
        }

        switch token.tokenClassification.kind {
        case .attribute: self = .attribute
        case .blockComment: self = .comment
        case .buildConfigId: self = .preprocessor
        case .docBlockComment: self = .commentDoc
        case .docLineComment: self = .commentDoc
        case .dollarIdentifier: self = .identifierVariable
        case .editorPlaceholder: self = .plain
        case .floatingLiteral: self = .number

        case .identifier where previous == .keyword(Keyword.actor): self = .declarationType
        case .identifier where previous == .keyword(Keyword.class): self = .declarationType
        case .identifier where previous == .keyword(Keyword.enum): self = .declarationType
        case .identifier where previous == .keyword(Keyword.protocol): self = .declarationType
        case .identifier where previous == .keyword(Keyword.struct): self = .declarationType

        case .identifier where previous == .keyword(Keyword.func): self = .declarationOther
        case .identifier where previous == .keyword(Keyword.let): self = .declarationOther
        case .identifier where previous == .keyword(Keyword.var): self = .declarationOther

        case .identifier where previous == .keyword(Keyword.macro): self = .identifierMacro

        case .identifier: self = .plain

        case .integerLiteral: self = .number
        case .keyword: self = .keyword
        case .lineComment: self = .comment
        case .none: self = .plain
        case .objectLiteral: self = .plain
        case .operatorIdentifier: self = .preprocessor
        case .poundDirective: self = .preprocessor
        case .regexLiteral: self = .regex
        case .stringInterpolationAnchor: self = .string
        case .stringLiteral: self = .string
        case .typeIdentifier: self = .identifierType
        }
    }
}


// This is a comment
private final class Tokenizer2: SyntaxRewriter {

    var tokens: [Token] = []

    func visit(outside token: TokenSyntax) -> TokenSyntax {
        print(token, token.tokenKind, token.kind)
        tokens.append(contentsOf: token.tokens)
        return super.visit(token)
    }
}
