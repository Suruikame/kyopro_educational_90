func readInts() -> [Int] {
    return readLine()!.split(separator: " ").map {Int(String($0))!}
}

func main() {
    let inputs = readInts()
    let (N, L) = (inputs[0], inputs[1])
    var dp: [Int] = Array(repeating: 0, count: N+1)
    dp[0] = 1
    for i in 0..<N {
        if i + L <= N {
            dp[i+L] = (dp[i+L] + dp[i]) % Int(1e9+7)
        }
        dp[i+1] = (dp[i+1] + dp[i]) % Int(1e9+7)
    }
    print(dp[N])
}

main()