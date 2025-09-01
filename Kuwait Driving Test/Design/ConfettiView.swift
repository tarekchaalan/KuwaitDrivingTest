import SwiftUI
import UIKit

/// Burst-only confetti. Configure with just `isPerfect`.
struct ConfettiView: UIViewRepresentable {
    /// If true, slightly denser/longer celebration.
    let isPerfect: Bool

    // MARK: - Internal tuning (all centralized here)

    /// Palette (slightly translucent for softer look)
    private let colors: [UIColor] = [
        UIColor.systemBlue,
        UIColor.systemTeal,
        UIColor.systemGreen,
        UIColor.systemPink,
        UIColor.systemYellow,
        UIColor.systemPurple
    ].map { $0.withAlphaComponent(0.85) }

    /// Derived from `isPerfect`
    private var intensity: CGFloat { isPerfect ? 0.65 : 0.50 }     // 0.2–1.0
    private var duration: TimeInterval { isPerfect ? 2.0 : 1.7 }   // seconds visible

    func makeUIView(context: Context) -> UIView {
        let view = ConfettiHostView()
        view.isUserInteractionEnabled = false

        let emitter = CAEmitterLayer()
        emitter.zPosition = 1000
        emitter.emitterShape = .point
        emitter.emitterMode = .points
        emitter.birthRate = 1 // layer multiplier

        view.layer.addSublayer(emitter)
        view.emitter = emitter

        // Fewer, clean cells to avoid clutter
        emitter.emitterCells = makeCells()

        // Short “pop” ramp so it doesn’t blob at start
        emitter.setValue(1.0, forKey: "birthRate")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) {
            emitter.birthRate = 0
        }

        // Stop + cleanup
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            emitter.birthRate = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration + 2.0) {
            emitter.removeFromSuperlayer()
        }

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // no-op
    }

    // MARK: - Cells (burst)

    private func makeCells() -> [CAEmitterCell] {
        var cells: [CAEmitterCell] = []
        // Two sizes; circle + rounded rect
        let sizes: [CGFloat] = isPerfect ? [5, 8, 10] : [5, 8]

        for color in colors {
            for size in sizes {
                cells.append(makeCell(color: color, size: size, circular: false))
                cells.append(makeCell(color: color, size: size, circular: true))
            }
        }
        return cells
    }

    private func makeCell(color: UIColor, size: CGFloat, circular: Bool) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.contents = coloredImage(color: color, size: CGSize(width: size, height: size), circular: circular).cgImage

        // Per-cell density kept modest to avoid crowding
        cell.birthRate       = Float(6.0 * intensity) // ↑ = more particles at once; ↓ = sparser
        cell.lifetime        = 3.5                    // ↑ = visible longer; ↓ = disappear quicker
        cell.lifetimeRange   = 0.7                    // ↑ = more variance; ↓ = more uniform

        // Pop outward 360°
        cell.velocity        = 200 * intensity        // ↑ = wider burst radius; ↓ = tighter spread
        cell.velocityRange   = 130 * intensity        // ↑ = more random speed spread; ↓ = uniform
        cell.emissionLongitude = 0
        cell.emissionRange   = .pi * 2                // full 360°

        // Fall + slight drift
        cell.yAcceleration   = 170                    // ↑ = fall faster; ↓ = floatier
        cell.xAcceleration   = 0                      // non-zero pushes sideways

        // Spin + fade so particles don’t linger
        cell.spin            = 2.7 * intensity        // ↑ = faster base spin; ↓ = slower
        cell.spinRange       = 4.4 * intensity        // ↑ = more random spin; ↓ = consistent
        cell.alphaSpeed      = -0.25                  // more negative = fade faster

        // Scale
        cell.scale           = isPerfect ? 0.8 : 0.7  // slightly larger for perfect
        cell.scaleRange      = 0.2                    // ↑ = more size variety; ↓ = uniform
        cell.scaleSpeed      = -0.10                  // more negative = shrink faster

        return cell
    }

    // MARK: - Drawing

    private func coloredImage(color: UIColor, size: CGSize, circular: Bool) -> UIImage {
        let rect = CGRect(origin: .zero, size: size)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            color.setFill()
            if circular {
                UIBezierPath(ovalIn: rect).fill()
            } else {
                UIBezierPath(
                    roundedRect: rect,
                    cornerRadius: min(size.width, size.height) * 0.25
                ).fill()
            }
        }
    }
}

/// Keeps the emitter centered as the view lays out.
private final class ConfettiHostView: UIView {
    weak var emitter: CAEmitterLayer?

    override func layoutSubviews() {
        super.layoutSubviews()
        guard let emitter else { return }
        emitter.frame = bounds
        emitter.emitterPosition = CGPoint(x: bounds.midX, y: bounds.minY + 12) // pop near top-center
        emitter.emitterSize = .zero
    }
}
