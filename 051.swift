/*
    🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢
*/
import Foundation
/*
    🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢
*/

func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func enumerate(_ array: [Int]) -> [[Int]] {
    let n = array.count
    var ret: [[Int]] = Array(repeating: [], count: n+1)
    for i in 0..<(1<<n) {
        var price = 0
        var cnt = 0
        for j in 0..<n {
            if (i >> j) & 1 == 1 {
                price += array[j]
                cnt += 1
            }
        }
        ret[cnt].append(price)
    }
    return ret.map {$0.sorted()}
}

func main(){
    let inputs = readInts()
    let (N, K, P) = (inputs[0], inputs[1], inputs[2])
    let As = readInts()
    let left = enumerate(Array(As[0..<N/2]))
    let right = enumerate(Array(As[N/2..<N]))
    var ans = 0
    for leftNum in 0..<left.count {
        for i in left[leftNum] {
            if K - leftNum < 0 || K - leftNum >= right.count {
                continue
            }
            let rightNum = right[K - leftNum].upperBound(0, -1, P-i)
            ans += rightNum
        }
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
    func upperBound(_ left: Int = 0, _ right: Int = -1, _ value: Element) -> Int{
        var  lb = left, ub = (right == -1) ? self.count: right
        while(ub > lb){
            let mid = lb + (ub - lb)/2
            if(self[mid] <= value){
                lb = mid + 1
            }else{
                ub = mid
            }
        }
        return lb
    }
}