public typealias DVec3 = Vec3<Double>
public typealias FVec3 = Vec3<Float>
public typealias IVec3 = Vec3<Int>
public typealias UVec3 = Vec3<UInt>

extension Vec3 {
    public init(_ s: T) {
        self.init(x: s, y: s, z: s)
    }

    public init(_ v: Vec2<T>, z: T) {
        self.init(x: v.x, y: v.y, z: z)
    }

    public init(_ v: Vec3<T>) {
        self.init(x: v.x, y: v.y, z: v.z)
    }

    public init(_ x: T, _ y: T, _ z: T) {
        self.init(x: x, y: y, z: z)
    }
}

extension Vec3: Hashable, Equatable where T: Hashable {
    public static func == (lhs: Vec3, rhs: Vec3) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(z)
    }
}

extension Vec3 {
    public func toSIMD() -> SIMD3<T> where T: FloatingPoint {
        return SIMD3<T>(x, y, z)
    }
}

extension Vec3 where T == Double {
    public static var xUnit = Self(1, 0, 0)
    public static var yUnit = Self(0, 1, 0)
    public static var zUnit = Self(0, 0, 1)
}

extension Vec3 where T == Float {
    public static var xUnit = Self(1, 0, 0)
    public static var yUnit = Self(0, 1, 0)
    public static var zUnit = Self(0, 0, 1)
}

extension Vec3 where T == Int {
    public static var xUnit = Self(1, 0, 0)
    public static var yUnit = Self(0, 1, 0)
    public static var zUnit = Self(0, 0, 1)
}

extension Vec3 where T == UInt {
    public static var xUnit = Self(1, 0, 0)
    public static var yUnit = Self(0, 1, 0)
    public static var zUnit = Self(0, 0, 1)
}

public struct Vec3<T: Numeric> {
    public let x: T
    public let y: T
    public let z: T

    public subscript(index: Int) -> T {
        get {
            switch index {
            case 0: return x
            case 1: return y
            case 2: return z
            default: fatalError("Cannot access index \(index) of Vec3<\(T.self)>")
            }
        }
    }

    public subscript() -> [T] {
        get {
            return [x, y, z]
        }
    }

    // var xy: Vec2<T> {
    //     return Vec2(x: x, y: y)
    // }

    public func dot(_ rhs: Vec3<T>) -> T {
        return self.x * rhs.x + self.y * rhs.y + self.z * rhs.z
    }

    public func cross(_ rhs: Vec3<T>) -> Vec3<T> {
        return Vec3(
            x: self.y * rhs.z - rhs.y * self.z,
            y: self.z * rhs.x - rhs.z * self.x,
            z: self.x * rhs.y - rhs.x * self.y)
    }

    // normalize not supported on integer types
    public func normalize() -> Vec3<T> where T: BinaryFloatingPoint {
        return self / len()
    }

    public func len() -> T where T: BinaryFloatingPoint {
        return (x * x + y * y + z * z).squareRoot()
    }

    // use float for length of integer types
    public func len() -> Float where T: BinaryInteger {
        return (Float(x) * Float(x) + Float(y) * Float(y) + Float(z) * Float(z)).squareRoot()
    }

    public func toPos() -> Vec4<T> {
        return Vec4<T>(self, 1)
    }

    public func toDir() -> Vec4<T> {
        return Vec4<T>(self, 0)
    }

    public func almostEquals(_ rhs: Vec3<T>) -> Bool where T == Double {
        return self.x.almostEquals(rhs.x) && self.y.almostEquals(rhs.y)
            && self.z.almostEquals(rhs.z)
    }

    public func almostEquals(_ rhs: Vec3<T>) -> Bool where T == Float {
        return self.x.almostEquals(rhs.x) && self.y.almostEquals(rhs.y)
            && self.z.almostEquals(rhs.z)
    }

    //    static func ==(lhs: Vec3<T>, rhs: Vec3<T>) -> Bool {
    //        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    //    }
    //
    public static func + (lhs: Vec3<T>, rhs: Vec3<T>) -> Vec3<T> {
        return Vec3(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }

    public static func - (lhs: Vec3<T>, rhs: Vec3<T>) -> Vec3<T> {
        return Vec3(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
    }

    public static prefix func - (lhs: Vec3<T>) -> Vec3<T> where T: BinaryFloatingPoint {
        return Vec3(x: -lhs.x, y: -lhs.y, z: -lhs.z)
    }

    // this is non-uniform scale, not dot product
    public static func * (lhs: Vec3<T>, rhs: Vec3<T>) -> Vec3<T> {
        return Vec3(x: lhs.x * rhs.x, y: lhs.y * rhs.y, z: lhs.z * rhs.z)
    }

    public static func * (lhs: Vec3<T>, s: T) -> Vec3<T> {
        return Vec3(x: lhs.x * s, y: lhs.y * s, z: lhs.z * s)
    }

    public static func / (lhs: Vec3<T>, rhs: Vec3<T>) -> Vec3<T> where T: BinaryFloatingPoint {
        return Vec3(x: lhs.x / rhs.x, y: lhs.y / rhs.y, z: lhs.z / rhs.z)
    }

    public static func / (lhs: Vec3<T>, rhs: Vec3<T>) -> Vec3<T> where T: BinaryInteger {
        return Vec3(x: lhs.x / rhs.x, y: lhs.y / rhs.y, z: lhs.z / rhs.z)
    }

    public static func / (lhs: Vec3<T>, s: T) -> Vec3<T> where T: BinaryFloatingPoint {
        return Vec3(x: lhs.x / s, y: lhs.y / s, z: lhs.z / s)
    }

    public static func / (lhs: Vec3<T>, s: T) -> Vec3<T> where T: BinaryInteger {
        return Vec3(x: lhs.x / s, y: lhs.y / s, z: lhs.z / s)
    }
}
