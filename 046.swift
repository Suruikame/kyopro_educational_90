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
    let A = readInts().map {$0 % 46}
    let B = readInts().map {$0 % 46}
    let C = readInts().map {$0 % 46}
    var Acnt = Array(repeating: 0, count: 46)
    var Bcnt = Array(repeating: 0, count: 46)
    var Ccnt = Array(repeating: 0, count: 46)
    for i in 0..<N {
        Acnt[A[i]] += 1
        Bcnt[B[i]] += 1
        Ccnt[C[i]] += 1
    }
    var ans = 0
    for i in 0..<46 {
        for j in 0..<46 {
            for k in 0..<46 {
                if (i+j+k).isMultiple(of: 46) {
                    ans += Acnt[i] * Bcnt[j] * Ccnt[k]
                }
            }
        }
    }
    print(ans)
}

main()