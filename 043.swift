import Foundation
func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}
@discardableResult
func chmin(_ x: inout Int, _ y: Int) -> Bool {
    if x > y {
        x = y
        return true
    } else {
        return false
    }
}

func main(){
    var inputs = readInts()
    let (H, W) = (inputs[0], inputs[1])
    inputs = readInts()
    let start = (inputs[0]-1, inputs[1]-1)
    inputs = readInts()
    let goal = (inputs[0]-1, inputs[1]-1)
    var maze = TwoDimensionalArray<String>("", (H, W))
    for i in 0..<H {
        let input = readLine()!
        for (j, c) in input.enumerated() {
            maze[i, j] = String(c)
        }
    }
    //0 ~ HW-1: 左向き
    //HW ~ 2HW-1: 下向き
    //2HW ~ 3HW-1: 右向き
    //3HW ~ 4HW-1: 上向き
    //それぞれについて頂点番号は(i, j) -> kHW + i*W + j

    var graph = TwoDimensionalArray<Int>(repeating: -1, count: (4*H*W+10, 4))

    for i in 0..<H {
        for j in 0..<W {
            if maze[i, j] == "#" {
                continue
            }
            //左向き
            if j > 0 && maze[i, j-1] != "#" {
                for k in 0..<4 {
                    graph[k*H*W + i*W + j, 0] = i*W + j-1
                }
            }
            //下向き
            if i < H-1 && maze[i+1, j] != "#" {
                for k in 0..<4 {
                    graph[k*H*W + i*W + j, 1] = H*W + (i+1)*W + j
                }
            }
            //右向き
            if j < W-1 && maze[i, j+1] != "#" {
                for k in 0..<4 {
                    graph[k*H*W + i*W + j, 2] = 2*H*W + i*W + j+1
                }
            }
            //上向き
            if i > 0 && maze[i-1, j] != "#" {
                for k in 0..<4 {
                    graph[k*H*W + i*W + j, 3] = 3*H*W + (i-1)*W + j
                }
            }
        }
    }
    //0-1BFS
    var q = Queue<Int>(10_000_000)
    var dist: [Int] = Array(repeating: 1<<60, count: 4*H*W+10)
    for k in 0..<4 {
        dist[k*H*W + start.0*W + start.1] = 0
        q.pushBack(k*H*W + start.0*W + start.1)
    }
    while q.isNotEmpty() {
        let currentPosition = q.popFront()
        for k in 0..<4 {
            let nextPosition: Int
            if graph[currentPosition, k] != -1 {
                nextPosition = graph[currentPosition, k]
            } else {
                continue
            }
            if nextPosition / (H*W) != currentPosition / (H*W) {
                if chmin(&dist[nextPosition],  dist[currentPosition] + 1) {
                    q.pushBack(nextPosition)
                }
            } else {
                if chmin(&dist[nextPosition],  dist[currentPosition]) {
                    q.pushFront(nextPosition)
                }
            }
        }
    }
    var ans = (1<<60)
    for k in 0..<4 {
        ans = min(ans, dist[k*H*W + goal.0*W + goal.1])
    }
    print(ans)
}

main()

struct Queue<Element>{
    private var maxSize: Int
    private var elements: Array<Element?>
    init(_ size: Int = 1_000_000){
        maxSize = size
        elements = Array(repeating: nil, count: size)
    }
    private var head = 0
    private var tail = 0

    func isEmpty() -> Bool{
        return head == tail
    }
    func isNotEmpty() -> Bool {
        return !isEmpty()
    }
    func size() -> Int{
        return tail > head ? tail - head : tail + maxSize - head
    }
    mutating func pushFront(_ element: Element){
        assert(elements[tail] == nil, "Queue is full, but pushFront() method was called.")
        elements[(head-1+maxSize)%maxSize] = element
        head = (head-1+maxSize) % maxSize
    }
    mutating func pushBack(_ element: Element){
        assert(elements[tail] == nil, "Queue is full, but pushBack() method was called.")
        elements[tail] = element
        tail = (tail + 1) % maxSize
    }
    @discardableResult
    mutating func popFront() -> Element{
        assert(head != tail, "Queue is empty, but popFront() method was called.")
        let ret = elements[head]!
        elements[head] = nil
        head = (head + 1)%maxSize
        return ret
    }
    @discardableResult
    mutating func popBack() -> Element{
        assert(head != tail, "Queue is empty, but popBack() method was called")
        let ret = elements[(tail-1+maxSize)%maxSize]!
        elements[(tail-1+maxSize)%maxSize] = nil
        tail = (tail-1+maxSize)%maxSize
        return ret
    }
    mutating func front() -> Element{
        assert(elements[head] != nil, "Queue is empty, but front() method was called")
        return elements[head]!
    }
    mutating func back()-> Element{
        assert(elements[head] != nil, "Queue is empty, but back() method was called")
        return elements[(tail+maxSize-1) % maxSize]!
    }
    subscript(index: Int) -> Element {
        get {
            return elements[(head + index)%maxSize]!
        }
        set {
            elements[(head + index)%maxSize]! = newValue
        }
    }
}

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