func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    //入力
    let inputs = readInts()
    let (H, W) = (inputs[0], inputs[1])
    var P = TwoDimensionalArray<Int>(repeating: 0, count: (H, W))
    for i in 0..<H {
        for (j, value) in readInts().enumerated(){
            P[i, j] = value
        }
    }
    var ans = -1

    //bit全探索
    for i in 1..<(1<<H) {
        //ある数字からなる列がいくつあるか。
        var mp: [Int : Int] = [:]
        //立っているbitのリスト
        var checkIndices: [Int] = []
        for j in 0..<H {
            if (i >> j) & 1 == 1 {
                checkIndices.append(j)
            }
        }
        for j in 0..<W {
            //j列目に並ぶべき数字
            let num = P[checkIndices[0], j]
            //j列目に同じ数が並ぶかどうかのフラグ
            var same = true
            for index in checkIndices {
                if P[index, j] != num {
                    same = false
                    break
                }
            }
            if same {
                mp[num, default: 0] += 1
            }
        }
        for (_, cnt) in mp {
            ans = max(ans, i.nonzeroBitCount * cnt)
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