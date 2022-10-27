import simd

public typealias Vec2 = SIMD2
public typealias FVec2 = Vec2<Float>

extension SIMD2 {
    // easier to type than "repeating", but a single value version with omitted
    //  argument label version is already taken (and deprecated).
    init(of: Scalar) {
        self.init(repeating: of)
    }

    public var data: [Scalar] {
        [x, y]
    }

    public var flatten: [Scalar] {
        [x, y]
    }
}

extension SIMD2 where Scalar: FloatingPoint {
    func len() -> Scalar {
        sqrt(x * x + y * y)
    }

    func normalize() -> Self {
        self / sqrt(x * x + y * y)
    }

    func dot(other: Self) -> Scalar {
        x * other.x + y * other.y
    }
}

extension SIMD2 where Scalar == Float {
    public static var xUnit = Self(x: 1, y: 0)
    public static var yUnit = Self(x: 0, y: 1)

    public func almostEquals(_ rhs: Self) -> Bool {
        x.almostEquals(rhs.x) && y.almostEquals(rhs.y)
    }
}
