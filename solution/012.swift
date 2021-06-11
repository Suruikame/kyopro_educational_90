func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    let inputs = readInts()
    let (H, W) = (inputs[0], inputs[1])
    var grids = TwoDimensionalArray<Bool>(false, (H+2, W+2))
    let Q = Int(readLine()!)!
    var uf = UnionFind((H+1)*(W+1))
    for _ in 0..<Q {
        let q = readInts()
        if q[0] == 1 {
            let (r, c) = (q[1], q[2])
            grids[r, c] = true
            if grids[r-1, c] {
                uf.unite(W * (r-1) + c, W*r + c)
            }
            if grids[r+1, c] {
                uf.unite(W * (r+1) + c, W*r + c)
            }
            if grids[r, c-1] {
                uf.unite(W * r + c-1, W*r + c)
            }
            if grids[r, c+1] {
                uf.unite(W * r + c+1, W*r + c)
            }

        } else {
            let (ra, ca, rb, cb) = (q[1], q[2], q[3], q[4])
            if uf.same(ra*W + ca, rb*W + cb) && grids[ra, ca] {
                print("Yes")
            } else {
                print("No")
            }
        }

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
}

struct UnionFind{
    var parent: Array<Int> = []
    init(_ size: Int){
        parent = Array(repeating: -1, count: size)
    }
    func root(of this: Int) -> Int{
        if(parent[this] < 0){
            return this
        }else{
            return root(of: parent[this])
        }
    }
    func size(of this: Int) -> Int{
        return -parent[root(of: this)]
    }
    func same(_ x: Int, _ y: Int) -> Bool{
        return root(of: x) == root(of: y)
    }
    @discardableResult
    mutating func unite(_ x: Int, _ y: Int) -> Bool{
        if(same(x, y)){
            return false
        }
        let rootOfX = root(of: x), rootOfY = root(of: y)
        if(size(of: x) < size(of: y)){
            parent[rootOfY] += parent[rootOfX]
            parent[rootOfX] = rootOfY
        }else{
            parent[rootOfX] += parent[rootOfY]
            parent[rootOfY] = rootOfX
        }
        return true
    }
}