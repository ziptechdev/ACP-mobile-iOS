//
//  ACPCircleLoadingBarView.swift
//  ACP-mobile
//
//  Created by Adi on 04/10/2022.
//

import UIKit

class ACPCircleLoadingBarView: UIView {

	// MARK: - Properties

    private var startPoint: CGFloat = -Double.pi / 2
    private var endPoint: CGFloat = 3 * Double.pi / 2

    /// Time it takes to complete the circle
    var timeInterval: CGFloat = 10

    /// Set to change the width of the progress bar
    var lineWidth: CGFloat = Constants.Constraints.DefaultLineWidth

    /// Color of the loading bar
    var progressColor: UIColor = .coreBlue

    /// Color of the loading bar background
    var barColor: UIColor = .gray06Light

    // MARK: - Views

    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func layoutSubviews() {
        super.layoutSubviews()

        let path = UIBezierPath(
            arcCenter: CGPoint(
                x: frame.size.width / 2,
                y: frame.size.height / 2
            ),
            radius: frame.width / 2,
            startAngle: startPoint,
            endAngle: endPoint,
            clockwise: true
        )

        circleLayer.path = path.cgPath

        progressLayer.path = path.cgPath

        progressAnimation()
    }

    // MARK: - UI

    private func setupUI() {
        addSubviews()
        setupLayers()
    }

    private func addSubviews() {
        layer.addSublayer(circleLayer)
        layer.addSublayer(progressLayer)
    }

    private func setupLayers() {
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = barColor.cgColor
        circleLayer.lineWidth = lineWidth

        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.strokeEnd = 0
        progressLayer.lineCap = .round
        progressLayer.lineWidth = lineWidth
    }

    // MARK: - Animation

    func progressAnimation() {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = timeInterval
        circularProgressAnimation.toValue = 1.0
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let DefaultLineWidth: CGFloat = 7
        }
    }
}
