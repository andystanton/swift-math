import Darwin

extension Mat4 {
    static func orthographic(left: T, right: T, bottom: T, top: T, near: T, far: T) -> Mat4<T>
    where T: FloatingPoint {
        let col1: [T] = [2 / (right - left), 0, 0, 0]
        let col2: [T] = [0, 2 / (top - bottom), 0, 0]
        let col3: [T] = [0, 0, -2 / (far - near), 0]
        let col4: [T] = [
            -(right + left) / (right - left), -(top + bottom) / (top - bottom),
            -(far + near) / (far - near), 1,
        ]
        return Mat4(data: [
            col1,
            col2,
            col3,
            col4,
        ])
    }

    static func frustum(left: T, right: T, bottom: T, top: T, near: T, far: T) -> Mat4<T> where T: FloatingPoint {
        let col1: [T] = [2 * near / (right - left), 0, 0, 0]
        let col2: [T] = [0, 2 * near / (top - bottom), 0, 0]
        let col3: [T] = [0, 0, -(far + near) / (far - near), -1]
        let col4: [T] = -near * (right + left) / (right - left), -near * (top + bottom) / (top - bottom), 2 * far * near / (near - far), 0]
        return Mat4(data: [
            col1,
            col2,
            col3,
            col4,
        ])
    }

    static func perspective(fov: T, aspect: T, near: T, far: T) -> Mat4<T> where T == Double {
        let tanHalfFov = tan(fov / 2)
        let col1: [T] = [1 / (tanHalfFov * aspect), 0, 0, 0]
        let col2: [T] = [0, 1 / tanHalfFov, 0, 0]
        let col3: [T] = [0, 0, (-near - far) / (near - far), 2 * far * near / (near - far)]
        let col4: [T] = [0, 0, 1, 0]
        return Mat4(data: [
            col1,
            col2,
            col3,
            col4,
        ])
    }

    static func perspective(fov: T, aspect: T, near: T, far: T) -> Mat4<T> where T == Float {
        let tanHalfFov = tanf(fov / 2)
        let col1: [T] = [1 / (tanHalfFov * aspect), 0, 0, 0]
        let col2: [T] = [0, 1 / tanHalfFov, 0, 0]
        let col3: [T] = [0, 0, (-near - far) / (near - far), 2 * far * near / (near - far)]
        let col4: [T] = [0, 0, 1, 0]
        return Mat4(data: [
            col1,
            col2,
            col3,
            col4,
        ])
    }
}
