@_exported import simd

public typealias FMat4 = simd_float4x4

extension simd_float4x4 {
    public var data: [[Float]] {
        [
            columns.0.data,
            columns.1.data,
            columns.2.data,
            columns.3.data,
        ]
    }

    public var flatten: [Float] {
        columns.0.data + columns.1.data + columns.2.data + columns.3.data
    }

    public func almostEquals(_ other: Self) -> Bool {
        columns.0.almostEquals(other.columns.0)
                && columns.1.almostEquals(other.columns.1)
                && columns.2.almostEquals(other.columns.2)
                && columns.3.almostEquals(other.columns.3)
    }

    public func toMat3() -> FMat3 {
        FMat3(columns.0.xyz, columns.1.xyz, columns.2.xyz)
    }

    public static func scale(_ scalar: Float) -> Self {
        FMat4(
                FVec4(scalar, 0, 0, 0),
                FVec4(0, scalar, 0, 0),
                FVec4(0, 0, scalar, 0),
                FVec4(0, 0, 0, scalar))
    }

    public static func scale(_ scaleVector: FVec3) -> Self {
        FMat4(
                FVec4(scaleVector.x, 0, 0, 0),
                FVec4(0, scaleVector.y, 0, 0),
                FVec4(0, 0, scaleVector.z, 0),
                FVec4(0, 0, 0, 1))
    }

    public static func translation(_ translateVector: FVec3) -> Self {
        FMat4(
                FVec4(1, 0, 0, 0),
                FVec4(0, 1, 0, 0),
                FVec4(0, 0, 1, 0),
                FVec4(translateVector, 1))
    }

    public static func rotation(_ rVec: FVec3) -> Self {
        let col1 = FVec4(
                cos(rVec.y) * cos(rVec.z),
                sin(rVec.x) * sin(rVec.y) * cos(rVec.z) - cos(rVec.x) * sin(rVec.z),
                sin(rVec.x) * sin(rVec.z) + cos(rVec.x) * sin(rVec.y) * cos(rVec.z),
                0)
        let col2 = FVec4(
                cos(rVec.y) * sin(rVec.z),
                cos(rVec.x) * cos(rVec.z) + sin(rVec.x) * sin(rVec.y) * sin(rVec.z),
                cos(rVec.x) * sin(rVec.y) * sin(rVec.z) - sin(rVec.x) * cos(rVec.z),
                0)
        let col3 = FVec4(
                -sin(rVec.y),
                sin(rVec.x) * cos(rVec.y),
                cos(rVec.x) * cos(rVec.y),
                0)
        return FMat4(
                col1,
                col2,
                col3,
                FVec4(0, 0, 0, 1))
    }

    public static func rotationYawPitchRollExtrinsic(_ rVec: FVec3) -> Self {
        let col1 = FVec4(
                cos(rVec.y) * cos(rVec.z),
                sin(rVec.x) * sin(rVec.y) * cos(rVec.z) - cos(rVec.x) * sin(rVec.z),
                cos(rVec.x) * sin(rVec.y) * cos(rVec.z) + sin(rVec.x) * sin(rVec.z),
                0)
        let col2 = FVec4(
                cos(rVec.y) * sin(rVec.z),
                sin(rVec.x) * sin(rVec.y) * sin(rVec.z) + cos(rVec.x) * cos(rVec.z),
                cos(rVec.x) * sin(rVec.y) * sin(rVec.z) - sin(rVec.x) * cos(rVec.z),
                0)
        let col3 = FVec4(
                -sin(rVec.y),
                sin(rVec.x) * cos(rVec.y),
                cos(rVec.x) * cos(rVec.y),
                0)
        return FMat4(
                col1,
                col2,
                col3,
                FVec4(0, 0, 0, 1))
    }

    public static func rotationYawPitchRollIntrinsic(_ rVec: FVec3) -> Self {
        let col1 = FVec4(
                cos(rVec.x) * cos(rVec.y),
                cos(rVec.x) * sin(rVec.y) * sin(rVec.z) - sin(rVec.x) * cos(rVec.z),
                cos(rVec.x) * sin(rVec.y) * cos(rVec.z) + sin(rVec.x) * sin(rVec.z),
                0)
        let col2 = FVec4(
                sin(rVec.x) * cos(rVec.y),
                sin(rVec.x) * sin(rVec.y) * sin(rVec.z) + cos(rVec.x) * cos(rVec.z),
                sin(rVec.x) * sin(rVec.y) * cos(rVec.z) - cos(rVec.x) * sin(rVec.z),
                0)
        let col3 = FVec4(
                -sin(rVec.y),
                cos(rVec.y) * sin(rVec.z),
                cos(rVec.y) * cos(rVec.z),
                0)
        return FMat4(
                col1,
                col2,
                col3,
                FVec4(0, 0, 0, 1))
    }
}
