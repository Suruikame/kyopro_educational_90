func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    //入力
    let inputs = readInts()
    let (N, L) = (inputs[0]+1, inputs[1])
    let K = Int(readLine()!)!
    let A = readInts() + [L]
    //判定関数
    //それぞれのピースの長さをl以上にできるか。
    func ok(_ l: Int) -> Bool{
        var cnt = 0
        var i = 0
        var prev = 0
        while(i < N){
            //見ているピースの長さがl以上になるまで伸ばす
            while(i < N && A[i] - prev < l){
                i += 1
            }
            //長さがl以上になったら切る
            if(i < N){
                cnt += 1
                prev = A[i]
            }
        }
        return cnt > K
    }
    //二分探索
    var lb = 0, ub = Int(1e9)
    while(ub - lb > 1){
        let mid = (lb + ub)/2
        if ok(mid){
            lb = mid
        }else{
            ub = mid
        }
    }
    print(lb)
}

main()
