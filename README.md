# DrawerController

A container view controller that supports main view controller in the center and drawers around it.

## Installation

### Swift Package Manager
Add DrawerController as a dependency of your project in Package.swift file:

```
dependencies: [
  .package(url: "https://github.com/rozd/DrawerController.git", .branch("master"))
]
```

## Interface Builder Integration

Embed root and bottom view controllers using custom segues:

<img src="https://user-images.githubusercontent.com/158493/77850070-badad680-71d8-11ea-93d0-d695e9aa7901.png" width="440" />

## Usage

Register drawers in the code:

```swift
let drawers = DrawerController()
drawers.rootViewController = mainController
drawers.bottomViewController = bottomController
```

To open bottom drawer programmatically call the `openBottomViewController(animated:)` method:

```swift
@IBAction func openBottomDrawerButtonTapped(_ sender: Any) {
    self.drawerController?.openBottomViewController(animated: true)
}
```

