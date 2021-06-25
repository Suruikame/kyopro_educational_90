func main(){
    let N = Int(readLine()!)!
    var n = N
    var cnt = 0
    var i = 2
    while n != 1 { 
        while n % i == 0 {
            cnt += 1
            n /= i
        }
        if i*i > N {
            if n > 1 {
                cnt += 1
            }
            break
        }
        i += 1
    }
    print(cnt.bitWidth - cnt.leadingZeroBitCount + (cnt.nonzeroBitCount == 1 ? -1 : 0))
}

main()
