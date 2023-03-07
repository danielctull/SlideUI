
import SwiftUI

extension View {

    /// Sets the action to perform so the presentation advances.
    public func advance(_ advance: @escaping () -> Void) -> some View {
        environment(\.advance, advance)
    }
}

extension EnvironmentValues {

    /// Advance to the next slide.
    public var advance: () -> Void {
        get { self[AdvanceKey.self] }
        set { self[AdvanceKey.self] = newValue }
    }
}

private struct AdvanceKey: EnvironmentKey {
    static let defaultValue = {}
}
