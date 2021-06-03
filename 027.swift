func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    let N = Int(readLine()!)!
    var names = Set<String>()
    for i in 0..<N {
        let S = readLine()!
        if !names.contains(S) {
            print(i + 1)
            names.insert(S)
        }
    }
}

main()