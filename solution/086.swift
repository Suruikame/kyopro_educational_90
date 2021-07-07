func readInts() -> [Int] {
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main() {
    let inputs = readInts()
    let (N, Q) = (inputs[0], inputs[1])
    var conditions: [[(Int, Int, Int, Int)]] = Array(repeating: [], count: 61)
    for _ in 0..<Q {
        let inputs = readInts()
        let (x, y, z, w) = (inputs[0]-1, inputs[1]-1, inputs[2]-1, inputs[3])
        for i in 0..<60 {
            conditions[i].append((x, y, z, (w>>i) & 1))
        }
    }
    var ans = 1
    let MOD = 1000000007
    for i in 0..<60 {
        var tmp = 0
        for j in 0..<(1<<N) {
            var f = true
            for (x, y, z, w) in conditions[i] {
                let s = ((j>>x)&1), t = ((j>>y)&1), u = ((j>>z)&1)
                if s|t|u != w {
                    f = false
                    break
                }
            }
            if f {
                tmp += 1
            }
        }
        ans = ans * tmp % MOD
    }
    print(ans)
}

main()