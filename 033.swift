func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    let inputs = readInts()
    let (H, W) = (inputs[0], inputs[1])
    var light: [[Bool]] = Array(repeating: Array(repeating: false, count: W+2), count: H+2)
    var ans = 0
    if H == 1 || W == 1 {
        print(max(H, W))
        return
    }
    for i in 1...H {
        for j in 1...W {
            //左と上だけ確かめればok
            if !(light[i][j-1] || light[i-1][j-1] || light[i-1][j]) {
                light[i][j] = true
                ans += 1
            }
        }
    }
    print(ans)
    for i in 1...H {
        for j in 1...W {
            if light[i][j] {
                print("#", terminator: "")
            } else {
                print(".", terminator: "")
            }
        }
        print()
    }
}

main()