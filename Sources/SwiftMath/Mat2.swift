import Darwin

public typealias DMat2 = Mat2<Double>
public typealias FMat2 = Mat2<Float>

public struct Mat2<T: FloatingPoint> {
    let data: [[T]]

    public init(data: [[T]]) {
        self.data = data
    }

    public static func memorySize() -> Int {
        return MemoryLayout<T>.size * 2 * 2
    }

    public subscript(index: Int) -> [T] {
        get {
            return data[index]
        }
    }

    public func transpose() -> Mat2<T> {
        return Mat2(data: [
            [self[0][0], self[1][0]],
            [self[0][1], self[1][1]],
        ])
    }

    public static func scale(_ rVec: Vec3<T>) -> Mat2<T> where T == Double {
        return Mat2(data: [
            [rVec.x, 0],
            [0, rVec.y],
        ])
    }

    public static func scale(_ rVec: Vec3<T>) -> Mat2<T> where T == Float {
        return Mat2(data: [
            [rVec.x, 0],
            [0, rVec.y],
        ])
    }

    public static func - (lhs: Mat2<T>, rhs: Mat2<T>) -> Mat2<T> {
        return Mat2<T>(
            data: zip(lhs.data, rhs.data).flatMap { zip($0.0, $0.1).map { $0.0 - $0.1 } })
    }

    public static prefix func - (lhs: Mat2<T>) -> Mat2<T> {
        return Mat2<T>(data: lhs.data.flatMap { $0.map { -$0 } })
    }

    public func flatten() -> [T] {
        return self.data[0] + self.data[1]
    }

    public func inverse() -> Mat2<T> {
        let twoDeterminant = data[0][0] * data[1][1] - data[1][0] * data[0][1]
        return Mat2<T>(data: [
            [+data[1][1] / twoDeterminant, -data[0][1] / twoDeterminant, 0],
            [-data[1][0] / twoDeterminant, +data[0][0] / twoDeterminant, 0],

        ])
    }
}

extension Mat2 {
    public init() {
        self.init(1)
    }

    public init(_ s: T) {
        self.init(
            data: [
                [s, 0],
                [0, s],
            ])
    }
}
