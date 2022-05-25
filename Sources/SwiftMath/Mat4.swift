import Darwin

typealias DMat4 = Mat4<Double>
typealias FMat4 = Mat4<Float>

public struct Mat4<T: FloatingPoint> {
    let data: [[T]]
    public static let memorySize = MemoryLayout.size<T> * 4 * 4

    subscript(index: Int) -> [T] {
        get {
            return data[index]
        }
    }

    func transpose() -> Mat4<T> {
        return Mat4(data: [
            [self[0][0], self[1][0], self[2][0], self[3][0]],
            [self[0][1], self[1][1], self[2][1], self[3][1]],
            [self[0][2], self[1][2], self[2][2], self[3][2]],
            [self[0][3], self[1][3], self[2][3], self[3][3]],
        ])
    }

    static func translation(_ tVec: Vec3<T>) -> Mat4<T> {
        let identity = Mat4(1)
        return Mat4(data: [
            identity[0],
            identity[1],
            identity[2],
            tVec.toPos()[],
        ])
    }

    static func rotation(_ rVec: Vec3<T>) -> Mat4<T> {
        return Mat4(1)
    }

    static func rotation(_ rVec: Vec3<T>) -> Mat4<T> where T == Double {
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

    static func rotation(_ rVec: Vec3<T>) -> Mat4<T> where T == Float {
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

    static func scale(_ rVec: Vec3<T>) -> Mat4<T> where T == Double {
        return Mat4(data: [
            [rVec.x, 0, 0, 0],
            [0, rVec.y, 0, 0],
            [0, 0, rVec.z, 0],
            [0, 0, 0, 1],
        ])
    }

    static func scale(_ rVec: Vec3<T>) -> Mat4<T> where T == Float {
        return Mat4(data: [
            [rVec.x, 0, 0, 0],
            [0, rVec.y, 0, 0],
            [0, 0, rVec.z, 0],
            [0, 0, 0, 1],
        ])
    }
}

extension Mat4 {
    public init(_ s: T) {
        self.init(
            data: [
                [s, T.zero, T.zero, T.zero],
                [T.zero, s, T.zero, T.zero],
                [T.zero, T.zero, s, T.zero],
                [T.zero, T.zero, T.zero, s],
            ])
    }
}
