func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    let inputs = readInts()
    let (H, W) = (inputs[0], inputs[1])
    var A = TwoDimensionalArray<Int>(repeating: 0, count: (H, W))
    //横方向に足した配列
    var sumsH: [Int] = Array(repeating: 0, count: H)
    //縦方向に足した配列
    var sumsW: [Int] = Array(repeating: 0, count: W)
    for i in 0..<H{
        //readInts()のmapの中身がInt($0)!だと間に合わない。
        //Substring -> Intの変換が遅いのが原因だと思われる。
        //一度Stringに変換すると高速化できる。
        let newArray = readInts()
        for (j, a) in newArray.enumerated() {
            A[i, j] = a
            sumsW[j] += a
            sumsH[i] += a
        }
    }
    //毎回print()すると間に合わないので、文字列で答えを作って出力
    var ans = ""
    for i in 0..<H{
        for j in 0..<W{
            ans += String(sumsH[i] + sumsW[j] - A[i,j]) + " "
        }
        ans += "\n"
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