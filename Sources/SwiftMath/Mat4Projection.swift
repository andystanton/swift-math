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

    static func perspective(fovY: T, aspect: T, near: T, far: T) -> Mat4<T> {
        return Mat4(1)
    }
}
