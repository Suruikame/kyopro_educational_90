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

//最大公約数、最小公倍数
func gcd(_ val1: Int, _ val2: Int) -> Int{
    var (x, y) = (val1, val2)
    if(x < y){
        swap(&x, &y)
    }
    if(x % y == 0){
        return y
    }
    return gcd(y, x%y)
}


func main(){
    let inputs = readInts()
    let (a, b, c) = (inputs[0], inputs[1], inputs[2])
    let g = gcd(gcd(a, b), c)
    print(a/g + b/g + c/g - 3)

}

main()