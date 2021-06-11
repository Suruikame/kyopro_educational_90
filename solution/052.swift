func readInts() -> [Int] {
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main() {
    let N = Int(readLine()!)!
    var ans = 1
    for _ in 0..<N {
        ans = ans * readInts().reduce(0, +) % Int(1e9+7)
    }
    print(ans)
}

main()