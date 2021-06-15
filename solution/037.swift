func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    let inputs = readInts()
    let (W, N) = (inputs[0], inputs[1])
    var dp = SegmentTree(60_000, max)
    dp.update(at: 0, to: 0)
    //O(NWlogW)
    for _ in 0..<N {
        let inputs = readInts()
        let (L, R, V) = (inputs[0], inputs[1], inputs[2])
        for j in (L...W).reversed() {
            let m = dp.rangeQuery(max(0, j-R), j-L+1)
            if m == -1 {
                continue
            }
            dp.update(at: j, to: max(m + V, dp.at(j)))
        }
    }
    print(dp.at(W))
}

main()

///昔作ったやつを無理矢理適合させただけなので使わないこと。
///初期化時にsizeとcompare functionをわたす
struct SegmentTree{
    var size: Int = 1
    var elements: [Int]
    var compare: (_ x: Int, _ y: Int) -> Int
    init(_ size: Int, _ compare: @escaping (_ x: Int, _ y: Int) -> Int){
        while(self.size <= size){
            self.size *= 2
        }
        self.size *= 2
        self.elements = Array(repeating: -1, count: self.size)
        self.compare = compare
    }
    func at(_ index: Int) -> Int {
        return self.elements[size/2 + index-1]
    }
    ///atは0-indexed
    @discardableResult
    mutating func update(at: Int, to: Int) -> Bool{
        if(at > size){
            return false
        }
        elements[at + size/2 - 1] = to
        var i = at + size/2 - 1
        while(i > 0){
            i = (i - 1) / 2
            elements[i] = compare(elements[2*i+1], elements[2*i+2])
        }
        return true
    }
    ///[left, right)の区間での欲しい値を得る
    func rangeQuery(_ left: Int, _ right: Int,_ now: Int = 0, _ from: Int = 0, _ to: Int? = nil) -> Int{
        let end: Int, start = from
        if(to != nil){
            end = to!
        }else{
            end = self.size/2
        }
        if left >= right || from >= end {
            return -1
        }
        if right <= start || left >= end {
            return -1
        } else if left <= start && end <= right {
            return elements[now]
        } else {
            let value1 = rangeQuery(left, right, 2*now+1, start, (start + end)/2)
            let value2 = rangeQuery(left, right, 2*now+2, (start+end)/2, end)
            return compare(value1, value2)
        }
    }
}