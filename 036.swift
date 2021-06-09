func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    let inputs = readInts()
    let (N, Q) = (inputs[0], inputs[1])
    var coords: [(Int, Int)] = []
    var pp: [Int] = [], pm: [Int] = [], mp: [Int] = [], mm: [Int] = []
    for _ in 0..<N {
        let inputs = readInts()
        let (x, y) = (inputs[0], inputs[1])
        coords.append((x, y))
        pp.append((x+y)); pm.append(x-y); mp.append(-x+y); mm.append(-x-y)
    }
    pp.sort(); pm.sort(); mp.sort(); mm.sort()
    for _ in 0..<Q {
        let q = Int(readLine()!)!
        let (x, y) = (coords[q-1])
        var ans = -1
        ans = max(ans, x + y - pp[0], x + y - pp[N-1])
        ans = max(ans, x - y - pm[0], x - y - pm[N-1])
        ans = max(ans, -x + y - mp[0], -x + y - mp[N-1])
        ans = max(ans, -x - y - mm[0], -x - y - mm[N-1])
        print(ans)
    }
}

main()