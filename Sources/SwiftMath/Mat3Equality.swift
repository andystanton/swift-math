extension Mat3 {
    public static func == (lhs: Mat3<T>, rhs: Mat3<T>) -> Bool {
        return lhs[0][0] == rhs[0][0] && lhs[0][1] == rhs[0][1] && lhs[0][2] == rhs[0][2]
            && lhs[1][0] == rhs[1][0] && lhs[1][1] == rhs[1][1] && lhs[1][2] == rhs[1][2]
            && lhs[2][0] == rhs[2][0] && lhs[2][1] == rhs[2][1] && lhs[2][2] == rhs[2][2]
    }

    public func almostEquals(_ rhs: Mat3<T>) -> Bool where T == Float {
        return self[0][0].almostEquals(rhs[0][0]) && self[0][1].almostEquals(rhs[0][1])
            && self[0][2].almostEquals(rhs[0][2])
            && self[1][0].almostEquals(rhs[1][0]) && self[1][1].almostEquals(rhs[1][1])
            && self[1][2].almostEquals(rhs[1][2])
            && self[2][0].almostEquals(rhs[2][0]) && self[2][1].almostEquals(rhs[2][1])
            && self[2][2].almostEquals(rhs[2][2])
    }

    public func almostEquals(_ rhs: Mat3<T>) -> Bool where T == Double {
        return self[0][0].almostEquals(rhs[0][0]) && self[0][1].almostEquals(rhs[0][1])
            && self[0][2].almostEquals(rhs[0][2])
            && self[1][0].almostEquals(rhs[1][0]) && self[1][1].almostEquals(rhs[1][1])
            && self[1][2].almostEquals(rhs[1][2])
            && self[2][0].almostEquals(rhs[2][0]) && self[2][1].almostEquals(rhs[2][1])
            && self[2][2].almostEquals(rhs[2][2])
    }
}
