import Foundation
func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    let N = Int(readLine()!)!
    var points: [(Double, Double)] = []
    for _ in 0..<N {
        let inputs = readInts().map {Double($0)}
        points.append((inputs[0], inputs[1]))
    }
    var ans = -1.0
    for i in 0..<N {
        //真ん中の点を固定してP_i P_jの偏角を求める
        //atan(1/0)はちゃんとpi/2になる。
        //atan2(dy, dx)は-piからpiの範囲で返してくれる
        let (x, y) = points[i]
        var arguments: [Double] = []
        for j in 0..<N where j != i {
            let (xx, yy) = points[j]
            arguments.append(atan2((yy - y) , (xx - x)))
        }
        arguments.sort()
        for argument in arguments {
            var idx = arguments.lowerBound(0, -1, Double.pi + argument)
            if idx < arguments.count{
                ans = max(ans, min(abs(arguments[idx] - argument), 2.0*Double.pi - abs(arguments[idx] - argument)))
            }
            if idx > 0 {
                ans = max(ans, min(abs(arguments[idx-1] - argument), 2.0*Double.pi - abs(arguments[idx-1] - argument)))
            }
            idx = arguments.lowerBound(0, -1, -Double.pi + argument)
            if idx < arguments.count{
                ans = max(ans, min(abs(arguments[idx] - argument), 2.0*Double.pi - abs(arguments[idx] - argument)))
            }
            if idx > 0 {
                ans = max(ans, min(abs(arguments[idx-1] - argument), 2.0*Double.pi - abs(arguments[idx-1] - argument)))
            }
        }
    }
    print(ans * 180.0/Double.pi)
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

