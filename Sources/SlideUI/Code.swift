
@freestanding(expression)
public macro stringify<T>(_ value: T) -> (T, String) = #externalMacro(module: "SlideUIMacros", type: "StringifyMacro")
