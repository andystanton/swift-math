@_exported import simd

public typealias Vec4 = SIMD4
public typealias FVec4 = Vec4<Float>

extension SIMD4 {
    // easier to type than "repeating", but a single value version with omitted
    //  argument label version is already taken (and deprecated).
    init(of: Scalar) {
        self.init(repeating: of)
    }

    public var data: [Scalar] {
        [x, y, z, w]
    }

    public var xyz: SIMD3<Scalar> {
        SIMD3<Scalar>(x, y, z)
    }
}

extension SIMD4 where Scalar: FloatingPoint {
    public func len() -> Scalar {
        sqrt(x * x + y * y + z * z + w * w)
    }

    public func normalize() -> Self {
        self / len()
    }

    public func dot(_ other: Self) -> Scalar {
        x * other.x + y * other.y + z * other.z + w * other.w
    }
}

extension SIMD4 where Scalar == Float {
    public static var xUnit = Self(x: 1, y: 0, z: 0, w: 0)
    public static var yUnit = Self(x: 0, y: 1, z: 0, w: 0)
    public static var zUnit = Self(x: 0, y: 0, z: 1, w: 0)
    public static var wUnit = Self(x: 0, y: 0, z: 0, w: 1)

    public func almostEquals(_ other: Self) -> Bool {
        x.almostEquals(other.x)
                && y.almostEquals(other.y)
                && z.almostEquals(other.z)
                && w.almostEquals(other.w)
    }
}
