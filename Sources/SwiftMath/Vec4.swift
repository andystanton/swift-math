public typealias DVec4 = Vec4<Double>
public typealias FVec4 = Vec4<Float>
public typealias IVec4 = Vec4<Int>
public typealias UVec4 = Vec4<UInt>

public extension Vec4 where T == Double {
    static var xUnit = DVec4(1.0, 0.0, 0.0, 0.0)
    static var yUnit = DVec4(0.0, 1.0, 0.0, 0.0)
    static var zUnit = DVec4(0.0, 0.0, 1.0, 0.0)
    static var wUnit = DVec4(0.0, 0.0, 0.0, 1.0)
}

public extension Vec4 where T == Float {
    static var xUnit = FVec4(1.0, 0.0, 0.0, 0.0)
    static var yUnit = FVec4(0.0, 1.0, 0.0, 0.0)
    static var zUnit = FVec4(0.0, 0.0, 1.0, 0.0)
    static var wUnit = FVec4(0.0, 0.0, 0.0, 1.0)
}

public extension Vec4 where T == Int {
    static var xUnit = IVec4(1, 0, 0, 0)
    static var yUnit = IVec4(0, 1, 0, 0)
    static var zUnit = IVec4(0, 0, 1, 0)
    static var wUnit = IVec4(0, 0, 0, 1)
}

public extension Vec4 where T == UInt {
    static var xUnit = UVec4(1, 0, 0, 0)
    static var yUnit = UVec4(0, 1, 0, 0)
    static var zUnit = UVec4(0, 0, 1, 0)
    static var wUnit = UVec4(0, 0, 0, 1)
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

public extension Vec4 {
    init(_ s: T) {
        self.init(x: s, y: s, z: s, w: s)
    }
    
    init(_ v: Vec4<T>) {
        self.init(x: v.x, y: v.y, z: v.z, w: v.w)
    }
    
    init(_ v: Vec3<T>, _ w: T) {
        self.init(x: v.x, y: v.y, z: v.z, w: w)
    }
    
    init(_ x: T, _ y: T, _ z: T, _ w: T) {
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
        return (Float(x) * Float(x) + Float(y) * Float(y) + Float(z) * Float(z) + Float(w) * Float(w)).squareRoot()
    }
    
    static func ==(lhs: Vec4<T>, rhs: Vec4<T>) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z && lhs.w == rhs.w
    }
    
    static func ~=(lhs: Vec4<T>, rhs: Vec4<T>) -> Bool where T == Double {
        return lhs.x.almostEquals(rhs.x) && lhs.y.almostEquals(rhs.y) && lhs.z.almostEquals(rhs.z) && lhs.w.almostEquals(rhs.w)
    }
    
    static func ~=(lhs: Vec4<T>, rhs: Vec4<T>) -> Bool where T == Float {
        return lhs.x.almostEquals(rhs.x) && lhs.y.almostEquals(rhs.y) && lhs.z.almostEquals(rhs.z) && lhs.w.almostEquals(rhs.w)
    }
    
    static func +(lhs: Vec4<T>, rhs: Vec4<T>) -> Vec4<T> {
        return Vec4(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z, w: lhs.w + rhs.w)
    }
    
    static func -(lhs: Vec4<T>, rhs: Vec4<T>) -> Vec4<T> {
        return Vec4(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z, w: lhs.w - rhs.w)
    }
    
    static prefix func -(lhs: Vec4<T>) -> Vec4<T> where T: BinaryFloatingPoint {
        return Vec4(x: -lhs.x, y: -lhs.y, z: -lhs.z, w: -lhs.w)
    }
    
    // this is non-uniform scale, not dot product
    static func *(lhs: Vec4<T>, rhs: Vec4<T>) -> Vec4<T> {
        return Vec4(x: lhs.x * rhs.x, y: lhs.y * rhs.y, z: lhs.z * rhs.z, w: lhs.w * rhs.w)
    }
    
    static func *(lhs: Vec4<T>, s: T) -> Vec4<T> {
        return Vec4(x: lhs.x * s, y: lhs.y * s, z: lhs.z * s, w: lhs.w * s)
    }
    
    static func /(lhs: Vec4<T>, rhs: Vec4<T>) -> Vec4<T> where T: BinaryFloatingPoint {
        return Vec4(x: lhs.x / rhs.x, y: lhs.y / rhs.y, z: lhs.z / rhs.z, w: lhs.w / rhs.w)
    }
    
    static func /(lhs: Vec4<T>, rhs: Vec4<T>) -> Vec4<T> where T: BinaryInteger {
        return Vec4(x: lhs.x / rhs.x, y: lhs.y / rhs.y, z: lhs.z / rhs.z, w: lhs.w / rhs.w)
    }
    
    static func /(lhs: Vec4<T>, s: T) -> Vec4<T> where T: BinaryFloatingPoint {
        return Vec4(x: lhs.x / s, y: lhs.y / s, z: lhs.z / s, w: lhs.w / s)
    }
    
    static func /(lhs: Vec4<T>, s: T) -> Vec4<T> where T: BinaryInteger {
        return Vec4(x: lhs.x / s, y: lhs.y / s, z: lhs.z / s, w: lhs.w / s)
    }
}
