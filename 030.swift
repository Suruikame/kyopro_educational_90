func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    let inputs = readInts()
    let (N, K) = (inputs[0], inputs[1])
    var count: [Int] = Array(repeating: 0, count: N+1)
    var isPrime: [Bool] = Array(repeating: true, count: N+1)
    for i in 2..<N {
        if isPrime[i] {
            var j = 2
            count[i] = 1
            while i*j <= N {
                count[i*j] += 1
                isPrime[i*j] = false
                j += 1
            }
        }
    }
    var ans = 0
    for i in 1...N {
        if count[i] >= K {
            ans += 1
        }
    }
    print(ans)
}

main()