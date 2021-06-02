protocol Modulo {
    static var value: Int {get}
    static var isPrime: Bool {get}
}
//法の変更はここでする。
struct Mod: Modulo {
    static let value = Int(1e9)+7
    static let isPrime = true
}

struct OriginalModInt<m: Modulo> {
    var mod: Int = m.value
    let moduloIsPrime: Bool = m.isPrime
    let value: Int
    init(_ value: Int){
        self.value = ((value % mod) + mod) % mod
    }
}
typealias ModInt = OriginalModInt<Mod>

extension ModInt: ExpressibleByIntegerLiteral {
    typealias IntegerLiteralType = Int
    init(integerLiteral value: Int) {
        self.init(value)
    }
}

extension ModInt: CustomStringConvertible{
    var description: String{
        return self.value.description
    }
}

extension ModInt: Equatable {
    static func == (lhs: ModInt, rhs: ModInt) -> Bool {
        return lhs.value == rhs.value
    }
    static func == (lhs: Int, rhs: ModInt) -> Bool {
        return lhs == rhs.value
    }
    static func == (lhs: ModInt, rhs: Int) -> Bool {
        return lhs.value == rhs
    }

    static func != (lhs: ModInt, rhs: ModInt) -> Bool {
        return lhs.value != rhs.value
    }
    static func != (lhs: Int, rhs: ModInt) -> Bool {
        return lhs != rhs.value
    }
    static func != (lhs: ModInt, rhs: Int) -> Bool {
        return lhs.value != rhs
    }
}

extension ModInt: AdditiveArithmetic {
    static prefix func - (value: ModInt) -> ModInt {
        return ModInt(-value.value)
    }

    static func + (lhs: ModInt, rhs: ModInt) -> ModInt {
        return ModInt(lhs.value + rhs.value)
    }
    static func + (lhs: Int, rhs: ModInt) -> ModInt {
        return ModInt(lhs + rhs.value)
    }
    static func + (lhs: ModInt, rhs: Int) -> ModInt {
        return ModInt(lhs.value + rhs)
    }

    static func += (lhs: inout ModInt, rhs: ModInt) {
        lhs = lhs + rhs
    }
    static func += (lhs: inout ModInt, rhs: Int) {
        lhs = lhs + rhs
    }

    static func - (lhs: ModInt, rhs: ModInt) -> ModInt {
        return ModInt(lhs.value - rhs.value)
    }
    static func - (lhs: Int, rhs: ModInt) -> ModInt {
        return ModInt(lhs - rhs.value)
    }
    static func - (lhs: ModInt, rhs: Int) -> ModInt {
        return ModInt(lhs.value - rhs)
    }

    static func -= (lhs: inout ModInt, rhs: ModInt) {
        lhs = lhs - rhs
    }
    static func -= (lhs: inout ModInt, rhs: Int) {
        lhs = lhs - rhs
    }
}
//掛算
extension ModInt: Numeric {
    init?<T>(exactly source: T) where T : BinaryInteger {
        return nil
    }

    var magnitude: Int {
        return self.value
    }

    static func * (lhs: ModInt, rhs: ModInt) -> ModInt {
        return self.init(lhs.value * rhs.value)
    }
    static func * (lhs: Int, rhs: ModInt) -> ModInt {
        return self.init(lhs * rhs.value)
    }
    static func * (lhs: ModInt, rhs: Int) -> ModInt {
        return self.init(lhs.value * rhs)
    }

    static func *= (lhs: inout ModInt, rhs: ModInt) {
        lhs = lhs * rhs
    }
    static func *= (lhs: inout ModInt, rhs: Int) {
        lhs = lhs * rhs
    }

    typealias Magnitude = Int
}

//除算
extension ModInt {
    var inverse: ModInt{
        let a = self
        var x = 0
        var y = 0
        _ = extendedGCDinModInt(a.value, mod, &x, &y)
        return ModInt(x)
    }
    private func extendedGCDinModInt(_ a: Int, _ b: Int, _ x: inout Int, _ y: inout Int) -> Int{
        if(b == 0){
            x = 1
            y = 0
            return a
        }
        let q = a/b
        let g = extendedGCDinModInt(b, a - q*b, &x, &y)
        let z = x - q*y
        x = y
        y = z
        return g
    }

    static func / (lhs: ModInt, rhs: ModInt) -> ModInt {
        return lhs * rhs.inverse
    }
    static func /= (lhs: inout ModInt, rhs: ModInt) {
        lhs = lhs / rhs
    }
}

//累乗
extension ModInt {
    func toThePower(of: Int) -> ModInt {
        var p = of
        var res = ModInt(1)
        var x = self
        while(p > 0){
            if((p & 1) == 1){
                res *= x
            }
            x = x * x
            p >>= 1
        }
        return res
    }
}

//階乗系
extension ModInt {
    var factorial: ModInt {
        return Comb().fact(self.value)
    }
    var factInv: ModInt {
        return Comb().factInv(self.value)
    }
    var integerInv: ModInt {
        return Comb().integerInv(self.value)
    }

    //moduloが素数でn, k < m。前計算O(n)
    func choose(_ k: Int) -> ModInt{
        let n = self.value
        if(n < 0 || k < 0 || n < k){
            return 0
        }

        return self.factorial * ModInt(k).factInv * ModInt(n-k).factInv
    }
}

class Comb {
    var size = 1
    var next_size = 2
    //階乗テーブル
    var factTable: [ModInt] = [1]
    //階乗の逆元(1/(n!))のテーブル
    var factInvTable: [ModInt] = [1]
    //整数の逆元テーブル
    var integerInvTable: [ModInt] = [1]
    func extend() {
        var i = size
        factTable += Array(repeating: 0, count: size)
        factInvTable += Array(repeating: 0, count: size)
        integerInvTable += Array(repeating: 0, count: size)
        while(i < 2*size) {
            factTable[i] = factTable[i-1] * i
            integerInvTable[i] = ModInt(i).inverse
            factInvTable[i] = factInvTable[i-1] * integerInvTable[i]
            i += 1
        }
        size *= 2
    }
    func fact(_ val: Int) -> ModInt {
        while val >= size {
            extend()
        }
        return factTable[val]
    }
    func factInv(_ val: Int) -> ModInt {
        while val >= size {
            extend()
        }
        return factInvTable[val]
    }
    func integerInv(_ val: Int) -> ModInt {
        while val >= size {
            extend()
        }
        return integerInvTable[val]
    }
}

let N = Int(readLine()!)!
let S = Array(readLine()!)
var dp: [[ModInt]] = Array(repeating: Array(repeating: 0, count: 7), count: N)
if S[0] == "a" {
    dp[0][0] = 1
}
for i in 1..<N {
    let chr = S[i]
    dp[i] = dp[i-1]
    switch chr{
        case "a":
        dp[i][0] = dp[i-1][0]+1
        case "t":
        dp[i][1] = dp[i-1][1]+dp[i-1][0]
        case "c":
        dp[i][2] = dp[i-1][2]+dp[i-1][1]
        case "o":
        dp[i][3] = dp[i-1][3]+dp[i-1][2]
        case "d":
        dp[i][4] = dp[i-1][4]+dp[i-1][3]
        case "e":
        dp[i][5] = dp[i-1][5]+dp[i-1][4]
        case "r":
        dp[i][6] = dp[i-1][6]+dp[i-1][5]
        default:
        dp[0][1]=0
    }
}

print(dp[N-1][6])
        
          

