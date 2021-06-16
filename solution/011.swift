func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    let N = Int(readLine()!)!
    var jobs = [(deadline: Int, duration: Int, reward: Int)]()
    for _ in 0..<N {
        let inputs = readInts()
        let (d, c, s) = (inputs[0], inputs[1], inputs[2])
        if c > d {
            continue
        }
        jobs.append((d, c, s))
    }
    jobs.sort(by: {$0.deadline < $1.deadline})
    var dp: [Int] = Array(repeating: 0, count: 5500)
    for job in jobs {
        for j in (0...job.deadline-job.duration).reversed() {
            dp[j + job.duration] = max(dp[j+job.duration], dp[j] + job.reward)

        }
    }
    print(dp.max()!)
}

main()
