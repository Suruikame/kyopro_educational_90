func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    let N = Int(readLine()!)!
    //整数（2進数表示）を括弧列に変換
    func convertIntegerToSequence(_ n: Int) -> String {
        var res = ""
        for i in 0..<N {
            res += ((n & (1<<i) == 0) ? "(" : ")")
        }
        return String(res.reversed())
    }
    //判定関数
    //括弧列が正しい括弧列かを判定
    func ok(_ seq: Int) -> Bool{
        var tmp = 0
        for i in 0..<N {
            tmp += ((seq >> i) & 1 == 1 ? 1 : -1)
            if(tmp < 0){
                //正しい括弧列では、左から見た時に常に"("が")"よりも多い
                return false
            }
        }
        return tmp == 0
    }
    for i in 0..<(1<<N){
        if ok(i){
            print(convertIntegerToSequence(i))
        }
    }
}

main()