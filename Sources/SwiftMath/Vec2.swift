public typealias DVec2 = Vec2<Double>
public typealias FVec2 = Vec2<Float>
public typealias UVec2 = Vec2<UInt>
public typealias IVec2 = Vec2<Int>

extension Vec2 {
    public init(_ s: T) {
        self.init(x: s, y: s)
    }

    public init(_ v: Vec2<T>) {
        self.init(x: v.x, y: v.y)
    }

    public init(_ x: T, _ y: T) {
        self.init(x: x, y: y)
    }

    public init(_ a: [T]) {
        self.init(x: a[0], y: a[1])
    }
}

extension Vec2: Hashable, Equatable where T: Hashable {
    public static func == (lhs: Vec2, rhs: Vec2) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}


public struct Vec2<T: Numeric> {
    public let x: T
    public let y: T

    public subscript(index: Int) -> T {
        get {
            switch index {
            case 0: return x
            case 1: return y
            default: fatalError("Cannot access index \(index) of Vec2<\(T.self)>")
            }
        }
    }

    public func dot(_ rhs: Vec2<T>) -> T {
        return self.x * rhs.x + self.y * rhs.y
    }

    // normalize not supported on integer types
    public func normalize() -> Vec2<T> where T: BinaryFloatingPoint {
        return self / len()
    }

    public func len() -> T where T: BinaryFloatingPoint {
        return (x * x + y * y).squareRoot()
    }

    // use float for length of integer types
    public func len() -> Float where T: BinaryInteger {
        return (Float(x) * Float(x) + Float(y) * Float(y)).squareRoot()
    }

    public static func + (lhs: Vec2<T>, rhs: Vec2<T>) -> Vec2<T> {
        return Vec2(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    public static func - (lhs: Vec2<T>, rhs: Vec2<T>) -> Vec2<T> {
        return Vec2(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    static prefix func - (lhs: Vec2<T>) -> Vec2<T> where T: BinaryFloatingPoint {
        return Vec2(x: -lhs.x, y: -lhs.y)
    }

    // this is non-uniform scale, not dot product
    public static func * (lhs: Vec2<T>, rhs: Vec2<T>) -> Vec2<T> {
        return Vec2(x: lhs.x * rhs.x, y: lhs.y * rhs.y)
    }

    public static func * (lhs: Vec2<T>, s: T) -> Vec2<T> {
        return Vec2(x: lhs.x * s, y: lhs.y * s)
    }

    public static func / (lhs: Vec2<T>, rhs: Vec2<T>) -> Vec2<T> where T: BinaryFloatingPoint {
        return Vec2(x: lhs.x / rhs.x, y: lhs.y / rhs.y)
    }

    public static func / (lhs: Vec2<T>, rhs: Vec2<T>) -> Vec2<T> where T: BinaryInteger {
        return Vec2(x: lhs.x / rhs.x, y: lhs.y / rhs.y)
    }

    public static func / (lhs: Vec2<T>, s: T) -> Vec2<T> where T: BinaryFloatingPoint {
        return Vec2(x: lhs.x / s, y: lhs.y / s)
    }

    public static func / (lhs: Vec2<T>, s: T) -> Vec2<T> where T: BinaryInteger {
        return Vec2(x: lhs.x / s, y: lhs.y / s)
    }
}
