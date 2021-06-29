func readInts() -> [Int] {
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main() {
    let inputs = readInts()
    let (N, M) = (inputs[0], inputs[1])
    var cnt: [Int] = Array(repeating: 0, count: N)
    for _ in 0..<M {
        let inputs = readInts().map {$0-1}
        let (a, b) = (inputs[0], inputs[1])
        if a > b {
            cnt[a] += 1
        } else {
            cnt[b] += 1
        }
    }
    print(cnt.filter({$0==1}).count)
}

main()