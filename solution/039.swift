func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    let N = Int(readLine()!)!
    var graph: [[Int]] = Array(repeating: [], count: N)
    for _ in 1..<N {
        let inputs = readInts()
        let (a, b) = (inputs[0]-1, inputs[1]-1)
        graph[a].append(b)
        graph[b].append(a)
    }
    var dp: [Int] = Array(repeating: -1, count: N)
    @discardableResult
    func dfs(_ cur: Int, _ par: Int) -> Int {
        dp[cur] = 1
        for next in graph[cur] {
            if next == par {
                continue
            }
            dp[cur] += dfs(next, cur)
        }
        return dp[cur]
    }
    dfs(0, -1)
    print(dp.reduce(0, {$0 + $1 * (N-$1)}))
    
}

main()
