func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    let N = Int(readLine()!)!
    var graph: [[Int]] = Array(repeating: [], count: N)
    for _ in 0..<N-1 {
        let inputs = readInts()
        let (a, b) = (inputs[0]-1, inputs[1]-1)
        graph[a].append(b)
        graph[b].append(a)
    }
    var color: [Int] = Array(repeating: 0, count: N)
    func dfs(_ cur: Int, _ par: Int) {
        for child in graph[cur] {
            if child == par {
                continue
            } else {
                color[child] = color[cur]^1
                dfs(child, cur)
            }
        }
    }
    dfs(0, -1)
    let s = color.reduce(0, +)
    let choice = (s > N/2) ? 1 : 0
    var cnt = 0
    for i in 0..<N {
        if color[i] == choice {
            print(i+1, terminator: " ")
            cnt += 1
        }
        if cnt == N/2 {
            print()
            break
        }
    }
}

main()