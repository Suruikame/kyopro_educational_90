func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}


func main(){
    let N  = Int(readLine()!)!
    let W = readInts()
    let B = readInts()
    var grundies = TwoDimensionalArray<Int>(-1, (100, 1500))
    grundies[0, 0] = 0
    grundies[0, 1] = 0
    func getGrundy(_ w: Int, _ b: Int) -> Int {
        if grundies[w, b] >= 0 {
            return grundies[w, b]
        }
        var next: [Int] = [Int]()
        if w >= 1 {
            next.append(getGrundy(w-1, b+w))
        }
        if b >= 2 {
            for k in 1...(b/2) {
                next.append(getGrundy(w, b-k))
            }
        }
        func mex(_ arr: [Int]) -> Int {
            let arr = Set<Int>(arr)
            var checked: [Bool] = Array(repeating: false, count: 2000)
            for a in arr {
                checked[a] = true
            }
            for i in 0..<2000 {
                if !checked[i] {
                    return i
                }
            }
            return -1
        }
        grundies[w, b] = mex(next)
        return grundies[w, b]
    }
    var ans = 0
    for i in 0..<N {
        ans ^= getGrundy(W[i], B[i])
    }
    if ans == 0 {
        print("Second")
    } else {
        print("First")
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