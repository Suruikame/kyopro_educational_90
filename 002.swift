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

func main(){
    let N = Int(readLine()!)!

    func convertIntegerToSequence(_ n: Int) -> String{
        var res = ""
        for i in 0..<N{
            res += ((n & (1<<i) == 0) ? "(" : ")")
        }
        return String(res.reversed())
    }
    func ok(_ seqIn: Int) -> Bool{
        var tmp = 0
        var seq = seqIn
        for _ in 0..<N{
            tmp += (seq&1 == 1 ? 1 : -1)
            if(tmp < 0){
                return false
            }
            seq >>= 1
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