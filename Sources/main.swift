struct ChunkingIterator<T:IteratorProtocol>: IteratorProtocol {
    private var wrapped: T
    init(_ wrapped: T) {
        self.wrapped = wrapped
    }
    mutating func next() -> (T.Element, T.Element?)? {
        let first = self.wrapped.next()
        if first == nil {
            return nil
        }
        return (first!, self.wrapped.next())
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
    var it = ChunkingIterator(hexstr.reversed().makeIterator())
    var cur = it.next()
    var result: [UInt8] = []
    while cur != nil {
        var byte: UInt8 = try! hexCharToInt8(cur!.0)
        if cur!.1 != nil {
            let upper = try! hexCharToInt8(cur!.1!)
            byte += upper << 4
        }
        result.append(byte)
        cur = it.next()
    }
    return result
}

print(hexToBytesLE("badbeef"))
