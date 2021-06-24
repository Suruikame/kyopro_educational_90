readLine()
print(Array(readLine()!).map { (c: Character) -> Int in
    switch c {
    case "a": return 0
    case "b": return 1
    default: return 2
    }}.enumerated().map {$0.1*(1<<$0.0)}.reduce(0, +))