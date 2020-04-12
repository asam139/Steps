<p align="center">
  <img src="https://raw.githubusercontent.com/asam139/Steps/master/Assets/logo.png" title="steps" width="300">
</p>

[![Build Status](https://github.com/asam139/Steps/workflows/Steps/badge.svg?branch=master)](https://github.com/asam139/Steps/actions)
[![Platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20tvOS%20%7C%20macOS%20%7C%20watchOS%20%7C%20Linux-lightgrey.svg)](https://github.com/SwifterSwift/swifterSwift)
[![Cocoapods](https://img.shields.io/cocoapods/v/SwifterSwift.svg)](https://cocoapods.org/pods/SwifterSwift)
[![SPM compatible](https://img.shields.io/badge/SPM-Compatible-brightgreen.svg?style=flat)](https://swift.org/package-manager/)
[![codecov](https://codecov.io/gh/asam139/Steps/branch/master/graph/badge.svg)](https://codecov.io/gh/asam139/Steps)
[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-11.4-blue.svg)](https://developer.apple.com/xcode)
[![MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)

Steps is a navigation bar that guides users through the steps of a task. You need to use it when a given task is complicated or has a certain sequence in the series of subtasks, we can decompose it into several steps to make things easier.

## Requirements

- **iOS** 10.0+ / **tvOS** 9.0+ / **watchOS** 2.0+ / **macOS** 10.10+ / **Ubuntu** 14.04+
- Swift 5.0+

## Installation

<details>
<summary>CocoaPods</summary>
</br>
<p>To integrate Steps into your Xcode project using <a href="http://cocoapods.org">CocoaPods</a>, specify it in your <code>Podfile</code>:</p>

<pre><code class="ruby language-ruby">pod 'Steps'</code></pre>
</details>

<details>
<summary>Swift Package Manager</summary>
</br>
<p>You can use <a href="https://swift.org/package-manager">The Swift Package Manager</a> to install <code>Steps</code> by adding the proper description to your <code>Package.swift</code> file:</p>

<pre><code class="swift language-swift">import PackageDescription

let package = Package(
    name: "YOUR_PROJECT_NAME",
    targets: [],
    dependencies: [
        .package(url: "https://github.com/asam139/Steps.git", from: "1.0.0")
    ]
)
</code></pre>

<p>Next, add <code>Steps</code> to your targets dependencies like so:</p>
<pre><code class="swift language-swift">.target(
    name: "YOUR_TARGET_NAME",
    dependencies: [
        "Steps",
    ]
),</code></pre>
<p>Then run <code>swift package update</code>.</p>
</details>



<details>
<summary>Manually</summary>
</br>
<p>Add the Steps project to your Xcode project</p>
</details>

## Example


## Get involved

We want your feedback.
Please refer to [contributing guidelines](https://github.com/SwifterSwift/SwifterSwift/tree/master/CONTRIBUTING.md) before participating.

## Thanks

Special thanks to:

- Hoping new contributors

## License

Steps is released under the MIT license. See [LICENSE](https://github.com/asam139/Steps/blob/master/LICENSE) for more information.
