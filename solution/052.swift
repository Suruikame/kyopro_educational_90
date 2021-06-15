func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    let MOD = Int(1e9) + 7
    var ans = 1
    for _ in 0..<Int(readLine()!)! {
        ans = ans * readInts().reduce(0, +) % MOD
    }
    print(ans)
}

main()