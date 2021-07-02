func readInts() -> [Int] {
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main() {
    let inputs = readInts()
    let (N, K) = (inputs[0], inputs[1])
    var counts = TwoDimensionalArray<Int>(0, (5010, 5010))
    for _ in 0..<N {
        let inputs = readInts()
        let (A, B) = (inputs[0], inputs[1])
        counts[A, B] += 1
    }
    for i in 1...5000 {
        for j in 1...5000 {
            counts[i, j] += counts[i-1, j] + counts[i, j-1] - counts[i-1, j-1]
        }
    }
    var ans = 0
    for height in 1...5000-K {
        for weight in 1...5000-K {
            ans = max(ans, counts[height+K, weight+K] - counts[height+K, weight-1] - counts[height-1, weight+K] + counts[height-1, weight-1])
        }
    }
    print(ans)
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