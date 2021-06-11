func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    let inputs = readInts()
    let (N, K) = (inputs[0], inputs[1])
    let A = readInts()
    var mp: [Int : Int] =  [:]
    var cnt = 0
    var ans = 0
    var l = 0
    var r = 0
    while l < N && r < N{
        while(r < N && cnt <= K) {
            if let k = mp[A[r]] {
                mp[A[r]] = k + 1
            } else {
                mp[A[r]] = 1
                cnt += 1
                while cnt > K {
                    mp[A[l]]! -= 1
                    if mp[A[l]] == 0 {
                        cnt -= 1
                        mp[A[l]] = nil
                    }
                    l += 1
                }
            }
            ans = max(ans, r-l+1)
            r += 1
        }
    }
    print(ans)
}

main()