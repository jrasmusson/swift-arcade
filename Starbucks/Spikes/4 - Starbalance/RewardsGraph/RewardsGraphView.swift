//
//  GraphView.swift
//  Graph
//
//  Created by Jonathan Rasmusson Work Pro on 2020-06-26.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

/*
 Because we don't know the exact size of our device initally, we create
 a call back to let view controllers know once our initial graph has been rendered.
 
 They can they tell us the exact width of the device, so we can they make the
 sure we have the sizes layed out correctly.
 */

class RewardsGraphView: UIView {
    
    let imageView = UIImageView()
    
    let initialFrameWidth: CGFloat = 200 // arbitrary width
    var actualFrameWidth: CGFloat?
    
    let height: CGFloat = 80
        
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    
        actualFrameWidth = frame.width
        
//        drawRewardsGraph()
    }
    
    func layout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
//        drawRectangle()
//        drawRectangle2()
//        drawCircle()
//        drawRotatedSquare()
//        drawLines()
        drawImagesAndText()
//        drawRewardsGraph()
        
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: height)
    }
    
    func drawRewardsGraph() {
        
        let frameWidth: CGFloat = actualFrameWidth ?? initialFrameWidth
        
        let padding: CGFloat = 20
        let dotSize: CGFloat = 12
        let lineWidth: CGFloat = 2
        let numberOfDots: CGFloat = 5
        let numberofSections = numberOfDots - 1
        
        let spacingBetweenDots = (frameWidth - 2 * padding) / (numberofSections + 0.5)
        
        let shortSegmentLength = spacingBetweenDots * 0.25
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: frameWidth, height: height))
        
        var dots: [CGPoint] = []
        let labels: [String] = ["25", "50", "150", "250", "400"]
        
        // Because Core Graphics straddles its frame when it draws, and we want a circle
        // exactly at this point, we need to offset by this amount in the y. The indicatorOffset
        // is just to push everything down enough to make room for the green indicator.
        let indicatorOffset: CGFloat = 34
        let yOffset = (dotSize + lineWidth) / 2 + indicatorOffset
        
        let img = renderer.image { ctx in
            
            // Define our dots
            for index in 0...Int((numberOfDots - 1)) {
                let x = padding + shortSegmentLength + (spacingBetweenDots * CGFloat(index))
                dots.append(CGPoint(x: x, y: yOffset))
            }
            
            // Define our lines between dots
            ctx.cgContext.setLineWidth(lineWidth)
            ctx.cgContext.setStrokeColor(UIColor.systemGray4.cgColor)
            
            // Draw starting segment
            let firstShortSegmentBegin = padding
            let firstShortSegmentEnd = padding + shortSegmentLength - dotSize/2
            
            ctx.cgContext.move(to: CGPoint(x: firstShortSegmentBegin, y: yOffset))
            ctx.cgContext.addLine(to: CGPoint(x: firstShortSegmentEnd, y: yOffset))
            ctx.cgContext.strokePath()
            
            // Draw ending segment
            let lastShortSegmentEnd = frameWidth - padding
            let lastShortSegmentBegin = lastShortSegmentEnd - shortSegmentLength
            
            ctx.cgContext.move(to: CGPoint(x: lastShortSegmentBegin, y: yOffset))
            ctx.cgContext.addLine(to: CGPoint(x: lastShortSegmentEnd, y: yOffset))
            ctx.cgContext.strokePath()
            
            ctx.cgContext.addLines(between: dots)
            ctx.cgContext.strokePath()
            
            ctx.cgContext.setFillColor(UIColor.white.cgColor)
            
            // Draw our dots
            for dot in dots {
                let dotBounds = CGRect(x: dot.x - (dotSize * 0.5),
                                       y: dot.y - (dotSize * 0.5),
                                       width: dotSize,
                                       height: dotSize)
                
                ctx.cgContext.addEllipse(in: dotBounds)
                ctx.cgContext.drawPath(using: CGPathDrawingMode.fillStroke)
            }
            
            // Draw points consumed
            let pointsConsumedBegin = firstShortSegmentBegin
            let pointsConsumedEnd = padding + shortSegmentLength / 2
            
            ctx.cgContext.setStrokeColor(UIColor.starYellow.cgColor)
            
            ctx.cgContext.move(to: CGPoint(x: pointsConsumedBegin, y: yOffset))
            ctx.cgContext.addLine(to: CGPoint(x: pointsConsumedEnd, y: yOffset))
            ctx.cgContext.strokePath()
            
            // Draw green indicator
            let indicatorX = pointsConsumedEnd - 8
            let indicatorY = yOffset - 36
            let star = UIImage(named: "green-indicator")
            
            star?.draw(at: CGPoint(x: indicatorX, y: indicatorY))
            
            // Draw our labels
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.preferredFont(forTextStyle: .footnote),
                .paragraphStyle: paragraphStyle
            ]
            
            for (i, dot) in dots.enumerated() {
                
                let string = labels[i]
                
                let attributedString = NSAttributedString(string: string, attributes: attrs)
                attributedString.draw(with: CGRect(x: dot.x - 15, y: dot.y + 16, width: 30, height: 20), options: .usesLineFragmentOrigin, context: nil)
            }
            
        }
        
        imageView.image = img
    }

    func drawDotsAndLines() {
    
        let labels = ["25", "50", "150", "250", "400"]
        var dots: [CGPoint] = []
        
        let offset: CGFloat = 10
        let spacingBetweenDots: CGFloat = 50
        let dotSize: CGFloat = 12
        let lineWidth: CGFloat = 2
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 256, height: 256))
        
        let img = renderer.image { ctx in
                
            // Define our dots
            for (index, _) in labels.enumerated() {
                let x = offset + (spacingBetweenDots * CGFloat(index))
                dots.append(CGPoint(x: x, y: (dotSize / 2 + lineWidth / 2)))
            }
            
            // Draw our lines
            ctx.cgContext.setLineWidth(lineWidth)
            ctx.cgContext.setStrokeColor(UIColor.systemGray4.cgColor)
            ctx.cgContext.addLines(between: dots)
            ctx.cgContext.strokePath()

            // Draw our dots
            ctx.cgContext.setFillColor(UIColor.clear.cgColor)
            
            for dot in dots {
                let dotBounds = CGRect(x: dot.x - (dotSize * 0.5),
                                       y: dot.y - (dotSize * 0.5),
                                       width: dotSize,
                                       height: dotSize)
                
                ctx.cgContext.addEllipse(in: dotBounds)
                ctx.cgContext.drawPath(using: CGPathDrawingMode.fillStroke)
            }
            
        }
    
        imageView.image = img
    }
    
    func drawRectangle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 300, height: 300))
        
        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 300, height: 300)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.green.cgColor)
            ctx.cgContext.setLineWidth(10)

            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
    
        imageView.image = img
    }

    func drawRectangle2() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 300, height: 300))
        
        let img = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.fill(CGRect(x: 0, y: 0, width: 300, height: 300))
        }
    
        imageView.image = img
    }

    
    // circles get clipped because lines are drawn directly along the edge of the rectangle
    // you can fix by either bringing the cicle in a bit:
    //  let rectangle = CGRect(x: 5, y: 5, width: 290, height: 290) or you can use inset by api
    
    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 300, height: 300))
        
        let img = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.green.cgColor)
            ctx.cgContext.setLineWidth(10)

            let rectangle = CGRect(x: 0, y: 0, width: 300, height: 300).inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
    
        imageView.image = img
    }
    
    /*
     Because Core Graphics rotates around the origin in the upper left (0,0), we move our center
     to the middle of the square so we can rotate about the middle.
     */
    func drawRotatedSquare() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 256, height: 256))
        
        let img = renderer.image { ctx in
            
            // move to center
            ctx.cgContext.translateBy(x: 128, y: 128)
            let rotations = 16
            let amount = Double.pi / Double(rotations)
            
            // add 16 rotated rectangles
            for _ in 0 ..< rotations {
                ctx.cgContext.rotate(by: CGFloat(amount))
                // move to center of square
                ctx.cgContext.addRect(CGRect(x: -64, y: -64, width: 128, height: 128))
            }
            
            ctx.cgContext.setStrokeColor(UIColor.systemRed.cgColor)
            ctx.cgContext.strokePath()
        }
    
        imageView.image = img
    }
    
    func drawLines() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 256, height: 256))
        
        let img = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 128, y: 128)
            
            var first = true
            var length: CGFloat = 128
            
            for _ in 0 ..< 128 {
                ctx.cgContext.rotate(by: .pi / 2)
                if first {
                    ctx.cgContext.move(to: CGPoint(x: length, y: 25))
                    first = false
                } else {
                    ctx.cgContext.addLine(to: CGPoint(x: length, y: 25))
                }
                
                length *= 0.99
            }
            
            ctx.cgContext.setStrokeColor(UIColor.systemRed.cgColor)
            ctx.cgContext.strokePath()
        }
    
        imageView.image = img
    }

    func drawImagesAndText() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 256, height: 256))
        
        let img = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.preferredFont(forTextStyle: .title1),
                .paragraphStyle: paragraphStyle
            ]
            
            let string = "The best laid schemes of mice and men"
            
            let attributedString = NSAttributedString(string: string, attributes: attrs)
            attributedString.draw(with: CGRect(x: 32, y: 32, width: 200, height: 200), options: .usesLineFragmentOrigin, context: nil)
            
            let star = UIImage(named: "star")
            star?.draw(at: CGPoint(x: 124, y: 150))
        }
        
        imageView.image = img
    }
}

extension UIColor {
    static let starYellow = UIColor(red: 204/255, green: 153/255, blue: 51/255, alpha: 1)
}
