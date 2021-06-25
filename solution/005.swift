import Foundation
func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    let MOD = Int(1e9) + 7
    let inputs = readInts()
    let (N, B, _) = (inputs[0], inputs[1], inputs[2])
    let cs = readInts()
    //dp[i, j] = 2^i桁目までで、Bで割ったあまりがjであるものの個数(mod 1e9+7)
    var dp = TwoDimensionalArray<Int>(0, (64, B))
    for c in cs {
        dp[0, c%B] += 1
    }
    //10^(2^(i-1))のリスト
    var powersOf10: [Int] = [10 % B]
    for _ in 0...62 {
        powersOf10.append(powersOf10.last! * powersOf10.last! % B)
    }
    //(2^(i-1))桁の分を求める
    for i in 1...62 {
        for j in 0..<B {
            for k in 0..<B {
                dp[i, (powersOf10[i-1]*j + k) % B] += dp[i-1, j] * dp[i-1, k]
                dp[i, (powersOf10[i-1]*j + k) % B] %= MOD
            }
        }
    }
    /*
    i & N == iを満たすようなiについて、i桁の時の答えを記録していく。
    ans[j]は iの二進数表記がj桁の時の答え。
    例：N = 1101の時
    i = 101までの答えが求まったとすると、この5桁分と、次に加える8桁分の答えをかければok。
    コードでは、[8桁分] + [5桁分]*10^8なので、5桁分をBで割ったあまりj、8桁分をBで割ったあまりk。
    */
    var ans = TwoDimensionalArray<Int>(0, (64, B))
    ans[0, 0] = 1
    for i in 0..<62 {
        if (N>>i) & 1 == 1 {
            for j in 0..<B {
                for k in 0..<B {
                    ans[i+1, (j*powersOf10[i]+k)%B] += ans[i, j] * dp[i, k] % MOD
                    ans[i+1, (j*powersOf10[i]+k)%B] %= MOD
                }
            }
        } else {
            for j in 0..<B {
                ans[i+1, j] = ans[i, j]
            }
        }
    }
    print(ans[62, 0])
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