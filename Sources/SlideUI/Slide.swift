
import SwiftUI

public struct Slide<Content: View>: View {

    private let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        VStack {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
