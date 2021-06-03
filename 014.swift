func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    let _ = Int(readLine()!)!
    let As = readInts().sorted()
    let Bs = readInts().sorted()
    var ans = 0
    for (a, b) in zip(As, Bs) {
        ans += abs(b-a)
    }
    print(ans)
}

main()