func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main() {
    let N = Int(readLine()!)!
    //累積和用の配列
    var pointsSums = TwoDimensionalArray<Int>(0, (2, N+1))
    for i in 1...N{
        let inputs = readInts()
        let (C, P) = (inputs[0], inputs[1])
        pointsSums[0, i] = pointsSums[0, i-1]
        pointsSums[1, i] = pointsSums[1, i-1]
        pointsSums[C-1, i] += P
    }
    let Q = Int(readLine()!)!
    for _ in 0..<Q{
        let inputs = readInts()
        let (L, R) = (inputs[0], inputs[1])
        let a = pointsSums[0, R] - pointsSums[0, L-1]
        let b = pointsSums[1, R] - pointsSums[1, L-1]
        print(a, b)
    }

}

main()

struct TwoDimensionalArray<Element> {
    var elements: [Element]
    var count: (Int, Int)
    init(repeating initialValue: Element, count: (Int, Int)) {
        self.elements = Array(repeating: initialValue, count: count.0 * count.1)
        self.count = count
    }
    init(_ initialValue: Element, _ count: (Int, Int)) {
        self.init(repeating: initialValue, count: count)
    }
    subscript(i: Int, j: Int) -> Element {
        get {
            return elements[self.count.1 * i + j]
        }
        set {
            elements[self.count.1 * i + j] = newValue
        }
    }
}