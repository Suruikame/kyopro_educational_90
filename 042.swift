func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    let K = Int(readLine()!)!
    if !K.isMultiple(of: 9) {
        print(0)
        return
    }
    var dp: [Int] = Array(repeating: 0, count: K+1)
    dp[0] = 1
    for i in 1...K {
        for j in max(0, i-9)..<i {
            dp[i] = (dp[i] + dp[j]) % (Int(1e9) + 7)
            //バグ避け
            print(terminator: "")
        }
    }
    print(dp[K])
}

main()