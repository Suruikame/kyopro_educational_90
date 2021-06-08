import Foundation
func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}
func main(){
    let N = Int(readLine()!)!
    var grid = TwoDimensionalArray<Int>(0, (1010, 1010))
    for _ in 0..<N {
        let inputs = readInts()
        let (lx, ly, rx, ry) = (inputs[0], inputs[1], inputs[2], inputs[3])
        for x in lx..<rx {
            grid[x, ly] += 1
            grid[x, ry] -= 1
        }
    }
    for y in 1..<1005 {
        for x in 0..<1005 {
            grid[x, y] += grid[x, y-1]
        }
    }
    var count: [Int] = Array(repeating: 0, count: 100_001)
    for i in 0..<1_010_025 {
        let x = i % 1005, y = i / 1005
        count[max(0, grid[x, y])] += 1
    }
    for i in 1...N {
        print(count[i])
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