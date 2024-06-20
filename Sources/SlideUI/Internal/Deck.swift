
struct Deck: Equatable, Hashable {
    private let slides: [SlideInfo]
    private var index = 0

    init() {
        slides = [.none]
    }

    init(slide: SlideInfo) {
        self.slides = [slide]
    }

    init(slides: [SlideInfo]) {
        if slides.isEmpty {
            self.slides = [.none]
        } else {
            self.slides = slides
        }
    }

    var current: SlideInfo {
        slides[index]
    }

    mutating func showSlide(_ info: SlideInfo?) {
        guard let info, let index = slides.firstIndex(of: info) else { return }
        self.index = index
    }

    // Next

    private var nextIndex: Int? {
        guard index < slides.count - 1 else { return nil }
        return index + 1
    }

    var next: SlideInfo? {
        nextIndex.map { slides[$0] }
    }

    // Previous
    
    private var previousIndex: Int? {
        guard index > 0 else { return nil }
        return index - 1
    }

    var previous: SlideInfo? {
        previousIndex.map { slides[$0] }
    }

    mutating func appendDeck(_ deck: Deck) {
        let slides = self.slides + deck.slides
        self = Deck(slides: slides.filter { $0 != .none })
    }
}
