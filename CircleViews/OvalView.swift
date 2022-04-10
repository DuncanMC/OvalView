//
//  OvalView.swift
//  CircleViews
//
//  Created by Duncan Champney on 4/10/22.
//
/*  Copyright © 2022 Duncan Champney.
    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */



import UIKit


/// This class simply fills it's bounds with a rounded rectangle. As the view's bounds change, it updates itself so the path fills the bounds.
/// When the layer's bounds change, it updates the path in the shape layer to contain a rounded rectangle who's corner radius is 1/2 the shorter dimension of the view's bounds. If the view's bounds are a square, the shape will be a circle. If the view's bounds are rectangular, the shape will be a "lozenge"
class OvalView: UIView {

    /// A computed property that casts the view's backing layer to type CAShapeLayer for convenience.
    var shapeLayer: CAShapeLayer { return self.layer as! CAShapeLayer }

    /// This is the color used to draw the oval. If you change it, the didSet will change the layer's strokeColor
    public var ovalColor: UIColor = .blue{
        didSet {
            guard let layer = self.layer as? CAShapeLayer else { return }
            layer.strokeColor = ovalColor.cgColor
        }
    }

    /// This declaration causes the  OvalView's backing layer to be a CAShapeLayer
    override class var layerClass : AnyClass {
       return CAShapeLayer.self}

    /// If the view's bounds change, update our layer's path
    override var bounds: CGRect {
        didSet {
            createPath()
        }
    }

    /// When we get added to a view, set up our shape layer's properties.
    override func didMoveToSuperview() {
        shapeLayer.strokeColor = ovalColor.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 1
    }

    /// Build the path for our shape layer and install it.
    func createPath() {
        let cornerRaidus = min(bounds.height, bounds.width)
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRaidus)
        shapeLayer.path = path.cgPath
    }
}
