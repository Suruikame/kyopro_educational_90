func main() {
    let N = Int(readLine()!)!
    //let s = Int(readLine()!)!
    //let k = Int(readLine()!)!
    //let S = readLine()!.split(separator: " ").map {Int(String($0))!}
    let s = 2 //文字の種類数
    let k = 2 //区間に含むべき文字の種類数
    let S = Array(readLine()!).map { $0 == "o" ? 0 : 1}
    var cnt: [Int] = Array(repeating: 0, count: s)
    var r = 0
    var ans = 0
    for l in 0..<N {
        while r < N && cnt.contains(0) {
            r += 1
            cnt[S[r-1]] += 1
        }
        if cnt.filter({$0 != 0}).count >= k {
            ans += N-r+1
        }
        cnt[S[l]] -= 1
    }
    print(ans)
}

main()