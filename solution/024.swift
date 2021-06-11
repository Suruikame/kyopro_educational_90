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
    let inputs = readInts()
    let (_, K) = (inputs[0], inputs[1])
    let A = readInts()
    let B = readInts()
    var cnt = 0
    for (a, b) in zip(A, B){
        cnt += abs(b - a)
    }
    if(cnt > K || !(K-cnt).isMultiple(of: 2)){
        print("No")
    }else{
        print("Yes")
    }

}

main()