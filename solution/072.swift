import Foundation
func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    let inputs = readInts()
    let (H, W) = (inputs[0], inputs[1])
    var map = TwoDimensionalArray<Bool>(false, (H, W))
    for i in 0..<H {
        for (j, c) in Array(readLine()!).enumerated() {
            map[i, j] = (String(c) == ".")
        }
    }
    var visited: TwoDimensionalArray<Bool>
    var ans = -1
    let dys = [-1, 0, 1, 0], dxs = [0, 1, 0, -1]
    var start: (Int, Int)
    func dfs(_ y: Int, _ x: Int, _ len: Int) {
        visited[y, x] = true
        for i in 0..<4 {
            let (ny, nx) = (y+dys[i], x+dxs[i])
            if ny >= H || nx >= W || ny < 0 || nx < 0 {
                continue
            }
            if (ny, nx) == start {
                if len > 1 {
                    ans = max(ans, len+1)
                }
                continue
            }
            if !visited[ny, nx] && map[ny, nx] {
                dfs(ny, nx, len+1)
            }
        }
    }
    for i in 0..<H {
        for j in 0..<W {
            if map[i, j] {
                start = (i, j)
                visited = TwoDimensionalArray<Bool>(false, (H, W))
                dfs(i, j, 0)
            }
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