func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

//進数変換ライブラリより
///進数変換
///valueが10進法表記されていると見て変換する
///結果は小さい順なので注意 (11を2進数へ変換すると1101だが、[1,1,0,1]で返す。)
func baseConvert(_ value: Int, to: Int) -> [Int]{
    /* For safty
    guard abs(to) > 1 else {
        print("base must not be -1, 0, or 1")
        abort()
    }*/
    var x = value
    if(x == 0){
        return [0]
    }
    var res: [Int] = []
    let base = abs(to)
    while(x != 0){
        let tmp = ((x%base)+base)%base
        res.append(tmp)
        x = (x-tmp) / to
    }
    return res
}

func main() {
    let inputs = readLine()!.split(separator: " ")
    var (N, K) = (Array(inputs[0]).map {String($0)}, Int(inputs[1])!)
    for _ in 0..<K {
        //Nを10進数表示に変換
        var tmp = 0
        var base = 1
        for num in N.reversed() {
            tmp += Int(num)! * base
            base *= 8
        }
        //9進数に変換して、8を5に書き換え、結合、Intへ
        N = baseConvert(tmp, to: 9).reversed().map {$0 == 8 ? "5" : String($0)}
    }
    print(N.joined(separator: ""))
}

main()