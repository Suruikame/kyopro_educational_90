import Foundation
func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    let inputs = readInts()
    let (N, K) = (inputs[0], inputs[1])
    let S = Array(readLine()!).map {$0 - "a"}
    var c = TwoDimensionalArray<Int>(1_000_000, (N, 26))

    c[N-1, S[N-1]] = N-1
    for i in (0..<N-1).reversed() {
        for j in 0..<26 {
            c[i, j] = c[i+1, j]
        }
        c[i, S[i]] = i
    }
    //Stringは遅いので配列で持って出力時に直す。
    var ans: [Character] = []
    var i = 0
    while(ans.count < K) {
        for j in 0..<26 {
            if N - c[i, j] >= K - ans.count {
                //jを含めてあとN-c[i, j]文字まで追加できる。
                //追加可能文字数　+ 現在の文字数(ans.count) >= Kなら採用
                ans.append(Character(j + "a"))
                i = c[i, j] + 1
                break
            }
        }
    }
    for s in ans {
        print(s, terminator: "")
    }
    print("\n")
    
}

main()

///Character ⇄ Int
extension String{
    var code: Int{
        //文字コードで返す
        //Aが65, aが97, 0が48
        return Int(self.unicodeScalars.first!.value)
    }
}
extension Character{
    var code: Int{
        //文字コードで返す
        //Aが65, aが97, 0が48
        return Int(self.unicodeScalars.first!.value)
        
    }
    init(_ code: Int) {
        self.init(UnicodeScalar(code)!)
    }
    static func < (_ left: Character, _ right: Character) -> Bool{
        return left.code < right.code
    }
    static func <= (_ left: Character, _ right: Character) -> Bool{
        return left.code <= right.code
    }
    static func > (_ left: Character, _ right: Character) -> Bool{
        return left.code > right.code
    }
    static func >= (_ left: Character, _ right: Character) -> Bool{
        return left.code >= right.code
    }
    static func == (_ left: Character, _ right: Character) -> Bool{
        return left.code == right.code
    }
    static func + (lhs: Character, rhs: Int) -> Int {
        return lhs.code + rhs
    }
    static func - (lhs: Character, rhs: Int) -> Int {
        return lhs.code - rhs
    }
    static func + (lhs: Character, rhs: Character) -> Int {
        return lhs.code + rhs.code
    }
    static func - (lhs: Character, rhs: Character) -> Int {
        return lhs.code - rhs.code
    }
    static func + (lhs: Int, rhs: Character) -> Int {
        return lhs + rhs.code
    }
    static func - (lhs: Int, rhs: Character) -> Int {
        return lhs - rhs.code
    }
}

//二次元配列
//[[Element]]は遅いので。
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
extension TwoDimensionalArray: CustomStringConvertible where Element: CustomStringConvertible {
    var description: String {
        var ret = "["
        for i in 0..<count.0 {
            ret += "["
            for j in 0..<count.1 {
                ret += elements[i*self.count.1 + j].description
                ret += (j == count.1-1) ? "]\n" : ", "
            }
        }
        ret.removeLast()
        ret += "]"
        return ret
    }
}