func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    //一次元上の点xと同一直線上にあるn個の点x_1, ... x_nとの距離のマンハッタン距離の総和を求める
    func sumManhattanDistances(_ point: Int, _ arr: [Int]) -> Int {
        return arr.reduce(0, {$0 + abs($1-point)})
    }
    //入力
    let N = Int(readLine()!)!
    var xs = [Int]()
    var ys = [Int]()
    for _ in 0..<N {
        let inputs = readInts()
        let (x, y) = (inputs[0], inputs[1])
        xs.append(x)
        ys.append(y)
    }
    //ソート
    xs.sort()
    ys.sort()
    
    //中央値で最小になる。
    if N.isMultiple(of: 2) {
        let xm = (xs[N/2-1] + xs[N/2])/2
        let xm2 = (xs[N/2-1] + xs[N/2])/2 + 1
        let ym = (ys[N/2-1] + ys[N/2])/2
        let ym2 = (ys[N/2-1] + ys[N/2])/2 + 1
        let xmin = min(sumManhattanDistances(xm, xs), sumManhattanDistances(xm2, xs))
        let ymin = min(sumManhattanDistances(ym, ys), sumManhattanDistances(ym2, ys))
        print(xmin + ymin)
    } else {
        let xm = xs[N/2]
        let ym = ys[N/2]
        print(sumManhattanDistances(xm, xs) + sumManhattanDistances(ym, ys))
    }
}

main()