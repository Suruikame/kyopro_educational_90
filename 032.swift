func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    let N = Int(readLine()!)!
    var A: [[Int]] = []
    for _ in 0..<N {
        A.append(readInts())
    }
    let M = Int(readLine()!)!

    var pairing: Set<Int> = []
    for _ in 0..<M {
        let inputs = readInts()
        let (x, y) = (inputs[0]-1, inputs[1]-1)
        //Hash化のため100x + yとしてsetに入れる
        pairing.insert(100*x + y)
    }
    var order = [Int](0..<N)
    var ans = 1<<60
    //順列全探索
    repeat {
        var time = 0
        var prev = -1
        for (section, player) in order.enumerated() {
            let x = min(player, prev)
            let y = max(player, prev)
            if pairing.contains(100*x + y) {
                //仲が悪い時
                time = 1<<60
                break
            }
            time += A[player][section]
            prev = player
        }
        ans = min(ans, time)
    }while(order.nextPermutation())
    print(ans != 1<<60 ? ans : -1)
}

main()

///nextPermutation
///全部試したい時はsortすること！！！
///repeat{
///      処理
///}while(array.nextPermutation())
///でok
extension Array where Element: Comparable{
    mutating func nextPermutation() -> Bool{
        let size = self.count
        var front = size-2, back = size-1
        //sizeが1の時の動作はパスかassertかどちらでも
        /*
        if(size < 2){
            return false
        }*/
        assert(size >= 2, "Array should contain two or more elements to compute next permutation.")
        //昇順になっている箇所を探す
        while(front >= 0){
            if(self[front] < self[front + 1]){
                break
            }
            front -= 1
        }
        if(front < 0){
            return false
        }
        //self[front]より大きい要素を探す
        let frontNum = self[front]
        while(back >= 0){
            if(frontNum < self[back]){
                break
            }
            back -= 1
        }
        //入れ替え
        swapAt(front, back)
        //front+1以降を反転
        var i = 1
        while(front + i < size - i){
            swapAt(front + i, size - i)
            i += 1
        }
        return true
    }
}