# OIKit

[![Version](https://img.shields.io/cocoapods/v/OIKit.svg?style=flat)](https://cocoapods.org/pods/OIKit)
[![License](https://img.shields.io/cocoapods/l/OIKit.svg?style=flat)](https://cocoapods.org/pods/OIKit)
[![Platform](https://img.shields.io/cocoapods/p/OIKit.svg?style=flat)](https://cocoapods.org/pods/OIKit)

OIKit is a Swift library for easy and efficient handling of UI tasks in UIKit. It is designed to simplify the process of building user interfaces by providing a clear and concise API with chaining methods similar to SwiftUI, making it intuitive and easy to understand.

## Features

- **Chaining Methods**: Construct complex UI components with simple and readable chaining syntax, reducing the boilerplate code significantly.
- **Flexibility and Power**: Combines the power of UIKit with the simplicity of SwiftUI-like syntax, providing the best of both worlds.
- **Comprehensive Components**: A wide range of pre-built components and utilities to accelerate development.
- **Modern Swift**: Built with modern Swift features and best practices, ensuring your code is future-proof and easy to maintain.

## Requirements

- iOS 10.0+
- Xcode 11.0+
- Swift 5.0+

## Installation

### CocoaPods

CocoaPods is a dependency manager for Cocoa projects. To integrate `OIKit` into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'OIKit'
```

## import OIKit
```ruby
import OIKit
```

### Sample Code
```ruby
import OIKit

class ViewController: UIViewController {

    @SBinding var name: String = "John Doe"
    @SBinding var email: String = "email@gmail.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.VStack(spacing: 10) {
            TextField()
                .text($name)
                .padding(8)
                .background(.systemGray6)
                .cornerRadius(8)
                .height(30)

            TextField()
                .text($email)
                .padding(8)
                .background(.systemGray6)
                .cornerRadius(8)
                .height(30)
            
            Button().content {
                
            } setup: { button in
                button
                    .title("Log in")
                    .font(size: 20, weight: .semibold)
                    .height(40)
                    .background(.systemBlue)
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }
            
            Spacer()
        }
        .padding()
        .background(.white)
    }
}
```
