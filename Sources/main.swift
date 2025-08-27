struct ChunkingIterator<T:IteratorProtocol>: IteratorProtocol {
    private var wrapped: T
    private let chunkSize: Int
    init(wrapped: T, chunkSize: Int) {
        self.wrapped = wrapped
        self.chunkSize = chunkSize
    }
    mutating func next() -> [T.Element]? {
        var result: [T.Element] = []
        while result.count < self.chunkSize {
            let cur = self.wrapped.next()
            if cur == nil {
                return result.count == 0 ? nil : result
            }
            result.append(cur!)
        }
        return result;
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
    var it = ChunkingIterator(wrapped: hexstr.reversed().makeIterator(), chunkSize: 2)
    var cur = it.next()
    var result: [UInt8] = []
    while cur != nil {
        print(cur!)
        cur = it.next()
    }
    return result
}

func bytesLEToBase64(_ bytes: [UInt8]) -> String {
    // TODO use chunking iterator with chunk size of 3
    return ""
}

hexToBytesLE("badbeef")
bytesLEToBase64([255, 254, 253, 252])
