//
//  ContentView.swift
//  DragStarAnimation
//
//  Created by Shreyas Vilaschandra Bhike on 20/05/21.
//  The App Wizard
//  Instagram : theappwizard2408

import SwiftUI


struct ContentView: View {
    var body: some View {
        StarView()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}






































struct StarView: View {
    
    @State private var move = 300
   
    
    @State private var position = CGPoint(x : 0 , y : 0)
    

    var body: some View {
        
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
                    
           ZStack{
                
                
                Star(corners: 5, smoothness: 0.45)
                           .fill(Color.gray)
                           .frame(width: 45, height: 45)
                           .animation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: true).delay(0.8))

                    
                Star(corners: 5, smoothness: 0.45)
                               .fill(Color.green)
                               .frame(width: 50, height: 50)
                                .animation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: true).delay(0.7))

//
                Star(corners: 5, smoothness: 0.45)
                                   .fill(Color.blue)
                                   .frame(width: 52, height: 52)
                                   .animation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: true).delay(0.6))

                    
                Star(corners: 5, smoothness: 0.45)
                                   .fill(Color.purple)
                                   .frame(width: 55, height: 55)
                                    .animation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: true).delay(0.5))

                
                Star(corners: 5, smoothness: 0.45)
                                   .fill(Color.yellow)
                                   .frame(width: 60, height: 60)
                                    .animation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: true).delay(0.4))

                
                
                Star(corners: 5, smoothness: 0.45)
                                   .fill(Color.orange)
                                   .frame(width: 63, height: 63)
                                    .animation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: true).delay(0.3))

                
                Star(corners: 5, smoothness: 0.45)
                                   .fill(Color.pink)
                                   .frame(width: 65, height: 65)
                                    .animation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: true).delay(0.2))

                Star(corners: 5, smoothness: 0.45)
                                   .fill(Color.red)
                                   .frame(width: 68, height: 68)
                    .animation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: true).delay(0.1))

                
                Star(corners: 5, smoothness: 0.45)
                                   .fill(Color.white)
                                   .frame(width: 70, height: 70)
                                    .animation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: true))

           }
//           .shadow(color: .blue.opacity(0.5), radius: 10, x: 0.0, y: 0.0)
           .position(x : self.position.x ,y: self.position.y)
           .gesture(DragGesture()
                        .onChanged({ value in
                            self.position.x = value.location.x
                            self.position.y = value.location.y
                        })
            
           )
            
        }
                   
    }
}




//Star Shape Code
//Learnt From Hacking With SwiftUI
//https://www.hackingwithswift.com/quick-start/swiftui/how-to-draw-polygons-and-stars

struct Star: Shape {
    // store how many corners the star has, and how smooth/pointed it is
    let corners: Int
    let smoothness: CGFloat

    func path(in rect: CGRect) -> Path {
        // ensure we have at least two corners, otherwise send back an empty path
        guard corners >= 2 else { return Path() }

        // draw from the center of our rectangle
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)

        // start from directly upwards (as opposed to down or to the right)
        var currentAngle = -CGFloat.pi / 2

        // calculate how much we need to move with each star corner
        let angleAdjustment = .pi * 2 / CGFloat(corners * 2)

        // figure out how much we need to move X/Y for the inner points of the star
        let innerX = center.x * smoothness
        let innerY = center.y * smoothness

        // we're ready to start with our path now
        var path = Path()

        // move to our initial position
        path.move(to: CGPoint(x: center.x * cos(currentAngle), y: center.y * sin(currentAngle)))

        // track the lowest point we draw to, so we can center later
        var bottomEdge: CGFloat = 0

        // loop over all our points/inner points
        for corner in 0..<corners * 2  {
            // figure out the location of this point
            let sinAngle = sin(currentAngle)
            let cosAngle = cos(currentAngle)
            let bottom: CGFloat

            // if we're a multiple of 2 we are drawing the outer edge of the star
            if corner.isMultiple(of: 2) {
                // store this Y position
                bottom = center.y * sinAngle

                // …and add a line to there
                path.addLine(to: CGPoint(x: center.x * cosAngle, y: bottom))
            } else {
                // we're not a multiple of 2, which means we're drawing an inner point

                // store this Y position
                bottom = innerY * sinAngle

                // …and add a line to there
                path.addLine(to: CGPoint(x: innerX * cosAngle, y: bottom))
            }

            // if this new bottom point is our lowest, stash it away for later
            if bottom > bottomEdge {
                bottomEdge = bottom
            }

            // move on to the next corner
            currentAngle += angleAdjustment
        }

        // figure out how much unused space we have at the bottom of our drawing rectangle
        let unusedSpace = (rect.height / 2 - bottomEdge) / 2

        // create and apply a transform that moves our path down by that amount, centering the shape vertically
        let transform = CGAffineTransform(translationX: center.x, y: center.y + unusedSpace)
        return path.applying(transform)
    }
}
