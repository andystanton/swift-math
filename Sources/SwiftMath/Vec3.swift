typealias DVec3 = Vec3<Double>
typealias FVec3 = Vec3<Float>
typealias IVec3 = Vec3<Int>
typealias UVec3 = Vec3<UInt>

extension Vec3 {
    init(_ s: T) {
        self.init(x: s, y: s, z: s)
    }
    
    init(_ v: Vec2<T>, z: T) {
        self.init(x: v.x, y: v.y, z: z)
    }
    
    init(_ v: Vec3<T>) {
        self.init(x: v.x, y: v.y, z: v.z)
    }
    
    init(_ x: T, _ y: T, _ z: T) { 
        self.init(x: x, y: y, z: z)
    }
}

//extension Vec3: Hashable, Equatable where T: Hashable, T: Equatable {
//    static func == (lhs: Vec3, rhs: Vec3) -> Bool {
//        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
//    }
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(x)
//        hasher.combine(y)
//        hasher.combine(z)
//    }
//}



//extension Vec3 where T == Float {
//    func toSIMD3() -> SIMD3<T> {
//        return SIMD3<T>(x, y, z)
//    }
//}

extension Vec3 where T == Double {
    func toSIMD3() -> SIMD3<T> {
        return SIMD3<T>(x, y, z)
    }
}

struct Vec3<T: Numeric> {
    let x: T
    let y: T
    let z: T
    
    subscript(index: Int) -> T {
        get {
            switch(index) {
                case 0: return x
                case 1: return y
                case 2: return z
                default: fatalError("Cannot access index \(index) of Vec3<\(T.self)>")
            }
        }
    }
    
    subscript() -> [T] {
        get {
            return [x, y, z]
        }
    }
    
    var xy: Vec2<T> {
        return Vec2(x: x, y: y)
    }
    
    func dot(_ rhs: Vec3<T>) -> T {
        return self.x * rhs.x + self.y * rhs.y + self.z * rhs.z
    }
    
    func cross(_ rhs: Vec3<T>) -> Vec3<T> {
        return Vec3(
            x: self.y * rhs.z - rhs.y * self.z,
            y: self.z * rhs.x - rhs.z * self.x,
            z: self.x * rhs.y - rhs.x * self.y)
    }
    
    // normalize not supported on integer types
    func normalize() -> Vec3<T> where T: BinaryFloatingPoint {
        return self / len()
    }
    
    func len() -> T where T: BinaryFloatingPoint {
        return (x * x + y * y + z * z).squareRoot()
    }
    
    // use float for length of integer types
    func len() -> Float where T: BinaryInteger {
        return (Float(x) * Float(x) + Float(y) * Float(y) + Float(z) * Float(z)).squareRoot()
    }
    
    func toPos() -> Vec4<T> {
        return Vec4<T>(self, 1)
    }
    
    func toVec() -> Vec4<T> {
        return Vec4<T>(self, 0)
    }
    
    static func ~=(lhs: Vec3<T>, rhs: Vec3<T>) -> Bool where T == Double { 
        return lhs.x.almostEquals(rhs.x) && lhs.y.almostEquals(rhs.y) && lhs.z.almostEquals(rhs.z)
    }    
    
    static func ~=(lhs: Vec3<T>, rhs: Vec3<T>) -> Bool where T == Float {
        return lhs.x.almostEquals(rhs.x) && lhs.y.almostEquals(rhs.y) && lhs.z.almostEquals(rhs.z)
    }
    
//    static func ==(lhs: Vec3<T>, rhs: Vec3<T>) -> Bool {
//        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
//    }
//    
    static func +(lhs: Vec3<T>, rhs: Vec3<T>) -> Vec3<T> {
        return Vec3(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }
    
    static func -(lhs: Vec3<T>, rhs: Vec3<T>) -> Vec3<T> {
        return Vec3(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
    }
    
    static prefix func -(lhs: Vec3<T>) -> Vec3<T> where T: BinaryFloatingPoint {
        return Vec3(x: -lhs.x, y: -lhs.y, z: -lhs.z)
    }
    
    // this is non-uniform scale, not dot product
    static func *(lhs: Vec3<T>, rhs: Vec3<T>) -> Vec3<T> {
        return Vec3(x: lhs.x * rhs.x, y: lhs.y * rhs.y, z: lhs.z * rhs.z)
    }
    
    static func *(lhs: Vec3<T>, s: T) -> Vec3<T> {
        return Vec3(x: lhs.x * s, y: lhs.y * s, z: lhs.z * s)
    }
    
    static func /(lhs: Vec3<T>, rhs: Vec3<T>) -> Vec3<T> where T: BinaryFloatingPoint {
        return Vec3(x: lhs.x / rhs.x, y: lhs.y / rhs.y, z: lhs.z / rhs.z)
    }
    
    static func /(lhs: Vec3<T>, rhs: Vec3<T>) -> Vec3<T> where T: BinaryInteger {
        return Vec3(x: lhs.x / rhs.x, y: lhs.y / rhs.y, z: lhs.z / rhs.z)
    }
    
    static func /(lhs: Vec3<T>, s: T) -> Vec3<T> where T: BinaryFloatingPoint{
        return Vec3(x: lhs.x / s, y: lhs.y / s, z: lhs.z / s)
    }
    
    static func /(lhs: Vec3<T>, s: T) -> Vec3<T> where T: BinaryInteger {
        return Vec3(x: lhs.x / s, y: lhs.y / s, z: lhs.z / s)
    }
}
