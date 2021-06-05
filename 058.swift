func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    let inputs = readInts()
    var (N, K) = (inputs[0], inputs[1])
    var ls = [Int](0..<100_000)
    //各桁の和を求める
    func digitSum(_ n: Int) -> Int {
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
        ls[i] = (i + digitSum(i)) % 100_000
    }
    var ans = N
    while K > 0 {
        if K&1 == 1 {
            ans = ls[ans]
        }
        ls = ls.map {ls[$0]}
        K >>= 1
    }
    print(ans)
}

main()