func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    let inputs = readInts()
    let (a, b) = (inputs[0], inputs[1])
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
    let g = gcd(a, b)
    if a > 1_000_000_000_000_000_000 / (b/g) {
        print("Large")
    } else {
        print(a/g * b)
    }


}

main()