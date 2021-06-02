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

extension Array where Element: Comparable{
    //ソート済みの列に対して重複要素を削除した配列を返す
    //O(N)
    var unique: [Element]{
        var res: [Element] = []
        var prev: Element? = nil
        for element in self{
            if(element != prev){
                res.append(element)
                prev = element
            }
        }
        return res
    }
    //小さい順で何番目か
    //O(NlogN)
    var ranked: [Int]{
        var res: [Int] = []
        let sorted = self.sorted(by: {$0 < $1}).unique
        for element in self{
            res.append(sorted.lowerBound(0, -1, element))
        }
        return res
    }
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
func main(){
    let _ = Int(readLine()!)!
    let A = [-(1<<60)] + readInts().sorted() + [1<<60]
    let Q = Int(readLine()!)!
    for _ in 0..<Q{
        let B = Int(readLine()!)!
        let idx = A.lowerBound(0, -1, B)
        print(min(B-A[idx-1], A[idx]-B))
    }
}

main()