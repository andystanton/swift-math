import simd

public typealias FM4 = simd_float4x4

extension simd_float4x4 {
    public var data: [[Float]] {
        [
            columns.0.data,
            columns.1.data,
            columns.2.data,
            columns.3.data,
        ]
    }

    public func almostEquals(_ other: Self) -> Bool {
        columns.0.almostEquals(other.columns.0)
                && columns.1.almostEquals(other.columns.1)
                && columns.2.almostEquals(other.columns.2)
                && columns.3.almostEquals(other.columns.3)
    }

    public static func scale(_ scalar: Float) -> FM4 {
        FM4(
                FV4(scalar, 0, 0, 0),
                FV4(0, scalar, 0, 0),
                FV4(0, 0, scalar, 0),
                FV4(0, 0, 0, scalar))
    }

    public static func scale(_ scaleVector: FV3) -> FM4 {
        FM4(
                FV4(scaleVector.x, 0, 0, 0),
                FV4(0, scaleVector.y, 0, 0),
                FV4(0, 0, scaleVector.z, 0),
                FV4(0, 0, 0, 1))
    }

    public static func translation(_ translateVector: FV3) -> FM4 {
        FM4(
                FV4(1, 0, 0, 0),
                FV4(0, 1, 0, 0),
                FV4(0, 0, 1, 0),
                FV4(translateVector, 1))
    }
}

