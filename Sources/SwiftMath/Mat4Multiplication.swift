// extension Mat4 {
//     public static func * (lhs: Mat4<T>, rhs: Vec4<T>) -> Vec4<T> {
//         return Vec4<T>(
//             lhs[0][0] * rhs.x + lhs[1][0] * rhs.y + lhs[2][0] * rhs.z + lhs[3][0] * rhs.w,
//             lhs[0][1] * rhs.x + lhs[1][1] * rhs.y + lhs[2][1] * rhs.z + lhs[3][1] * rhs.w,
//             lhs[0][2] * rhs.x + lhs[1][2] * rhs.y + lhs[2][2] * rhs.z + lhs[3][2] * rhs.w,
//             lhs[0][3] * rhs.x + lhs[1][3] * rhs.y + lhs[2][3] * rhs.z + lhs[3][3] * rhs.w)
//     }

//     public static func * (lhs: Mat4<T>, rhs: Mat4<T>) -> Mat4<T> {
//         assert(lhs[0].count == 4)
//         assert(lhs[1].count == 4)
//         assert(lhs[2].count == 4)
//         assert(lhs[3].count == 4)
//         let col1: [T] =
//             [
//                 lhs.data[0][0] * rhs.data[0][0] + lhs.data[0][1] * rhs.data[1][0] + lhs.data[0][2]
//                     * rhs.data[2][0] + lhs.data[0][3] * rhs.data[3][0],
//                 lhs.data[0][0] * rhs.data[0][1] + lhs.data[0][1] * rhs.data[1][1] + lhs.data[0][2]
//                     * rhs.data[2][1] + lhs.data[0][3] * rhs.data[3][1],
//                 lhs.data[0][0] * rhs.data[0][2] + lhs.data[0][1] * rhs.data[1][2] + lhs.data[0][2]
//                     * rhs.data[2][2] + lhs.data[0][3] * rhs.data[3][2],
//                 lhs.data[0][0] * rhs.data[0][3] + lhs.data[0][1] * rhs.data[1][3] + lhs.data[0][2]
//                     * rhs.data[2][3] + lhs.data[0][3] * rhs.data[3][3],
//             ]
//         let col2: [T] =
//             [
//                 lhs.data[1][0] * rhs.data[0][0] + lhs.data[1][1] * rhs.data[1][0] + lhs.data[1][2]
//                     * rhs.data[2][0] + lhs.data[1][3] * rhs.data[3][0],
//                 lhs.data[1][0] * rhs.data[0][1] + lhs.data[1][1] * rhs.data[1][1] + lhs.data[1][2]
//                     * rhs.data[2][1] + lhs.data[1][3] * rhs.data[3][1],
//                 lhs.data[1][0] * rhs.data[0][2] + lhs.data[1][1] * rhs.data[1][2] + lhs.data[1][2]
//                     * rhs.data[2][2] + lhs.data[1][3] * rhs.data[3][2],
//                 lhs.data[1][0] * rhs.data[0][3] + lhs.data[1][1] * rhs.data[1][3] + lhs.data[1][2]
//                     * rhs.data[2][3] + lhs.data[1][3] * rhs.data[3][3],
//             ]
//         let col3: [T] =
//             [
//                 lhs.data[2][0] * rhs.data[0][0] + lhs.data[2][1] * rhs.data[1][0] + lhs.data[2][2]
//                     * rhs.data[2][0] + lhs.data[2][3] * rhs.data[3][0],
//                 lhs.data[2][0] * rhs.data[0][1] + lhs.data[2][1] * rhs.data[1][1] + lhs.data[2][2]
//                     * rhs.data[2][1] + lhs.data[2][3] * rhs.data[3][1],
//                 lhs.data[2][0] * rhs.data[0][2] + lhs.data[2][1] * rhs.data[1][2] + lhs.data[2][2]
//                     * rhs.data[2][2] + lhs.data[2][3] * rhs.data[3][2],
//                 lhs.data[2][0] * rhs.data[0][3] + lhs.data[2][1] * rhs.data[1][3] + lhs.data[2][2]
//                     * rhs.data[2][3] + lhs.data[2][3] * rhs.data[3][3],
//             ]
//         let col4: [T] =
//             [
//                 lhs.data[3][0] * rhs.data[0][0] + lhs.data[3][1] * rhs.data[1][0] + lhs.data[3][2]
//                     * rhs.data[2][0] + lhs.data[3][3] * rhs.data[3][0],
//                 lhs.data[3][0] * rhs.data[0][1] + lhs.data[3][1] * rhs.data[1][1] + lhs.data[3][2]
//                     * rhs.data[2][1] + lhs.data[3][3] * rhs.data[3][1],
//                 lhs.data[3][0] * rhs.data[0][2] + lhs.data[3][1] * rhs.data[1][2] + lhs.data[3][2]
//                     * rhs.data[2][2] + lhs.data[3][3] * rhs.data[3][2],
//                 lhs.data[3][0] * rhs.data[0][3] + lhs.data[3][1] * rhs.data[1][3] + lhs.data[3][2]
//                     * rhs.data[2][3] + lhs.data[3][3] * rhs.data[3][3],
//             ]
//         return Mat4<T>(data: [
//             col1, col2, col3, col4,
//         ])
//     }
// }
