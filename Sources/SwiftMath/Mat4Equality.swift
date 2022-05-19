public extension Mat4 {
    static func ==(lhs: Mat4<T>, rhs: Mat4<T>) -> Bool {
        return lhs[0][0] == rhs[0][0] && lhs[0][1] == rhs[0][1] && lhs[0][2] == rhs[0][2] && lhs[0][3] == rhs[0][3] 
        && lhs[1][0] == rhs[1][0] && lhs[1][1] == rhs[1][1] && lhs[1][2] == rhs[1][2] && lhs[1][3] == rhs[1][3]
        && lhs[2][0] == rhs[2][0] && lhs[2][1] == rhs[2][1] && lhs[2][2] == rhs[2][2] && lhs[2][3] == rhs[2][3]
        && lhs[3][0] == rhs[3][0] && lhs[3][1] == rhs[3][1] && lhs[3][2] == rhs[3][2] && lhs[3][3] == rhs[3][3]
    }
    
    static func ~=(lhs: Mat4<T>, rhs: Mat4<T>) -> Bool where T == Double {
        return lhs[0][0].almostEquals(rhs[0][0]) && lhs[0][1].almostEquals(rhs[0][1]) && lhs[0][2].almostEquals(rhs[0][2]) && lhs[0][3].almostEquals(rhs[0][3])
        && lhs[1][0].almostEquals(rhs[1][0]) && lhs[1][1].almostEquals(rhs[1][1]) && lhs[1][2].almostEquals(rhs[1][2]) && lhs[1][3].almostEquals(rhs[1][3])
        && lhs[2][0].almostEquals(rhs[2][0]) && lhs[2][1].almostEquals(rhs[2][1]) && lhs[2][2].almostEquals(rhs[2][2]) && lhs[2][3].almostEquals(rhs[2][3])
        && lhs[3][0].almostEquals(rhs[3][0]) && lhs[3][1].almostEquals(rhs[3][1]) && lhs[3][2].almostEquals(rhs[3][2]) && lhs[3][3].almostEquals(rhs[3][3])
    }
    
    static func ~=(lhs: Mat4<T>, rhs: Mat4<T>) -> Bool where T == Float{
        return lhs[0][0].almostEquals(rhs[0][0]) && lhs[0][1].almostEquals(rhs[0][1]) && lhs[0][2].almostEquals(rhs[0][2]) && lhs[0][3].almostEquals(rhs[0][3])
        && lhs[1][0].almostEquals(rhs[1][0]) && lhs[1][1].almostEquals(rhs[1][1]) && lhs[1][2].almostEquals(rhs[1][2]) && lhs[1][3].almostEquals(rhs[1][3])
        && lhs[2][0].almostEquals(rhs[2][0]) && lhs[2][1].almostEquals(rhs[2][1]) && lhs[2][2].almostEquals(rhs[2][2]) && lhs[2][3].almostEquals(rhs[2][3])
        && lhs[3][0].almostEquals(rhs[3][0]) && lhs[3][1].almostEquals(rhs[3][1]) && lhs[3][2].almostEquals(rhs[3][2]) && lhs[3][3].almostEquals(rhs[3][3])
    }
}

