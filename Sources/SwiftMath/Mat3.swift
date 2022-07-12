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

    public static func - (lhs: Mat3<T>, rhs: Mat3<T>) -> Mat3<T> {
        return Mat3<T>(
            data: zip(lhs.data, rhs.data).map { zip($0.0, $0.1).map { $0.0 - $0.1 } })
    }

    public static prefix func - (lhs: Mat3<T>) -> Mat3<T> {
        return Mat3<T>(data: lhs.data.map { $0.map { -$0 } })
    }

    public func toMat2() -> Mat2<T> {
        return Mat2<T>(data: [
            Array(self.data[0][0...1]),
            Array(self.data[1][0...1]),
        ])
    }

    public func inverse() -> Mat3<T> {
        let d0: T =
            self.data[0][0]
            * (self.data[1][1] * self.data[2][2] - self.data[2][1] * self.data[1][2])
        let d1: T =
            self.data[1][0]
            * (self.data[0][1] * self.data[2][2] - self.data[2][1] * self.data[0][2])
        let d2: T =
            self.data[2][0]
            * (self.data[0][1] * self.data[1][2] - self.data[1][1] * self.data[0][2])

        let determinant: T = d0 - d1 + d2

        let oneOverDeterminant: T =
            T(1) / determinant
        let col1: [T] = [
            (data[1][1] * data[2][2] - data[2][1] * data[1][2]) * oneOverDeterminant,
            -(data[0][1] * data[2][2] - data[2][1] * data[0][2]) * oneOverDeterminant,
            (data[0][1] * data[1][2] - data[1][1] * data[0][2]) * oneOverDeterminant,
        ]
        let col2: [T] = [
            -(data[1][0] * data[2][2] - data[2][0] * data[1][2]) * oneOverDeterminant,
            (data[0][0] * data[2][2] - data[2][0] * data[0][2]) * oneOverDeterminant,
            -(data[0][0] * data[1][2] - data[1][0] * data[0][2]) * oneOverDeterminant,
        ]
        let col3: [T] = [
            (data[1][0] * data[2][1] - data[2][0] * data[1][1]) * oneOverDeterminant,
            -(data[0][0] * data[2][1] - data[2][0] * data[0][1]) * oneOverDeterminant,
            (data[0][0] * data[1][1] - data[1][0] * data[0][1]) * oneOverDeterminant,
        ]

        return Mat3<T>(data: [
            col1,
            col2,
            col3,
        ])
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
