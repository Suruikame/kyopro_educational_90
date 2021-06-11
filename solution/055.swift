func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    let inputs = readInts()
    let (n, p, q) = (inputs[0], inputs[1], inputs[2])
    let A = readInts()
    var ans = 0
    for i in 0..<n-4 {
        for j in (i+1)..<n-3 {
            for k in j+1..<n-2 {
                for l in k+1..<n-1 {
                    for m in l+1..<n {
                        var tmp = A[i]
                        tmp = tmp * A[j] % p
                        tmp = tmp * A[k] % p
                        tmp = tmp * A[l] % p
                        tmp = tmp * A[m] % p
                        if tmp == q {
                            ans += 1
                        }
                    }
                }
            }
        }
    }
    print(ans)
}

main()