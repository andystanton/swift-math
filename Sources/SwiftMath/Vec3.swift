import simd

public typealias Vec3 = SIMD3
public typealias FVec3 = Vec3<Float>

extension SIMD3 {
    // easier to type than "repeating", but a single value version with omitted
    //  argument label version is already taken (and deprecated).
    init(of: Scalar) {
        self.init(repeating: of)
    }

    public var data: [Scalar] {
        [x, y, z]
    }
}

extension SIMD3 where Scalar: FloatingPoint {
    public func toPos() -> Vec4<Scalar> {
        Vec4(self, 1)
    }

    public func toDir() -> Vec4<Scalar> {
        Vec4(self, 0)
    }

    public func len() -> Scalar {
        sqrt(x * x + y * y + z * z)
    }

    public func normalize() -> Self {
        self / len()
    }

    public func dot(_ other: Self) -> Scalar {
        x * other.x + y * other.y + z * other.z
    }

    public func cross(_ other: Self) -> Self {
        Self(
                x: y * other.z - other.y * z,
                y: z * other.x - other.z * x,
                z: x * other.y - other.x * y)
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
        x.almostEquals(rhs.x)
                && y.almostEquals(rhs.y)
                && z.almostEquals(rhs.z)
    }
}
