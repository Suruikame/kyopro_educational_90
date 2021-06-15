func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    let N = Int(readLine()!)!
    var ls: [[Int]] = Array(repeating: [], count: 111)
    var ans  = 0.0
    for _ in 0..<N {
        let inputs = readInts()
        let (L, R) = (inputs[0], inputs[1])
        let len = (R-L+1)
        for i in L...R {
                for j in (i+1)...110 {
                    for k in ls[j] {
                        ans += 1.0/(Double(len) * Double(k))
                    }
                }
            ls[i].append(len)
        }
    }
    print(ans)
}

main()
