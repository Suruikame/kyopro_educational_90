import Foundation

func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    var inputs = readInts()
    let (N, S) = (inputs[0], inputs[1])
    var prices: [(Int, Int)] = []
    for _ in 0..<N {
        inputs = readInts()
        let (a, b) = (inputs[0], inputs[1])
        prices.append((a, b))
    }
    var dp = TwoDimensionalArray<Int>(-1, (N+1, S+1))
    dp[0, 0] = 0
    for i in 0..<N {
        let (a, b) = prices[i]
        for j in 0..<S+1 {
            if dp[i, j] >= 0 {
                if j + a <= S {
                    dp[i+1, j + a] = 0
                }
                if j + b <= S{
                    dp[i+1, j + b] = 1
                }
            }
        }
    }
    var ans: [Character] = []
    var price = S
    if dp[N, S] >= 0 {
        //復元
        for i in (1...N).reversed() {
            if dp[i, price] == 0 {
                ans.append("A")
                price -= prices[i-1].0
            }else if dp[i, price] == 1 {
                ans.append("B")
                price -= prices[i-1].1
            }
        }
        for c in ans.reversed() {
            print(c, terminator: "")
        }
    } else {
        print("Impossible")
    }
    print("\n")  
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