func readInts() -> [Int] {
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main() {
    let N = Int(readLine()!)!
    let A = readInts()
    //dp[i, j] := A[i, j)の答え(開区間だと却って分かりにくかった)
    var dp = TwoDimensionalArray<Int>(-1, (2*N+4, 2*N+4))
    for i in 0..<2*N-1 {
        dp[i, i+2] = abs(A[i+1] - A[i])
    }
    func dfs(_ l: Int, _ r: Int) -> Int {
        if dp[l, r] >= 0 {
            return dp[l, r]
        }
        if l >= r-1 {
            return 1<<60
        }
        var ret = dfs(l+1, r-1) + abs(A[r-1] - A[l])
        for k in l+1...r-1 {
            ret = min(ret, dfs(l, k) + dfs(k, r))
        }
        dp[l, r] = ret
        return ret
    }
    print(dfs(0, 2*N))

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