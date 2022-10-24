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
        return self[0][0].almostEquals(rhs[0][0]) && self[0][1].almostEquals(rhs[0][1])
            && self[0][2].almostEquals(rhs[0][2])
            && self[1][0].almostEquals(rhs[1][0]) && self[1][1].almostEquals(rhs[1][1])
            && self[1][2].almostEquals(rhs[1][2])
            && self[2][0].almostEquals(rhs[2][0]) && self[2][1].almostEquals(rhs[2][1])
            && self[2][2].almostEquals(rhs[2][2])
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
}

