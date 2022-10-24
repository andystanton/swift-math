import simd

public typealias FM3 = simd_float3x3

extension simd_float3x3 {
    public var data: [[Float]] {
        return [
            self.columns.0.data,
            self.columns.1.data,
            self.columns.2.data,
        ]
    }

    public func almostEquals(_ rhs: Self) -> Bool {
        return self.columns.0.almostEquals(rhs.columns.0)
            && self.columns.1.almostEquals(rhs.columns.1)
            && self.columns.2.almostEquals(rhs.columns.2)
    }

    public static func scale(_ scalar: Float) -> FM3 {
        return FM3(
            FV3(scalar, 0, 0),
            FV3(0, scalar, 0),
            FV3(0, 0, scalar))
    }

    public static func scale(_ scaleVector: FV3) -> FM3 {
        return FM3(
            FV3(scaleVector.x, 0, 0),
            FV3(0, scaleVector.y, 0),
            FV3(0, 0, scaleVector.z))
    }

    public static func rotation(_ rVec: FV3) -> Self {
        return Self(
            FV3(
                cos(rVec.y) * cos(rVec.z),
                sin(rVec.x) * sin(rVec.y) * cos(rVec.z) - cos(rVec.x) * sin(rVec.z),
                sin(rVec.x) * sin(rVec.z) + cos(rVec.x) * sin(rVec.y) * cos(rVec.z)
            ),
            FV3(
                cos(rVec.y) * sin(rVec.z),
                cos(rVec.x) * cos(rVec.z) + sin(rVec.x) * sin(rVec.y) * sin(rVec.z),
                cos(rVec.x) * sin(rVec.y) * sin(rVec.z) - sin(rVec.x) * cos(rVec.z)
            ),
            FV3(
                -sin(rVec.y),
                sin(rVec.x) * cos(rVec.y),
                 cos(rVec.x) * cos(rVec.y)
            )
        )
    }

    public static func translation(_ translateVec: FV2) -> FM3 {
        return FM3(
            FV3(1, 0, 0),
            FV3(0, 1, 0),
            FV3(translateVec, 1))
    }
}

