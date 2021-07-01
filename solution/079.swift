func readInts() -> [Int] {
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main() {
    let inputs = readInts()
    let (H, W) = (inputs[0], inputs[1])
    var A: [[Int]] = []
    var B: [[Int]] = []
    for _ in 0..<H {
        A.append(readInts())
    }
    for _ in 0..<H {
        B.append(readInts())
    }
    var ans = 0
    for i in 0..<H-1 {
        for j in 0..<W-1 {
            let diff = B[i][j] - A[i][j]
            A[i][j] += diff
            A[i+1][j] += diff
            A[i][j+1] += diff
            A[i+1][j+1] += diff
            ans += abs(diff)
        }
        if A[i][W-1] != B[i][W-1] {
            ans = -1
            break
        }
    }
    
    print(ans >= 0 ? "Yes\n\(ans)" : "No")
}

main()