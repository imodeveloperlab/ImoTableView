![alt text](https://github.com/imodeveloperlab/ImoTableView/blob/master/Logo.png "ImoTableView Logo")

![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)
![Cocoapods Compatible](https://img.shields.io/badge/Cocoapods-compatible-4BC51D.svg?style=flat)
[![Twitter](https://img.shields.io/badge/twitter-@imodeveloper-blue.svg?style=flat)](https://twitter.com/imodeveloper)

ImoTableView is an wrapper around **UITableView** which aims to facilitate working with tables and make work more reusable and more dynamic, make it simple and quick to implement, you don't need to work with standart **UITableView** delegates anymore.

## Requirements

- iOS 8.0+
- Xcode 8.1+
- Swift 3.1+

## Installation

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate Alamofire into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "imodeveloperlab/ImoTableView" ~> 1.0
```

Run `carthage update` to build the framework and drag the built `ImoTableView.framework` into your Xcode project.


### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1.0+ is required to build ImoTableView 1.0.8+.

To integrate Alamofire into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'ImoTableView', '~> 1.0.8'
end
```

Then, run the following command:

```bash
$ pod install
```

## Quick Onboarding 
To start use **ImoTableView** you need to undesrstand the base concept, **ImoTableView** is composed from four classes.

1. **ImoTableView** is an subclass from **UITableView** and have the role to manage with **ImoTableViewSection**'s, add new sections, delete and update them.
2. **ImoTableViewSection** is an class which work with **ImoTableViewSource**'s, add new source, delete, update.
3. **ImoTableViewSource** is base object for your new **CellSource**'s this source contain base info about cell class, cell height, and other aditional proprietes which you want to show in your cell, user name for example. 
4. **ImoTableViewCell** is view representation of properties you have stored in your source.

![alt text](https://github.com/imodeveloperlab/ImoTableView/blob/master/ImoTableView.png "ImoTableView")

## Quick Implementation Example

Example of how quick and simple you can add an populate an tableView
This is how ```swift ViewController.swift ``` looks like
```swift
import UIKit
import ImoTableView

class ViewController: UIViewController {

    //ImoTableView reference from ViewController
    @IBOutlet weak var tableView: ImoTableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Create new section
        let section = ImoTableViewSection()
        //Create new cellSource
        let actionCellSource = ActionCellSource(title: "Action")
        //Add cellSource to section
        section.add(actionCellSource)
        //Add section to table View
        tableView.add(section)
        //Reload table
        tableView.reloadData()
    }
}
```

`ActionCell.swift` Contain an method ```swift open override func setUpWithSource(source:AnyObject)``` and this method is called every time  **ActionCell** will be shown on screen and ```swift source:AnyObject``` is cell source with all properties you need to set up you cell.

```swift
open class ActionCell : ImoTableViewCell {
    //UILabel from ActionCell.xib
    @IBOutlet weak var actionTitle: UILabel!
    //This method is called every time your cell will be displayed on screen
    open override func setUpWithSource(source:AnyObject) {
        //Cast source to ActionCellSource
        if let source = source as? ActionCellSource {
            //Set the label title
            self.actionTitle.text = source.title
        }
    }
}
```
`ActionCellSource.swift` Contain an method ```swift open override func setUpWithSource(source:AnyObject)``` and this method is called every time  **ActionCell** will be shown on screen and ```swift source:AnyObject``` is cell source with all properties you need to set up you cell.

```swift
open class ActionCellSource : ImoTableViewSource {
    
    public var title : String

    init(title:String) {
        self.title = title
        //Init source an specify cell class you will represent by this source
        super.init(cellClass: "ActionCell")
        //Set nib bundle if your cell is not in current project bundle
        setNibBundle(with:Bundle.init(for: self.classForCoder))
    }
}
```

## Templates for everything 🍾 
The quick onboarding for use **ImoTableView** is to add **ImoTableViewCell.xctemplate** in your xcode templates, this template will create all you need to fast create an new **Cell** and **CellSource** for you

![alt text](https://github.com/imodeveloperlab/ImoTableView/blob/master/CreateCellFromTemplate.gif "ImoTableView Logo")

To add **ImoTableViewCell.xctemplate.xctemplate** in xcode you need to open File Templates folder, you can simply call this terminal command ```open /Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/File\ Templates/```

After create an folder **ImoTableView** and copy in this folder **ImoTableViewCell.xctemplate** from Templates/ folder of this repo.

## Snippets
### ImoTableViewSection

```swift 
//Create new section
let section = ImoTableViewSection()

//Add CellSource
section.add(YourCellSource)

//Delete CellSource
section.delete(atIndex:YourCellIndex)

//Delete CellSource
section.delete(YourCellSource)

//Delete All 
section.deleteAll()

//Set section header View
section.headerView = YourView

//Set section footer View
section.footerView = YourView

```

### ImoTableView

```swift 
//Create new table
let table = ImoTableView()

//Add section
table.add(YourSection)

//Add sections
table.add(YourSections)

//Delete section at index
table.deleteSection(at: YourSectionIndex)

//Delete all sections
table.deleteAllSections()

//Did select source, after user touch up on cell
table.didSelectSource = { source in
    //Do something with source
}

//Did select cell at index path, after user touch up on cell
table.didSelectCellAtIndexPath = { indexPath in
    //Do something with source
}

```
