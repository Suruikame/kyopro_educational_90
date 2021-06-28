func readInts() -> [Int] {
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main() {
    let N = Int(readLine()!)!
    let tmpA = readInts()
    let A = tmpA + tmpA
    let s = A.reduce(0, +)/2
    var l = 0, r = 1
    var sum = A[0]
    while l < N {
        while r < (l+N) {
            if 10*sum == s {
                print("Yes")
                return
            } else if 10 * sum > s {
                break
            }
            sum += A[r]
            r += 1
        }
        sum -= A[l]
        l += 1
    }
    print("No")
}

main()