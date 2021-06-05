func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    let inputs = readInts()
    let (N, K) = (inputs[0], inputs[1])
    var ls = Array(repeating: [Int](0..<100_000), count: 71)
    //各桁の和を求める
    func digitsSum(_ n: Int) -> Int {
        var m = n
        var ret = 0
        while m > 0 {
            ret += m%10
            m /= 10
        }
        return ret
    }
    //1回遷移後の数字
    for i in 0..<100_000 {
        ls[0][i] = (i + digitsSum(i)) % 100_000
    }
    for i in 0..<70 {
        //2^i回遷移後の数字
        for j in 0..<100_000 {
            ls[i+1][j] = ls[i][ls[i][j]]
        }
    }
    var ans = N
    for i in 0..<63 {
        if ((K>>i) & 1) == 1 {
            ans = ls[i][ans]
        }
    }
    print(ans)
}

main()