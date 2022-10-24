import simd

public typealias V2 = SIMD2
public typealias FV2 = V2<Float>

extension SIMD2 {
    // easier to type than "repeating", but a single value version with omitted
    //  argument label version is already taken (and deprecated).
    init(of: Scalar) {
        self.init(repeating: of)
    }
    
    public var data: [Scalar] {
        return [x, y]
    }
}
    
extension SIMD2 where Scalar: FloatingPoint {
    func len() -> Scalar {
        return sqrt(x * x + y * y)
    }
    
    func normalize() -> Self {
        return self / sqrt(x * x + y * y)
    }
    
    func dot(other: Self) -> Scalar {
        return x * other.x + y * other.y
    }
}

extension SIMD2 where Scalar == Float {
    public static var xUnit = Self(x: 1, y: 0)
    public static var yUnit = Self(x: 0, y: 1)
    
    public func almostEquals(_ rhs: Self) -> Bool {
        return self.x.almostEquals(rhs.x) && self.y.almostEquals(rhs.y)
    }
}
