import simd

public typealias V4 = SIMD4
public typealias FV4 = V4<Float>

extension SIMD4 {
    // easier to type than "repeating", but a single value version with omitted
    //  argument label version is already taken (and deprecated).
    init(of: Scalar) {
        self.init(repeating: of)
    }
    
    public func flatten() -> [Scalar] {
        return [x, y, z, w]
    }
    
}

extension SIMD4 where Scalar: FloatingPoint {
    public func len() -> Scalar {
        return sqrt(x * x + y * y + z * z + w * w)
    }
    
    public func normalize() -> Self {
        return self / self.len()
    }
    
    public func dot(_ other: Self) -> Scalar {
        return x * other.x + y * other.y + z * other.z + w * other.w
    }
}

extension SIMD4 where Scalar == Float {
    public static var xUnit = Self(x: 1, y: 0, z: 0, w: 0)
    public static var yUnit = Self(x: 0, y: 1, z: 0, w: 0)
    public static var zUnit = Self(x: 0, y: 0, z: 1, w: 0)
    public static var wUnit = Self(x: 0, y: 0, z: 0, w: 1)
    
    public func almostEquals(_ rhs: Self) -> Bool {
        return self.x.almostEquals(rhs.x)
            && self.y.almostEquals(rhs.y)
            && self.z.almostEquals(rhs.z)
            && self.w.almostEquals(rhs.w)
    }
}
