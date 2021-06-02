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
    var pointsSums: [[Int]] = [[0], [0]]
    var prev = [0, 0]
    for _ in 0..<N{
        let inputs = readInts()
        let (C, P) = (inputs[0], inputs[1])
        if C == 1{
            pointsSums[0].append(prev[0] + P)
            pointsSums[1].append(prev[1])
            prev = [prev[0] + P, prev[1]]
        }else{
            pointsSums[0].append(prev[0])
            pointsSums[1].append(prev[1] + P)
            prev = [prev[0], prev[1] + P]
        }
    }
    let Q = Int(readLine()!)!
    for _ in 0..<Q{
        let inputs = readInts()
        let (L, R) = (inputs[0], inputs[1])
        let a = pointsSums[0][R] - pointsSums[0][L-1]
        let b = pointsSums[1][R] - pointsSums[1][L-1]
        print(a, b)
    }

}

main()