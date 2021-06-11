func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

//log2 (c^b/a) > 0
//c^b > a
func main(){
    let inputs = readInts()
    var (a, b, c) = (inputs[0], inputs[1], inputs[2])
    c = c.toThePower(of: b)
    if c > a {
        print("Yes")
    } else {
        print("No")
    }
}

main()

extension Int{
    func toThePower(of: Int) -> Int{
        var x = self, res = 1, p = of
        while(p > 0){
            if(p & 1 == 1){
                res *= x
            }
            p >>= 1
            if(p <= 0){
                //下のx*xでstack dumpするのを防ぐ
                break
            }
            x = x * x
        }
        return res
    }
}