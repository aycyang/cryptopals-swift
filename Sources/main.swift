struct ChunkingSequence<Base:Sequence>: Sequence {
    private let baseSequence: Base
    private let chunkSize: Int
    init(baseSequence: Base, chunkSize: Int) {
        self.baseSequence = baseSequence
        self.chunkSize = chunkSize
    }
    func makeIterator() -> Iterator {
        Iterator(baseIterator: self.baseSequence.makeIterator(), chunkSize: self.chunkSize)
    }
    struct Iterator: IteratorProtocol {
        private var baseIterator: Base.Iterator
        private let chunkSize: Int
        init(baseIterator: Base.Iterator, chunkSize: Int) {
            self.baseIterator = baseIterator
            self.chunkSize = chunkSize
        }
        mutating func next() -> [Base.Element]? {
            var result: [Base.Element] = []
            while result.count < self.chunkSize {
                let cur = self.baseIterator.next()
                if cur == nil {
                    return result.count == 0 ? nil : result
                }
                result.append(cur!)
            }
            return result;
        }
    }
}

extension Sequence {
    func chunks(ofSize chunkSize: Int) -> ChunkingSequence<Self> {
        return ChunkingSequence(baseSequence: self, chunkSize: chunkSize)
    }
}

enum MyError : Error {
    case hexParseError
}

func hexCharToInt8(_ hexchar: Character) throws -> UInt8 {
    switch hexchar {
        case "0": return 0 case "1": return 1
        case "2": return 2 case "3": return 3
        case "4": return 4 case "5": return 5
        case "6": return 6 case "7": return 7
        case "8": return 8 case "9": return 9
        case "a": return 10 case "b": return 11
        case "c": return 12 case "d": return 13
        case "e": return 14 case "f": return 15
        default: throw MyError.hexParseError
    }
}

func hexToBytesLE(_ hexstr: String) -> [UInt8] {
    var result: [UInt8] = []
    let seq = hexstr.reversed().chunks(ofSize: 3)
    for b in seq {
        print(b)
        result.append(0)
    }
    return result
}

func bytesLEToBase64(_ bytes: [UInt8]) -> String {
    // TODO use chunking iterator with chunk size of 3
    return ""
}

let _ = hexToBytesLE("badbeef")
let _ = bytesLEToBase64([255, 254, 253, 252])
