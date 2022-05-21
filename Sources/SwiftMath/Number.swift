public func almostEquals<T: FloatingPoint>(
    _ a: T, _ b: T, _ smallEpsilon: T, _ largeEpsilon: T
) -> Bool {
    let diff = (a - b).magnitude
    if a == b {
        return true
    } else if diff < 1 {
        return diff < smallEpsilon
    } else {
        return diff < largeEpsilon
    }
}

extension Float {
    public func almostEquals(_ rhs: Self) -> Bool {
        return SwiftMath.almostEquals(self, rhs, 1e-3, 0.1)
    }
}

extension Double {
    public func almostEquals(_ rhs: Double) -> Bool {
        return SwiftMath.almostEquals(self, rhs, 1e-6, 0.1)
    }
}
