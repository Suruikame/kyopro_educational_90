func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    var inputs = readInts()
    let (N, M) = (inputs[0], inputs[1])
    var graph: [[(to: Int, cost: Int)]] = Array(repeating: [], count: N)
    //グラフの入力
    for _ in 0..<M {
        inputs = readInts()
        let (a, b, c) = (inputs[0]-1, inputs[1]-1, inputs[2])
        graph[a].append((b, c))
        graph[b].append((a, c))
    }
    //dijkstra
    var pq = PriorityQueue<(to: Int, cost: Int)>( { $0.cost < $1.cost })
    var distFrom1: [Int] = Array(repeating: (1<<60), count: N) 
    distFrom1[0] = 0
    pq.push((0, 0))
    while(pq.isNotEmpty()) {
        let (v, c) = pq.pop()
        if c != distFrom1[v] {
            continue
        }
        for (nv, d) in graph[v] {
            if c + d < distFrom1[nv] {
                pq.push((nv, c+d))
                distFrom1[nv] = c+d
            }
        }
    }
    var distFromN: [Int] = Array(repeating: (1<<60), count: N) 
    distFromN[N-1] = 0
    pq.push((N-1, 0))
    while(pq.isNotEmpty()) {
        let (v, c) = pq.pop()
        if c != distFromN[v] {
            continue
        }
        for (nv, d) in graph[v] {
            if c + d < distFromN[nv] {
                pq.push((nv, c+d))
                distFromN[nv] = c+d
            }
        }
    }

    for k in 0..<N {
        print(distFrom1[k] + distFromN[k])
    }
}

main()

//Min Heapなら{$0 < $1}
struct PriorityQueue<Element>{
    var elements: [Element] = []
    private var sz = 0//挿入位置
    var compareFunction: (Element, Element) -> Bool
    init(_ compareFunction: @escaping (Element, Element) -> Bool){
        self.compareFunction = compareFunction
    }
    func isEmpty() -> Bool{
        return sz == 0
    }
    func isNotEmpty() -> Bool{
        return sz != 0
    }
    func top() -> Element{
        return elements[0]
    }
    mutating func push(_ value: Element){
        var pos = sz//挿入暫定位置
        sz += 1
        if(sz >= elements.count){
            elements.append(value)
        }else{
            elements[pos] = value
        }
        while(pos != 0 && !compareFunction(elements[(pos-1)/2], value)){
            elements[pos] = elements[(pos-1)/2]
            pos = (pos-1)/2
        }
        elements[pos] = value
    }
    @discardableResult
    mutating func pop() -> Element{
        sz -= 1
        let res = elements[0]//根を取り出す
        var pos = 0//暫定位置
        let value = elements[sz]
        while(pos*2+1<sz){
            //根を下に下げていく
            var left = pos*2 + 1, right = pos*2+2
            if(right < sz && compareFunction(elements[right], elements[left])){
                left = right//右側が小さい時は右側と交換する
            }
            if(compareFunction(value, elements[left])){
                break//逆転していないなら抜ける
            }
            elements[pos] = elements[left]
            pos = left
        }
        elements[pos] = value
        return res
    }
}