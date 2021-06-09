func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    let inputs = readInts()
    let (N, M) = (inputs[0], inputs[1])
    var graph: [[Int]] = Array(repeating: [], count: N)
    var reversedGraph: [[Int]] = Array(repeating: [], count: N)
    for _ in 0..<M {
        let inputs = readInts()
        let (a, b) = (inputs[0]-1, inputs[1]-1)
        graph[a].append(b)
        reversedGraph[b].append(a)
    }
    var vs: [Int] = [] //帰りがけ順の記録用
    var used: [Bool] = Array(repeating: false, count: N)
    func dfs(_ v: Int) {
        used[v] = true
        for nv in graph[v] {
            if !used[nv] {
                dfs(nv)
            }
        }
        vs.append(v)
    }
    var order: [Int] = Array(repeating: -1, count: N)
    var ans = 0
    var cnt = 0//同じ番号に属するものの数
    func reversedDfs(_ v: Int, _ k: Int) {
        order[v] = k
        cnt += 1
        for nv in reversedGraph[v] {
            if order[nv] < 0 {
                reversedDfs(nv, k)
            }
        }
    }
    for v in 0..<N {
        if !used[v] {
            dfs(v)
        }
    }
    var k = 0
    for v in vs.reversed() {
        if order[v] < 0 {
            reversedDfs(v, k)
            k += 1
            ans += cnt * (cnt-1) / 2
            cnt = 0
        }
    }
    print(ans)
}

main()