// The Swift Programming Language
// https://docs.swift.org/swift-book

//for c in "abcdef".reversed().chunks(ofCount: 2) {
//    print(c)
//}

struct ChunkedIterator: IteratorProtocol {
    let innerIterator: any IteratorProtocol

    init(_ inner: any IteratorProtocol) {
        self.innerIterator = inner
    }

    mutating func next() -> Element? {
        return self.innerIterator.next();
    }

}

extension Sequence {
    func chunks(ofCount: Int) -> Int {
        return ofCount
    }
}

print([1,2,3].chunks(ofCount: 2))
