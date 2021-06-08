func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    let N = Int(readLine()!)!
    let As = readInts()
    var dp: [Int] = Array(repeating: 1<<60, count: N)
    var increasingOrderNote: [Int] = Array(repeating: -1, count: N)
    var decreasingOrderNote: [Int] = Array(repeating: -1, count: N)

    var num = 0
    for (idx, a) in As.enumerated() {
        let lb = dp.lowerBound(0, -1, a)
        if dp[lb] == 1<<60 {
            num += 1
        }
        dp[lb] = a
        increasingOrderNote[idx] = num
    }

    num = 0
    dp = Array(repeating: 1<<60, count: N)
    for (idx, a) in As.reversed().enumerated() {
        let lb = dp.lowerBound(0, -1, a)
        if dp[lb] == 1<<60 {
            num += 1
        }
        dp[lb] = a
        decreasingOrderNote[idx] = num
    }
    var ans = -1
    for i in 0..<N {
        ans = max(ans, decreasingOrderNote[i] + increasingOrderNote[N-i-1] - 1)
    }
    print(ans)
}

main()

extension Array where Element: Comparable{
    func lowerBound(_ left: Int = 0, _ right: Int = -1, _ value: Element) -> Int{
        var  lb = left, ub = (right == -1) ? self.count: right
        while(ub > lb){
            let mid = lb + (ub - lb)/2
            if(self[mid] < value){
                lb = mid + 1
            }else{
                ub = mid
            }
        }
        return lb
    }
}