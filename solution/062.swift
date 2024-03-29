func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}


func main(){
    let N = Int(readLine()!)!
    var graph: [[Int]] = Array(repeating: [], count: N)
    var q = Queue<Int>()
    for i in 0..<N {
        let inputs = readInts()
        let (a, b) = (inputs[0]-1, inputs[1]-1)
        graph[a].append(i)
        graph[b].append(i)
        if a == i || b == i {
            q.pushBack(i)
        }
    }
    var ans: [Int] = []
    var visited: [Bool] = Array(repeating: false, count: N)
    while q.isNotEmpty() {
        let v = q.popFront()
        if !visited[v] {
            visited[v] = true
            ans.append(v)
        }
        for nv in graph[v] {
            if !visited[nv] {
                q.pushBack(nv)
            }
        }
    }
    if ans.count < N {
        print(-1)
        return
    }
    for a in ans.reversed() {
        print(a+1)
    }

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