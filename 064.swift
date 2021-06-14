func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    //入力
    let inputs = readInts()
    let (N, Q) = (inputs[0], inputs[1])
    let A = readInts()
    //各地点の差
    var div: [Int] = []
    for (idx, a) in A[1...].enumerated() {
        div.append(a - A[idx])
    }

    //不便さ
    var inconvinience: Int = div.reduce(0, {$0 + abs($1)})

    for _ in 0..<Q {
        let inputs = readInts()
        let (L, R, V) = (inputs[0]-1, inputs[1]-1, inputs[2])
        //変化のみ追う
        //新しい不便さ = 元の不便さ + 変化量
        if L > 0 {
            inconvinience += abs(div[L-1] + V) - abs(div[L-1])
            div[L-1] += V
        }
        if R < N-1 {
            inconvinience += abs(div[R] - V) - abs(div[R])
            div[R] -= V
        }
        print(inconvinience)
    }
}

main()