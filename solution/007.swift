func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

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
func main(){
    //入力
    let _ = Int(readLine()!)!
    //端に極端な値を持っておいてIndex out of rangeを防ぐ
    let A = [-(1<<60)] + readInts().sorted() + [1<<60]
    let Q = Int(readLine()!)!
    for _ in 0..<Q{
        let B = Int(readLine()!)!
        let idx = A.lowerBound(0, -1, B)
        print(min(B-A[idx-1], A[idx]-B))
    }
}

main()