public typealias DVec2 = Vec2<Double>
public typealias FVec2 = Vec2<Float>
public typealias UVec2 = Vec2<UInt>
public typealias IVec2 = Vec2<Int>

public extension Vec2 {
    init(_ s: T) {
        self.init(x: s, y: s)
    }
    
    init(_ v: Vec2<T>) {
        self.init(x: v.x, y: v.y)
    }
}

public struct Vec2<T: Numeric> {
    let x: T
    let y: T
    
    func dot(_ rhs: Vec2<T>) -> T {
        return self.x * rhs.x + self.y * rhs.y
    }
    
    // normalize not supported on integer types
    func normalize() -> Vec2<T> where T: BinaryFloatingPoint {
        return self / len()
    }
    
    func len() -> T where T: BinaryFloatingPoint {
        return (x * x + y * y).squareRoot()
    }
    
    // use float for length of integer types
    func len() -> Float where T: BinaryInteger {
        return (Float(x) * Float(x) + Float(y) * Float(y)).squareRoot()
    }
    
    static func +(lhs: Vec2<T>, rhs: Vec2<T>) -> Vec2<T> {
        return Vec2(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    static func -(lhs: Vec2<T>, rhs: Vec2<T>) -> Vec2<T> {
        return Vec2(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    static prefix func -(lhs: Vec2<T>) -> Vec2<T> where T: BinaryFloatingPoint {
        return Vec2(x: -lhs.x, y: -lhs.y)
    }
    
    // this is non-uniform scale, not dot product
    static func *(lhs: Vec2<T>, rhs: Vec2<T>) -> Vec2<T> {
        return Vec2(x: lhs.x * rhs.x, y: lhs.y * rhs.y)
    }
    
    static func *(lhs: Vec2<T>, s: T) -> Vec2<T> {
        return Vec2(x: lhs.x * s, y: lhs.y * s)
    }
    
    static func /(lhs: Vec2<T>, rhs: Vec2<T>) -> Vec2<T> where T: BinaryFloatingPoint {
        return Vec2(x: lhs.x / rhs.x, y: lhs.y / rhs.y)
    }
    
    static func /(lhs: Vec2<T>, rhs: Vec2<T>) -> Vec2<T> where T: BinaryInteger {
        return Vec2(x: lhs.x / rhs.x, y: lhs.y / rhs.y)
    }
    
    static func /(lhs: Vec2<T>, s: T) -> Vec2<T> where T: BinaryFloatingPoint{
        return Vec2(x: lhs.x / s, y: lhs.y / s)
    }
    
    static func /(lhs: Vec2<T>, s: T) -> Vec2<T> where T: BinaryInteger {
        return Vec2(x: lhs.x / s, y: lhs.y / s)
    }
}
