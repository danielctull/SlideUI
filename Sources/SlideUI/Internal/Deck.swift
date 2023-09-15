
struct Deck: Equatable, Hashable {
    private let slides: [SlideID]
    private var index = 0

    init() {
        slides = [.none]
    }

    init(slide: SlideID) {
        self.slides = [slide]
    }

    init(slides: [SlideID]) {
        if slides.isEmpty {
            self.slides = [.none]
        } else {
            self.slides = slides
        }
    }

    var current: SlideID {
        slides[index]
    }

    mutating func next() {
        if index < slides.count - 1 {
            self.index = index + 1
        }
    }

    mutating func previous() {
        if index > 0 {
            self.index = index - 1
        }
    }

    mutating func appendDeck(_ deck: Deck) {
        let slides = self.slides + deck.slides
        self = Deck(slides: slides.filter { $0 != .none })
    }
}
