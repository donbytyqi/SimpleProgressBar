# SimpleProgressBar
A very simple progress bar for iOS.

<img width="50%" height="50%" src="https://i.imgur.com/PzKv6MO.png">

## Installation
Currently, the only way to install it is manually. Simply download SimpleProgressBar.swift file and drag and drop it to your project folder.

## Usage
SimpleProgressBar is fairly easy to implement, simply initiliaze it with a frame or use the custom initializer provided.

```swift
let progressBar = SimpleProgressBar(progressColor: .red, borderColor: .clear, borderWidth: 1.5)
progressBar.frame = CGRect(x: 256, y: 256, width: 250, height: 40)
progressBar.progress = 0.5
view.addSubview(progressBar)

// Gradient
progressBar.gradient = [UIColor.red, UIColor.black]
progressBar.gradientAngle = .topRightBottomLeft

// Rounded corners
progressBar.roundedCorners = true



