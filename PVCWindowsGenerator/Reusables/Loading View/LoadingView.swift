//
//  LoadingView.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 12.04.2023.
//

import SwiftUI

struct LoadingView: View {

    let rotationTime: Double = 0.75
    let animationTime: Double = 1.9
    let fullRotation: Angle = .degrees(360)
    var side: CGFloat = 50
    
    static let initialDegree: Angle = .degrees(270)

    @State private var spinnerStart: CGFloat = 0.0
    @State private var spinnerEndS1: CGFloat = 0.03
    @State private var spinnerEndS2S3: CGFloat = 0.03

    @State private var rotationDegreeS1 = initialDegree
    @State private var rotationDegreeS2 = initialDegree
    @State private var rotationDegreeS3 = initialDegree

    var body: some View {
        ZStack {
            SpinnerCircle(
                start: spinnerStart,
                end: spinnerEndS2S3,
                rotation: rotationDegreeS3,
                color: .lightC34246,
                lineWidth: max(side / 10, 5)
            )

            SpinnerCircle(
                start: spinnerStart,
                end: spinnerEndS2S3,
                rotation: rotationDegreeS2,
                color: .lightEC8C34,
                lineWidth: max(side / 10, 5)
            )

            SpinnerCircle(
                start: spinnerStart,
                end: spinnerEndS1,
                rotation: rotationDegreeS1,
                color: .light438BF6,
                lineWidth: max(side / 10, 5)
            )
        }
        .frame(width: side, height: side)
        .onAppear() {
            animateSpinner()
            
            Timer.scheduledTimer(
                withTimeInterval: animationTime,
                repeats: true
            ) { _ in
                animateSpinner()
            }
        }
    }

    // MARK: Animation methods
    func animateSpinner(
        with duration: Double,
        completion: @escaping VoidCallback
    ) {
        Timer.scheduledTimer(
            withTimeInterval: duration,
            repeats: false
        ) { _ in
            withAnimation(.easeInOut(duration: self.rotationTime)) {
                completion()
            }
        }
    }

    func animateSpinner() {
        animateSpinner(with: rotationTime) {
            self.spinnerEndS1 = 1.0
        }

        animateSpinner(with: (rotationTime * 2) - 0.025) {
            self.rotationDegreeS1 += fullRotation
            self.spinnerEndS2S3 = 0.8
        }

        animateSpinner(with: (rotationTime * 2)) {
            self.spinnerEndS1 = 0.03
            self.spinnerEndS2S3 = 0.03
        }

        animateSpinner(with: (rotationTime * 2) + 0.0525) { self.rotationDegreeS2 += fullRotation }

        animateSpinner(with: (rotationTime * 2) + 0.225) { self.rotationDegreeS3 += fullRotation }
    }
}

// MARK: SpinnerCircle
struct SpinnerCircle: View {
    var start: CGFloat
    var end: CGFloat
    var rotation: Angle
    var color: Color
    var lineWidth: CGFloat

    var body: some View {
        Circle()
            .trim(from: start, to: end)
            .stroke(
                style: StrokeStyle(
                    lineWidth: lineWidth,
                    lineCap: .round
                )
            )
            .fill(color)
            .rotationEffect(rotation)
    }
}

struct Spinner_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LoadingView()
        }
    }
}
