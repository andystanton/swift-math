import Darwin

public typealias DMat4 = Mat4<Double>
public typealias FMat4 = Mat4<Float>

public struct Mat4<T: FloatingPoint> {
    let data: [[T]]

    public init(data: [[T]]) {
        self.data = data
    }

    public static func memorySize() -> Int {
        return MemoryLayout<T>.size * 4 * 4
    }

    public subscript(index: Int) -> [T] {
        get {
            return data[index]
        }
    }

    public func transpose() -> Mat4<T> {
        return Mat4(data: [
            [self[0][0], self[1][0], self[2][0], self[3][0]],
            [self[0][1], self[1][1], self[2][1], self[3][1]],
            [self[0][2], self[1][2], self[2][2], self[3][2]],
            [self[0][3], self[1][3], self[2][3], self[3][3]],
        ])
    }

    public func inverse() -> Mat4<T> {

        let c00: T = data[2][2] * data[3][3] - data[3][2] * data[2][3]
        let c02: T = data[1][2] * data[3][3] - data[3][2] * data[1][3]
        let c03: T = data[1][2] * data[2][3] - data[2][2] * data[1][3]

        let c04: T = data[2][1] * data[3][3] - data[3][1] * data[2][3]
        let c06: T = data[1][1] * data[3][3] - data[3][1] * data[1][3]
        let c07: T = data[1][1] * data[2][3] - data[2][1] * data[1][3]

        let c08: T = data[2][1] * data[3][2] - data[3][1] * data[2][2]
        let c10: T = data[1][1] * data[3][2] - data[3][1] * data[1][2]
        let c11: T = data[1][1] * data[2][2] - data[2][1] * data[1][2]

        let c12: T = data[2][0] * data[3][3] - data[3][0] * data[2][3]
        let c14: T = data[1][0] * data[3][3] - data[3][0] * data[1][3]
        let c15: T = data[1][0] * data[2][3] - data[2][0] * data[1][3]

        let c16: T = data[2][0] * data[3][2] - data[3][0] * data[2][2]
        let c18: T = data[1][0] * data[3][2] - data[3][0] * data[1][2]
        let c19: T = data[1][0] * data[2][2] - data[2][0] * data[1][2]

        let c20: T = data[2][0] * data[3][1] - data[3][0] * data[2][1]
        let c22: T = data[1][0] * data[3][1] - data[3][0] * data[1][1]
        let c23: T = data[1][0] * data[2][1] - data[2][0] * data[1][1]

        let f0: Vec4<T> = Vec4<T>(c00, c00, c02, c03)
        let f1: Vec4<T> = Vec4<T>(c04, c04, c06, c07)
        let f2: Vec4<T> = Vec4<T>(c08, c08, c10, c11)
        let f3: Vec4<T> = Vec4<T>(c12, c12, c14, c15)
        let f4: Vec4<T> = Vec4<T>(c16, c16, c18, c19)
        let f5: Vec4<T> = Vec4<T>(c20, c20, c22, c23)

        let v0: Vec4<T> = Vec4<T>(data[1][0], data[0][0], data[0][0], data[0][0])
        let v1: Vec4<T> = Vec4<T>(data[1][1], data[0][1], data[0][1], data[0][1])
        let v2: Vec4<T> = Vec4<T>(data[1][2], data[0][2], data[0][2], data[0][2])
        let v3: Vec4<T> = Vec4<T>(data[1][3], data[0][3], data[0][3], data[0][3])

        let i0 = v1 * f0 - v2 * f1 + v3 * f2
        let i1 = v0 * f0 - v2 * f3 + v3 * f4
        let i2 = v0 * f1 - v1 * f3 + v3 * f5
        let i3 = v0 * f2 - v1 * f4 + v2 * f5

        let sA = Vec4<T>(1, -1, 1, -1)
        let sB = Vec4<T>(-1, 1, -1, 1)
        let inverse = Mat4<T>(data: [
            (i0 * sA).flatten(),
            (i1 * sB).flatten(),
            (i2 * sA).flatten(),
            (i3 * sB).flatten(),
        ])

        let r0: Vec4<T> = Vec4<T>(
            inverse.data[0][0], inverse.data[1][0], inverse.data[2][0], inverse.data[3][0])
        let d0 = Vec4<T>(data[0]) * r0
        let d1 = d0.x + d0.y + d0.z + d0.w
        let oneOverDeterminant = T(1) / d1

        let inverseData: [[T]] = data.map { $0.map { $0 * oneOverDeterminant } }

        return Mat4<T>(data: inverseData)
    }

    public static func translation(_ tVec: Vec3<T>) -> Mat4<T> {
        let identity = Mat4(1)
        return Mat4(data: [
            identity[0],
            identity[1],
            identity[2],
            tVec.toPos().flatten(),
        ])
    }

    public static func rotation(_ rVec: Vec3<T>) -> Mat4<T> {
        return Mat4(1)
    }

    public static func rotation(_ rVec: Vec3<T>) -> Mat4<T> where T == Double {
        let col1 = [cos(rVec.y) * cos(rVec.z), cos(rVec.y) * sin(rVec.z), -sin(rVec.y), 0]
        let col2 = [
            sin(rVec.x) * sin(rVec.y) * cos(rVec.z) - cos(rVec.x) * sin(rVec.z),
            cos(rVec.x) * cos(rVec.z) + sin(rVec.x) * sin(rVec.y) * sin(rVec.z),
            sin(rVec.x) * cos(rVec.y), 0,
        ]
        let col3 = [
            sin(rVec.x) * sin(rVec.z) + cos(rVec.x) * sin(rVec.y) * cos(rVec.z),
            cos(rVec.x) * sin(rVec.y) * sin(rVec.z) - sin(rVec.x) * cos(rVec.z),
            cos(rVec.x) * cos(rVec.y), 0,
        ]
        return Mat4(data: [
            col1,
            col2,
            col3,
            [0, 0, 0, 1],
        ])
    }

    public static func rotation(_ rVec: Vec3<T>) -> Mat4<T> where T == Float {
        let col1 = [cos(rVec.y) * cos(rVec.z), cos(rVec.y) * sin(rVec.z), -sin(rVec.y), 0]
        let col2 = [
            sin(rVec.x) * sin(rVec.y) * cos(rVec.z) - cos(rVec.x) * sin(rVec.z),
            cos(rVec.x) * cos(rVec.z) + sin(rVec.x) * sin(rVec.y) * sin(rVec.z),
            sin(rVec.x) * cos(rVec.y), 0,
        ]
        let col3 = [
            sin(rVec.x) * sin(rVec.z) + cos(rVec.x) * sin(rVec.y) * cos(rVec.z),
            cos(rVec.x) * sin(rVec.y) * sin(rVec.z) - sin(rVec.x) * cos(rVec.z),
            cos(rVec.x) * cos(rVec.y), 0,
        ]
        return Mat4(data: [
            col1,
            col2,
            col3,
            [0, 0, 0, 1],
        ])
    }

    public static func scale(_ rVec: Vec3<T>) -> Mat4<T> where T == Double {
        return Mat4(data: [
            [rVec.x, 0, 0, 0],
            [0, rVec.y, 0, 0],
            [0, 0, rVec.z, 0],
            [0, 0, 0, 1],
        ])
    }

    public static func scale(_ rVec: Vec3<T>) -> Mat4<T> where T == Float {
        return Mat4(data: [
            [rVec.x, 0, 0, 0],
            [0, rVec.y, 0, 0],
            [0, 0, rVec.z, 0],
            [0, 0, 0, 1],
        ])
    }

    public static func - (lhs: Mat4<T>, rhs: Mat4<T>) -> Mat4<T> {
        return Mat4<T>(data: zip(lhs.data, rhs.data).map { zip($0.0, $0.1).map { $0.0 - $0.1 } })
    }

    public static prefix func - (lhs: Mat4<T>) -> Mat4<T> {
        return Mat4<T>(data: lhs.data.map { $0.map { -$0 } })
    }

    public func flatten() -> [T] {
        return self.data[0] + self.data[1] + self.data[2] + self.data[3]
    }

    public func toMat3() -> Mat3<T> {
        return Mat3<T>(data: [
            [self[0][0], self[0][1], self[0][2]],
            [self[1][0], self[1][1], self[1][2]],
            [self[2][0], self[2][1], self[2][2]],
        ])
    }
}

extension Mat4 {
    public init() {
        self.init(1)
    }

    public init(_ s: T) {
        self.init(
            data: [
                [s, 0, 0, 0],
                [0, s, 0, 0],
                [0, 0, s, 0],
                [0, 0, 0, s],
            ])
    }
}
