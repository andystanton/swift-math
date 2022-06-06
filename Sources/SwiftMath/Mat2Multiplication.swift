extension Mat2 {
    public static func * (lhs: Mat2<T>, rhs: Vec2<T>) -> Vec2<T> {
        return Vec2<T>(
            lhs[0][0] * rhs.x + lhs[1][0] * rhs.y,
            lhs[0][1] * rhs.x + lhs[1][1] * rhs.y)
    }

    public static func * (lhs: Mat2<T>, rhs: Mat2<T>) -> Mat2<T> {
        assert(lhs[0].count == 2)
        assert(lhs[1].count == 2)
        let col1: [T] =
            [
                lhs.data[0][0] * rhs.data[0][0] + lhs.data[0][1] * rhs.data[1][0],
                lhs.data[0][0] * rhs.data[0][1] + lhs.data[0][1] * rhs.data[1][1],
            ]
        let col2: [T] =
            [
                lhs.data[1][0] * rhs.data[0][0] + lhs.data[1][1] * rhs.data[1][0],
                lhs.data[1][0] * rhs.data[0][1] + lhs.data[1][1] * rhs.data[1][1],
            ]
        return Mat2<T>(data: [
            col1, col2,
        ])
    }
}
