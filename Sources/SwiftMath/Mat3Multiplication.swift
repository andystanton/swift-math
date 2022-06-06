extension Mat3 {
    public static func * (lhs: Mat3<T>, rhs: Vec3<T>) -> Vec3<T> {
        return Vec3<T>(
            lhs[0][0] * rhs.x + lhs[1][0] * rhs.y + lhs[2][0] * rhs.z,
            lhs[0][1] * rhs.x + lhs[1][1] * rhs.y + lhs[2][1] * rhs.z,
            lhs[0][2] * rhs.x + lhs[1][2] * rhs.y + lhs[2][2] * rhs.z)
    }

    public static func * (lhs: Mat3<T>, rhs: Mat3<T>) -> Mat3<T> {
        assert(lhs[0].count == 3)
        assert(lhs[1].count == 3)
        assert(lhs[2].count == 3)
        let col1: [T] =
            [
                lhs.data[0][0] * rhs.data[0][0] + lhs.data[0][1] * rhs.data[1][0] + lhs.data[0][2]
                    * rhs.data[2][0],
                lhs.data[0][0] * rhs.data[0][1] + lhs.data[0][1] * rhs.data[1][1] + lhs.data[0][2]
                    * rhs.data[2][1],
                lhs.data[0][0] * rhs.data[0][2] + lhs.data[0][1] * rhs.data[1][2] + lhs.data[0][2]
                    * rhs.data[2][2],
            ]
        let col2: [T] =
            [
                lhs.data[1][0] * rhs.data[0][0] + lhs.data[1][1] * rhs.data[1][0] + lhs.data[1][2]
                    * rhs.data[2][0],
                lhs.data[1][0] * rhs.data[0][1] + lhs.data[1][1] * rhs.data[1][1] + lhs.data[1][2]
                    * rhs.data[2][1],
                lhs.data[1][0] * rhs.data[0][2] + lhs.data[1][1] * rhs.data[1][2] + lhs.data[1][2]
                    * rhs.data[2][2],
            ]
        let col3: [T] =
            [
                lhs.data[2][0] * rhs.data[0][0] + lhs.data[2][1] * rhs.data[1][0] + lhs.data[2][2]
                    * rhs.data[2][0],
                lhs.data[2][0] * rhs.data[0][1] + lhs.data[2][1] * rhs.data[1][1] + lhs.data[2][2]
                    * rhs.data[2][1],
                lhs.data[2][0] * rhs.data[0][2] + lhs.data[2][1] * rhs.data[1][2] + lhs.data[2][2]
                    * rhs.data[2][2],
            ]
        return Mat3<T>(data: [
            col1, col2, col3,
        ])
    }
}
