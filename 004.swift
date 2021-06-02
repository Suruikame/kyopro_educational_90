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

let processStartTime = Date()
func createArray() -> [Int]{
    var res: [Int] = []
    for _ in 0..<2000{
        res.append(Int.random(in: 1...99))
    }
    return res
}

func main(){
    let inputs = readInts()
    //let inputs = [2000, 2000]
    let (H, W) = (inputs[0], inputs[1])
    var A: [Int] = []
    var sumsH: [Int] = [], sumsW: [Int] = Array(repeating: 0, count: W)
    for _ in 0..<H{
        let newArray = readInts()
        //let newArray = createArray()
        A += newArray
        sumsH.append(newArray.reduce(0, +))
        for (idx, a) in newArray.enumerated(){
            sumsW[idx] += a
        }
    }
    //print(Date().timeIntervalSince(processStartTime))
    var ans = ""
    for i in 0..<H{
        for j in 0..<W{
            ans += String(sumsH[i] + sumsW[j] - A[W*i+j]) + " "
        }
        ans += "\n"
    }
    print(ans)
    //print(Date().timeIntervalSince(processStartTime))
}

main()