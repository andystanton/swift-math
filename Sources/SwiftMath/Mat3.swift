@_exported import simd

public typealias FMat3 = simd_float3x3

extension simd_float3x3 {
    public var data: [[Float]] {
        [
            columns.0.data,
            columns.1.data,
            columns.2.data,
        ]
    }

    public var flatten: [Float] {
        columns.0.data + columns.1.data + columns.2.data
    }

    public func almostEquals(_ other: Self) -> Bool {
        columns.0.almostEquals(other.columns.0)
                && columns.1.almostEquals(other.columns.1)
                && columns.2.almostEquals(other.columns.2)
    }

    public func toMat4() -> simd_float4x4 {
        simd_float4x4(
                columns.0.toDir(),
                columns.1.toDir(),
                columns.2.toDir(),
                FVec4.wUnit)
    }

    public static func scale(_ scalar: Float) -> Self {
        Self(
                FVec3(scalar, 0, 0),
                FVec3(0, scalar, 0),
                FVec3(0, 0, scalar))
    }

    public static func scale(_ scaleVector: FVec2) -> Self {
        Self(
                FVec3(scaleVector.x, 0, 0),
                FVec3(0, scaleVector.y, 0),
                FVec3(0, 0, 1))
    }

    public static func translation(_ translateVector: FVec2) -> Self {
        Self(
                FVec3(1, 0, 0),
                FVec3(0, 1, 0),
                FVec3(translateVector, 1))
    }
}

