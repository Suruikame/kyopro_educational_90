func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    var inputs = readInts()
    let (N, M) = (inputs[0], inputs[1])
    var sw = TwoDimensionalArray<Int>(0, (N, M))
    for i in 0..<N {
        let _ = Int(readLine()!)!
        inputs = readInts().map {$0 - 1}
        for a in inputs {
            sw[i, a] = 1
        }
    }
    var S = readInts()
    var cur = 0
    //掃き出し法
    for i in 0..<M {
        //i列目が1になるものを探す
        if cur >= N {
            break
        }
        for j in cur..<N {
            if sw[j, i] == 1 {
                for k in 0..<M {
                    let tmp = sw[j, k]
                    sw[j, k] = sw[cur, k]
                    sw[cur, k] = tmp
                }
                for k in 0..<N {
                    if k == cur {
                        continue
                    }
                    if sw[k, i] == 1 {
                        for l in 0..<M {
                            sw[k, l] ^= sw[cur, l]
                        }
                    }
                }
                cur += 1 
                break
            }
        }
    }
    for i in 0..<N {
        for (a, b) in zip(sw[i], S) {
            if a == 1 && b == 0 {
                //押さない
                break
            }
            if a == 0 && b == 1 {
                //達成不可能
                break
            }
            if a == 1 && b == 1 {
                //押す
                for j in 0..<M {
                    S[j] ^= sw[i, j]
                }
                break
            }
        }
    }
    if S.allSatisfy({$0 == 0}) {
        var ans = 1
        for i in 0..<N {
            if sw[i].allSatisfy({$0 == 0}) {
                ans = ans * 2 % 998244353
            }
        }
        print(ans)
    } else {
        print(0)
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
    subscript(i: Int) -> [Element] {
        get {
            return Array(elements[self.count.1 * i..<self.count.1*(i+1)])
        }
    }
}