import Darwin

public typealias DMat3 = Mat3<Double>
public typealias FMat3 = Mat3<Float>

public struct Mat3<T: FloatingPoint> {
    let data: [[T]]

    public init(data: [[T]]) {
        self.data = data
    }

    public static func memorySize() -> Int {
        return MemoryLayout<T>.size * 3 * 3
    }

    public subscript(index: Int) -> [T] {
        get {
            return data[index]
        }
    }

    public func transpose() -> Mat3<T> {
        return Mat3(data: [
            [self[0][0], self[1][0], self[2][0]],
            [self[0][1], self[1][1], self[2][1]],
            [self[0][2], self[1][2], self[2][2]],
        ])
    }

    public static func rotation(_ rVec: Vec3<T>) -> Mat3<T> {
        return Mat3(1)
    }

    public static func rotation(_ rVec: Vec3<T>) -> Mat3<T> where T == Double {
        let col1 = [cos(rVec.y) * cos(rVec.z), cos(rVec.y) * sin(rVec.z), -sin(rVec.y)]
        let col2 = [
            sin(rVec.x) * sin(rVec.y) * cos(rVec.z) - cos(rVec.x) * sin(rVec.z),
            cos(rVec.x) * cos(rVec.z) + sin(rVec.x) * sin(rVec.y) * sin(rVec.z),
            sin(rVec.x) * cos(rVec.y),
        ]
        let col3 = [
            sin(rVec.x) * sin(rVec.z) + cos(rVec.x) * sin(rVec.y) * cos(rVec.z),
            cos(rVec.x) * sin(rVec.y) * sin(rVec.z) - sin(rVec.x) * cos(rVec.z),
            cos(rVec.x) * cos(rVec.y),
        ]
        return Mat3(data: [
            col1,
            col2,
            col3,
        ])
    }

    public static func rotation(_ rVec: Vec3<T>) -> Mat3<T> where T == Float {
        let col1 = [cos(rVec.y) * cos(rVec.z), cos(rVec.y) * sin(rVec.z), -sin(rVec.y)]
        let col2 = [
            sin(rVec.x) * sin(rVec.y) * cos(rVec.z) - cos(rVec.x) * sin(rVec.z),
            cos(rVec.x) * cos(rVec.z) + sin(rVec.x) * sin(rVec.y) * sin(rVec.z),
            sin(rVec.x) * cos(rVec.y),
        ]
        let col3 = [
            sin(rVec.x) * sin(rVec.z) + cos(rVec.x) * sin(rVec.y) * cos(rVec.z),
            cos(rVec.x) * sin(rVec.y) * sin(rVec.z) - sin(rVec.x) * cos(rVec.z),
            cos(rVec.x) * cos(rVec.y),
        ]
        return Mat3(data: [
            col1,
            col2,
            col3,
        ])
    }

    public static func scale(_ rVec: Vec3<T>) -> Mat3<T> where T == Double {
        return Mat3(data: [
            [rVec.x, 0, 0],
            [0, rVec.y, 0],
            [0, 0, rVec.z],
        ])
    }

    public static func scale(_ rVec: Vec3<T>) -> Mat3<T> where T == Float {
        return Mat3(data: [
            [rVec.x, 0, 0],
            [0, rVec.y, 0],
            [0, 0, rVec.z],
        ])
    }

    public func flatten() -> [T] {
        return self.data[0] + self.data[1] + self.data[2]
    }
}

extension Mat3 {
    public init() {
        self.init(1)
    }

    public init(_ s: T) {
        self.init(
            data: [
                [s, 0, 0],
                [0, s, 0],
                [0, 0, s],
            ])
    }
}
