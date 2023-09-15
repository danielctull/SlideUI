
import SwiftUI

public struct Presentation<Content: View>: View {

    @State private var _index: Int?
    
    private var index: Int? {
        get {
            if slides.count > 0 {
                return _index ?? 0
            } else {
                return nil
            }
        }
    }

    @State private var slides: [SlideIndex] = []
    private let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    private var currentSlide: SlideIndex {
        guard let index else { return SlideIndex() }
        return slides[index]
    }

    private func increment() {
        if let index, index < slides.count - 1 {
            _index = index + 1
        } else {
            _index = 0
        }
    }

    private func decrement() {
        if let index, index > 0 {
            _index = index - 1
        } else {
            _index = 0
        }
    }

    public var body: some View {
        ZStack {
            content()
        }
        .overlay {
            HStack(spacing: 0) {
                Color.white.opacity(0.0000001)
                    .onTapGesture(perform: decrement)
                Color.white.opacity(0.0000001)
                    .onTapGesture(perform: increment)
            }
        }
        .environment(\.currentSlide, currentSlide)
        .slides { slides = $0 }
    }
}
