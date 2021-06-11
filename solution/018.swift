import Foundation

func readInts() -> [Int]{
    return readLine()!.split(separator: " ").map{Int(String($0))!}
}

func main(){
    let T = Double(readLine()!)!
    let inputs = readLine()!.split(separator: " ").map {Double(String($0))!}
    let (L, X, Y) = (inputs[0], inputs[1], inputs[2])
    let Q = Int(readLine()!)!
    for _ in 0..<Q {
        let E = Double(readLine()!)!
        let phase = -2*Double.pi*E/T - Double.pi/2.0
        let (x, y, z) = (0.0, L/2.0*cos(phase), L/2.0*(1.0 + sin(phase)))
        print(180.0/Double.pi*atan(z/sqrt((x-X)*(x-X) + (y-Y)*(y-Y))))

    }

}

main()