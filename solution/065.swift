import Foundation
func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

/// ModInt
/// modは固定
/// 基本的にはIntと同じ
/// n C r　を計算したい時は n.choose(r)
/// n! (階乗)を計算したい時は n.factorial()
struct ModInt {
    static let mod: Int = 998244353
    static let moduloIsPrime: Bool = true
    static var factorsTableCreated: Bool = false
    let value: Int
    init(_ value: Int) {
        let m = ModInt.mod
        self.value = ((value % m) + m) % m
    }
    init?(_ value: String) {
        let v = Int(value)
        if v == nil {
            return nil
        } else {
            self.init(v!)
        }
    }
}

extension ModInt: ExpressibleByIntegerLiteral,  CustomStringConvertible{
    typealias IntegerLiteralType = Int
    init(integerLiteral value: Int) {
        self.init(value)
    }
    var description: String{
        return self.value.description
    }
}

//等号、四則演算、累乗
extension ModInt: Equatable, AdditiveArithmetic, Numeric {
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

    var inverse: ModInt{
        let a = self
        var x = 0
        var y = 0
        _ = extendedGCDinModInt(a.value, ModInt.mod, &x, &y)
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

extension ModInt {
    func choose(_ k: Int) -> ModInt {
        let n = self.value
        if n < k || n < 0 || k < 0 {
            return 0
        } 
        return FactorialTables.fact(n) * FactorialTables.factInv(k) * FactorialTables.factInv(n - k)
    }
    func choose(_ k: ModInt) -> ModInt {
        return self.choose(k.value)
    }
    func factorial() -> ModInt {
        return FactorialTables.fact(self.value)
    }
}

struct FactorialTables {
    static var size = 1
    //階乗テーブル
    static var factTable: [ModInt] = [1]
    //階乗の逆元(1/(n!))のテーブル
    static var factInvTable: [ModInt] = [1]
    //整数の逆元テーブル
    static var integerInvTable: [ModInt] = [1]
    static func extend() {
        var i = Self.size
        Self.factTable += Array(repeating: 0, count: Self.size)
        Self.factInvTable += Array(repeating: 0, count: Self.size)
        Self.integerInvTable += Array(repeating: 0, count: Self.size)
        while(i < 2*Self.size) {
            Self.factTable[i] = Self.factTable[i-1] * i
            Self.integerInvTable[i] = ModInt(i).inverse
            Self.factInvTable[i] = Self.factInvTable[i-1] * Self.integerInvTable[i]
            i += 1
        }
        Self.size *= 2
    }
    static func fact(_ val: Int) -> ModInt {
        while val >= Self.size {
            extend()
        }
        return Self.factTable[val]
    }
    static func factInv(_ val: Int) -> ModInt {
        while val >= Self.size {
            extend()
        }
        return Self.factInvTable[val]
    }
    static func integerInv(_ val: Int) -> ModInt {
        while val >= Self.size {
            extend()
        }
        return Self.integerInvTable[val]
    }
}

///NTT
///FFTを適当にいじっただけ
struct NTT {
    //2^i乗根。
    var root: [ModInt] = Array(repeating: ModInt(3).toThePower(of: 119), count: 24)
    var rootInverse: [ModInt] = Array(repeating: ModInt(3).toThePower(of: 119), count: 24)
    init() {
        rootInverse[23] = 1/root[23]
        for i in (0...22).reversed() {
            root[i] = root[i+1] * root[i+1]
            rootInverse[i] = rootInverse[i+1] * rootInverse[i+1]
        }
    }
    private func bitReverse(_ x: Int, _ k: Int) -> Int{
        var res = 0
        for i in 0..<k{
            res |= (x >> i & 1) << (k - 1 - i)
        }
        return res
    }
    func numberTheoreticalTransform(_ function: inout [ModInt], _ inverse: Bool = false){
        let size = function.count
        var k = 0
        while((1 << k) < size){
            k += 1
        }
        for i in 0..<size{
            let j = bitReverse(i, k)
            if(i < j){
                function.swapAt(i, j)
            }
        }
        var operationSize = 1
        var cnt = 1
        while(operationSize < size){
            let zeta: ModInt = inverse ? root[cnt] : rootInverse[cnt]
            cnt += 1
            var omega: ModInt = 1
            for i in 0..<operationSize{
                var j = 0
                while(j < size){
                    let s = function[i + j], t = function[i + j + operationSize] * omega
                    function[i + j] = s + t
                    function[i + j + operationSize] = s - t
                    j += 2 * operationSize
                }
                omega *= zeta
            }
            operationSize *= 2
        }
        if(inverse){
            function = function.map {$0 / ModInt(size)}
        }
    }
}

func convolute(_ f: [ModInt], _ g: [ModInt]) -> [ModInt]{
    let ntt = NTT()
    var size = 1
    var f = f, g = g
    let tmpSize = f.count + g.count
    while(size < tmpSize){
        size *= 2
    }
    f += Array(repeating: ModInt(0), count: size - f.count)
    g += Array(repeating: ModInt(0), count: size - g.count)
    ntt.numberTheoreticalTransform(&f); ntt.numberTheoreticalTransform(&g); 
    for i in 0..<size{
        f[i] *= g[i]
    }
    ntt.numberTheoreticalTransform(&f, true)
    return f
}

func main(){
    var inputs = readInts()
    let (R, G, B, K) = (inputs[0], inputs[1], inputs[2], inputs[3])
    inputs = readInts()
    let (X, Y, Z) = (inputs[0], inputs[1], inputs[2])
    var a = [ModInt](repeating: 0, count: 220000)
    var b = [ModInt](repeating: 0, count: 220000)
    var c = [ModInt](repeating: 0, count: 220000)
    var ans: ModInt = 0
    if max(0, K-Y) <= R {
        for i in max(0, K-Y)...R {
            a[i] = ModInt(R).choose(i)
        }
    }
    if max(0, K-Z) <= G {
        for i in max(0, K-Z)...G {
            b[i] = ModInt(G).choose(i)
        }
    }
    if max(0, K-X) <= B {
        for i in max(0, K-X)...B {
            c[i] = ModInt(B).choose(i)
        }
    }
    let d = convolute(a, b)
    for i in 0...K {
        ans += d[i] * c[K-i]
    }
    print(ans)
}

main()