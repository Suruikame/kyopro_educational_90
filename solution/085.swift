func readInts() -> [Int] {
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}
func main() {
    let K = Int(readLine()!)!
    var ans = 0
    for a in 1...K {
        if a*a*a > K {
            break
        }
        for b in a...K {
            if a*b*b > K {
                break
            }
            let ab = a*b
            if K.isMultiple(of: ab) {
                let c = K/ab
                if c >= b {
                    ans += 1
                } else {
                    break
                }
            }
        }
    }
    print(ans)
}

main()