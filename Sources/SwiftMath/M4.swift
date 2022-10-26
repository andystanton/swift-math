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

    public static func scale(_ scalar: Float) -> Self {
        FM4(
                FV4(scalar, 0, 0, 0),
                FV4(0, scalar, 0, 0),
                FV4(0, 0, scalar, 0),
                FV4(0, 0, 0, scalar))
    }

    public static func scale(_ scaleVector: FV3) -> Self {
        FM4(
                FV4(scaleVector.x, 0, 0, 0),
                FV4(0, scaleVector.y, 0, 0),
                FV4(0, 0, scaleVector.z, 0),
                FV4(0, 0, 0, 1))
    }

    public static func translation(_ translateVector: FV3) -> Self {
        FM4(
                FV4(1, 0, 0, 0),
                FV4(0, 1, 0, 0),
                FV4(0, 0, 1, 0),
                FV4(translateVector, 1))
    }

    public static func rotation(_ rVec: FV3) -> Self {
        let col1 = FV4(
                cos(rVec.y) * cos(rVec.z),
                sin(rVec.x) * sin(rVec.y) * cos(rVec.z) - cos(rVec.x) * sin(rVec.z),
                sin(rVec.x) * sin(rVec.z) + cos(rVec.x) * sin(rVec.y) * cos(rVec.z),
                0)
        let col2 = FV4(
                cos(rVec.y) * sin(rVec.z),
                cos(rVec.x) * cos(rVec.z) + sin(rVec.x) * sin(rVec.y) * sin(rVec.z),
                cos(rVec.x) * sin(rVec.y) * sin(rVec.z) - sin(rVec.x) * cos(rVec.z),
                0)
        let col3 = FV4(
                -sin(rVec.y),
                sin(rVec.x) * cos(rVec.y),
                cos(rVec.x) * cos(rVec.y),
                0)
        return FM4(
                col1,
                col2,
                col3,
                FV4(0, 0, 0, 1))
    }
}
