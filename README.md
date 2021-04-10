
# CompositionalLayoutSpreadsheet

[![License](https://img.shields.io/cocoapods/l/SwiftSpreadsheet.svg?style=flat)](http://cocoapods.org/pods/SwiftSpreadsheet)
[![Platform](https://img.shields.io/cocoapods/p/SwiftSpreadsheet.svg?style=flat)](http://cocoapods.org/pods/SwiftSpreadsheet)
<a href="https://github.com/apple/swift-package-manager"><img alt="Swift Package Manager compatible" src="https://img.shields.io/badge/SPM-%E2%9C%93-brightgreen.svg?style=flat"/></a>

## Example

To run the example project, clone the repo, and run `CompositionalLayoutSpreadsheetExample.xcodeproj` from the example directory.

## Requirements

iOS 13.0 +
Swift 5.0 +

## SPM Installation

CompositionalLayoutSpreadsheet is available through Swift Package Manager. To install
it, simply add the following line to your Podfile:

```swift
dependencies: [
    .package(url: "https://github.com/ericleiyang/CompositionalLayoutSpreadsheet.git", .upToNextMajor(from: "1.0.0"))
]
```
## Demo

![Output sample](https://github.com/ericleiyang/CompositionalLayoutSpreadsheet/blob/main/Apr-05-2021%2016-03-41.gif)

## Features

- [x] Spreadsheet like collection view
- [x] Compositional collection view layout
- [x] Sticky column at the left
- [x] iPhone screen sizes supported
- [x] iPad screen sizes supported
- [x] Device rotation supported
- [x] Custom sticky size width supported
- [x] Custom value cell size supported
- [x] Custom sticky cell font/color supported
- [x] Custom value cell supported
- [ ] Sticky row as the header
- [ ] Multiple sticky columns at the left
- [ ] Multiple sticky rows as the header
- [ ] Various row sizes supported
- [ ] Various column sizes supported

## Quick start

A short introduction on how to get started:

- The sticky column is represented as `ReusableSupplementaryView`.
- The values are represented as one `NSCollectionLayoutSection` with multiple `NSCollectionLayoutGroup`.
- Default cell is the `ValueCell` with one label displayed. It can be replaced by custom  `UICollectionViewCell` when calling `configureHierarchy` of the `CompositionalLayoutSpreadsheet`.

A short example:

```swift
//Init
let provider = CompositionalLayoutSpreadsheet()

// Use default ValueCell
provider.configureHierarchy(
    stikyColumnDatas: stikyColumnDatas,
    rowDatas: rowDatas,
    parentView: view
)
```

To use the custom cell:

```swift
//Init
let provider = CompositionalLayoutSpreadsheet()

// Use default ValueCell
provider.configureHierarchy(
    stikyColumnDatas: stikyColumnDatas,
    rowDatas: rowDatas,
    cell: YOUR CELL,
    cellReuseIdentifier: The reuse identifier of YOUR CELL
)
```


Reload after data updated:
```swift
provider.update(
    stikyColumnDatas: UPDATED COLUMN DATA,
    rowDatas: UPDATED VALUES
)
```

 Enjoy ;)

## Questions

Please refer to the demo application or contact me directly.

## Author

Eric Yang
 
## License

CompositionalLayoutSpreadsheet is available under the MIT license. See the LICENSE file for more info.
