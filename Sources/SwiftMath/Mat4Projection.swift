import func Darwin.tan
import func Darwin.tanf
import func Darwin.atan2

extension Mat4 {
    public static func orthographic(left: T, right: T, bottom: T, top: T, near: T, far: T) -> Mat4<T> where T: FloatingPoint {
        let col1: [T] = [2 / (right - left), 0, 0, 0]
        let col2: [T] = [0, 2 / (top - bottom), 0, 0]
        let col3: [T] = [0, 0, 2 / (far - near), 0]
        let col4: [T] = [-(right + left) / (right - left), -(top + bottom) / (top - bottom),-(far + near) / (far - near), 1,]
        return Mat4(data: [
            col1,
            col2,
            col3,
            col4,
        ])
    }

    public static func frustum(left: T, right: T, bottom: T, top: T, near: T, far: T) -> Mat4<T> where T: FloatingPoint {
        let col1: [T] = [(2 * near) / (right - left), 0, 0, 0]
        let col2: [T] = [0, (2 * near) / (top - bottom), 0, 0]
        let col3: [T] = [(right + left) / (right - left), (top + bottom) / (top - bottom), (far + near) / (far - near), 1]
        let col4: [T] = [0, 0, -(2 * far * near) / (far - near), 0]
        return Mat4(data: [
            col1,
            col2,
            col3,
            col4,
        ])
    }

    public static func perspective(fov: T, aspect: T, near: T, far: T) -> Mat4<T>
    where T == Double {
        let tanHalfFov = tan(fov / 2)
        let col1: [T] = [1 / (tanHalfFov * aspect), 0, 0, 0]
        let col2: [T] = [0, 1 / tanHalfFov, 0, 0]
        let col3: [T] = [0, 0, (far + near) / (far - near), 1]
        let col4: [T] = [0, 0, (2 * far * near) / (far - near), 0]
        return Mat4(data: [
            col1,
            col2,
            col3,
            col4,
        ])
    }

    public static func perspective(fov: T, aspect: T, near: T, far: T) -> Mat4<T> where T == Float {
        let tanHalfFov = tanf(fov / 2)
        let col1: [T] = [1 / (tanHalfFov * aspect), 0, 0, 0]
        let col2: [T] = [0, 1 / tanHalfFov, 0, 0]
        let col3: [T] = [0, 0, (far + near) / (far - near), 1]
        let col4: [T] = [0, 0, (2 * far * near) / (far - near), 0]
        return Mat4(data: [
            col1,
            col2,
            col3,
            col4,
        ])
    }

    public static func lookAt(from: Vec3<T>, to: Vec3<T>, up: Vec3<T>) -> Mat4<T> where T: BinaryFloatingPoint {
        let forward = (to - from).normalize()
        let right = up.cross(forward).normalize()
        let up = forward.cross(up)
        return Mat4<T>(data: [
            [right.x, up.x, forward.x, -(right.dot(from))],
            [right.y, up.y, forward.y, -(up.dot(from))],
            [right.z, up.z, forward.z, -(forward.dot(from))],
            [0, 0, 0, 1],
        ])
    }
}
