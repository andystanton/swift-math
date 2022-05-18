public func almostEquals<T: BinaryFloatingPoint>(_ a: T, _ b: T, _ smallEpsilon: T, _ largeEpsilon: T) -> Bool {
    let diff = (a - b).magnitude
    if (a == b) {
        return true
    } else if (diff < 1.0) {
        return diff < smallEpsilon
    } else {
        return diff < largeEpsilon;
    }
}

public extension Float {
    func almostEquals(_ rhs: Self) -> Bool {
        return Swift_Math.almostEquals(self, rhs, 1e-3, 0.1)
    }
}

public extension Double {
    func almostEquals(_ rhs: Double) -> Bool {
        return Swift_Math.almostEquals(self, rhs, 1e-6, 0.1)
    }
}
