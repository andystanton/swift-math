import simd

public typealias FM3 = simd_float3x3

extension simd_float3x3 {
    public var data: [[Float]] {
        [
            columns.0.data,
            columns.1.data,
            columns.2.data,
        ]
    }

    public func almostEquals(_ other: Self) -> Bool {
        columns.0.almostEquals(other.columns.0)
                && columns.1.almostEquals(other.columns.1)
                && columns.2.almostEquals(other.columns.2)
    }

    public static func scale(_ scalar: Float) -> FM3 {
        FM3(
                FV3(scalar, 0, 0),
                FV3(0, scalar, 0),
                FV3(0, 0, scalar))
    }

    public static func scale(_ scaleVector: FV2) -> FM3 {
        FM3(
                FV3(scaleVector.x, 0, 0),
                FV3(0, scaleVector.y, 0),
                FV3(0, 0, 1))
    }

    public static func translation(_ translateVector: FV2) -> FM3 {
        FM3(
                FV3(1, 0, 0),
                FV3(0, 1, 0),
                FV3(translateVector, 1))
    }
}

