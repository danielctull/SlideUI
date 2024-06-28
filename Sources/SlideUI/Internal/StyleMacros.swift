
@attached(peer, names: suffixed(Style))
internal macro Style() = #externalMacro(
    module: "SlideUIMacros",
    type: "StyleMacro"
)
