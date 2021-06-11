func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    let N = Int(readLine()!)!
    let inputs = readInts()
    let (A, B, C) = (inputs[0], inputs[1], inputs[2])
    var ans = N
    for i in 0..<N {
        if A * i > N || i > 9999 {
            break
        }
        for j in 0..<N {
            if A*i + B*j > N || (i + j) > 9999 {
                break
            }
            if (N - A*i - B*j) % C == 0 {
                let k = (N - A*i - B*j) / C
                ans = min(ans, i + j + k)
            }
        }
    }
    print(ans)
}

main()