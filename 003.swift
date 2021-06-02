/*
    🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢
*/
import Foundation
/*
    🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢
*/

func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func maxAndItsIndex(_ arr: [Int]) -> (Int, Int){
    var m = -(1<<60)
    var i = -1
    for (idx, a) in arr.enumerated(){
        if m < a{
            m = a
            i = idx
        }
    }
    return (m, i)
}

func main(){
    let N = Int(readLine()!)!
    var graph: [[Int]] = Array(repeating: [], count: N)
    for _ in 0..<N-1{
        let inputs = readInts()
        let (a, b) = (inputs[0]-1, inputs[1]-1)
        graph[a].append(b)
        graph[b].append(a)
    }
    var dist: [Int] = Array(repeating: -1, count: N)
    func dfs(_ cur: Int, _ par: Int){
        for next in graph[cur]{
            if(next == par){
                continue
            }
            dist[next] = dist[cur] + 1
            dfs(next, cur)
        }
    }
    dist[0] = 0
    dfs(0, -1)
    let (_, i) = maxAndItsIndex(dist)
    dist = Array(repeating: -1, count: N)
    dist[i] = 0
    dfs(i, -1)
    print(maxAndItsIndex(dist).0 + 1)

}

main()