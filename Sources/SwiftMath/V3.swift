import simd

public typealias V3 = SIMD3
public typealias FV3 = V3<Float>

extension SIMD3 {
    // easier to type than "repeating", but a single value version with omitted
    //  argument label version is already taken (and deprecated).
    init(of: Scalar) {
        self.init(repeating: of)
    }

    public var data: [Scalar] {
        return [x, y, z]
    }
}

extension SIMD3 where Scalar: FloatingPoint {
    public func toPos() -> V4<Scalar> {
        return V4(self, 1)
    }

    public func toDir() -> V4<Scalar> {
        return V4(self, 0)
    }

    public func len() -> Scalar {
        return sqrt(x * x + y * y + z * z)
    }

    public func normalize() -> Self {
        return self / self.len()
    }

    public func dot(_ other: Self) -> Scalar {
        return x * other.x + y * other.y + z * other.z
    }

    public func cross(_ other: Self) -> Self {
        return Self(
            x: self.y * other.z - other.y * self.z,
            y: self.z * other.x - other.z * self.x,
            z: self.x * other.y - other.x * self.y)
    }

    public static func faceToNormal(face: [Self]) -> Self {
        let v0v1 = face[1] - face[0]
        let v1v2 = face[2] - face[1]
        return v1v2.cross(v0v1)
    }
}

extension SIMD3 where Scalar == Float {
    public static var xUnit = Self(x: 1, y: 0, z: 0)
    public static var yUnit = Self(x: 0, y: 1, z: 0)
    public static var zUnit = Self(x: 0, y: 0, z: 1)

    public func almostEquals(_ rhs: Self) -> Bool {
        return self.x.almostEquals(rhs.x)
            && self.y.almostEquals(rhs.y)
            && self.z.almostEquals(rhs.z)
    }
}
