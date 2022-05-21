public typealias DVec4 = Vec4<Double>
public typealias FVec4 = Vec4<Float>
public typealias IVec4 = Vec4<Int>
public typealias UVec4 = Vec4<UInt>

extension Vec4 where T == Double {
    public static var xUnit = DVec4(1.0, 0.0, 0.0, 0.0)
    public static var yUnit = DVec4(0.0, 1.0, 0.0, 0.0)
    public static var zUnit = DVec4(0.0, 0.0, 1.0, 0.0)
    public static var wUnit = DVec4(0.0, 0.0, 0.0, 1.0)
}

extension Vec4 where T == Float {
    public static var xUnit = FVec4(1.0, 0.0, 0.0, 0.0)
    public static var yUnit = FVec4(0.0, 1.0, 0.0, 0.0)
    public static var zUnit = FVec4(0.0, 0.0, 1.0, 0.0)
    public static var wUnit = FVec4(0.0, 0.0, 0.0, 1.0)
}

extension Vec4 where T == Int {
    public static var xUnit = IVec4(1, 0, 0, 0)
    public static var yUnit = IVec4(0, 1, 0, 0)
    public static var zUnit = IVec4(0, 0, 1, 0)
    public static var wUnit = IVec4(0, 0, 0, 1)
}

extension Vec4 where T == UInt {
    public static var xUnit = UVec4(1, 0, 0, 0)
    public static var yUnit = UVec4(0, 1, 0, 0)
    public static var zUnit = UVec4(0, 0, 1, 0)
    public static var wUnit = UVec4(0, 0, 0, 1)
}

extension Vec4: Hashable, Equatable where T: Hashable {
    public static func == (lhs: Vec4, rhs: Vec4) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z && lhs.w == rhs.w
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(z)
        hasher.combine(w)
    }
}

extension Vec4 where T == Float {
    func toSIMD4() -> SIMD4<T> {
        return SIMD4<T>(x, y, z, w)
    }
}

extension Vec4 where T == Double {
    func toSIMD4() -> SIMD4<T> {
        return SIMD4<T>(x, y, z, w)
    }
}

extension Vec4 {
    public init(_ s: T) {
        self.init(x: s, y: s, z: s, w: s)
    }

    public init(_ v: Vec4<T>) {
        self.init(x: v.x, y: v.y, z: v.z, w: v.w)
    }

    public init(_ v: Vec3<T>, _ w: T) {
        self.init(x: v.x, y: v.y, z: v.z, w: w)
    }

    public init(_ x: T, _ y: T, _ z: T, _ w: T) {
        self.init(x: x, y: y, z: z, w: w)
    }
}

public struct Vec4<T: Numeric> {
    public let x: T
    public let y: T
    public let z: T
    public let w: T

    var xyz: Vec3<T> {
        return Vec3(x: x, y: y, z: z)
    }

    subscript() -> [T] {
        get {
            return [x, y, z, w]
        }
    }

    func dot(_ rhs: Vec4<T>) -> T {
        return self.x * rhs.x + self.y * rhs.y + self.z * rhs.z + self.w * rhs.w
    }

    // normalize not supported on integer types
    func normalize() -> Vec4<T> where T: BinaryFloatingPoint {
        return self / len()
    }

    func len() -> T where T: BinaryFloatingPoint {
        return (x * x + y * y + z * z + w * w).squareRoot()
    }

    // use float for length of integer types
    func len() -> Float where T: BinaryInteger {
        return
            (Float(x) * Float(x) + Float(y) * Float(y) + Float(z) * Float(z) + Float(w) * Float(w))
            .squareRoot()
    }

    static func + (lhs: Vec4<T>, rhs: Vec4<T>) -> Vec4<T> {
        return Vec4(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z, w: lhs.w + rhs.w)
    }

    static func - (lhs: Vec4<T>, rhs: Vec4<T>) -> Vec4<T> {
        return Vec4(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z, w: lhs.w - rhs.w)
    }

    static prefix func - (lhs: Vec4<T>) -> Vec4<T> where T: BinaryFloatingPoint {
        return Vec4(x: -lhs.x, y: -lhs.y, z: -lhs.z, w: -lhs.w)
    }

    // this is non-uniform scale, not dot product
    static func * (lhs: Vec4<T>, rhs: Vec4<T>) -> Vec4<T> {
        return Vec4(x: lhs.x * rhs.x, y: lhs.y * rhs.y, z: lhs.z * rhs.z, w: lhs.w * rhs.w)
    }

    static func * (lhs: Vec4<T>, s: T) -> Vec4<T> {
        return Vec4(x: lhs.x * s, y: lhs.y * s, z: lhs.z * s, w: lhs.w * s)
    }

    static func / (lhs: Vec4<T>, rhs: Vec4<T>) -> Vec4<T> where T: BinaryFloatingPoint {
        return Vec4(x: lhs.x / rhs.x, y: lhs.y / rhs.y, z: lhs.z / rhs.z, w: lhs.w / rhs.w)
    }

    static func / (lhs: Vec4<T>, rhs: Vec4<T>) -> Vec4<T> where T: BinaryInteger {
        return Vec4(x: lhs.x / rhs.x, y: lhs.y / rhs.y, z: lhs.z / rhs.z, w: lhs.w / rhs.w)
    }

    static func / (lhs: Vec4<T>, s: T) -> Vec4<T> where T: BinaryFloatingPoint {
        return Vec4(x: lhs.x / s, y: lhs.y / s, z: lhs.z / s, w: lhs.w / s)
    }

    static func / (lhs: Vec4<T>, s: T) -> Vec4<T> where T: BinaryInteger {
        return Vec4(x: lhs.x / s, y: lhs.y / s, z: lhs.z / s, w: lhs.w / s)
    }

    func almostEquals(_ rhs: Vec4<T>) -> Bool where T == Double {
        return self.x.almostEquals(rhs.x) && self.y.almostEquals(rhs.y)
            && self.z.almostEquals(rhs.z) && self.w.almostEquals(rhs.w)
    }

    func almostEquals(_ rhs: Vec4<T>) -> Bool where T == Float {
        return self.x.almostEquals(rhs.x) && self.y.almostEquals(rhs.y)
            && self.z.almostEquals(rhs.z) && self.w.almostEquals(rhs.w)
    }
}
