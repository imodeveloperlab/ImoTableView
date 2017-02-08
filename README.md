# ImoTableView

Is an wrapper around **UITableView** which aims to facilitate working with tables make work more reusable and more dynamic, make it simple and quick to implement.

## Example  ##

```swift 
let section = ImoTableViewSection()
let source = DemoCellSource()
section.add(source)
tableView.addSection(section)
```
## ImoCell.xctemplate ##

The quick onboarding for use **ImoTableView** is to add **ImoCell.xctemplate** in your xcode templates, this template will create all you need to fast create an new **Cell** and **CellSource** for you

To add **ImoCell.xctemplate** in xcode you need to open File Templates folder, you can simply call this terminal command ```open /Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/File\ Templates/```

After create an folder ImoTableView and copy in this folder **ImoCell.xctemplate** from root folder of this repo

### ExampleCell ###

```swift
import ImoTableView
import UIKit

open class ExampleCellSource : ImoTableViewSource {
    public init() {
        //TODO: Do your work here
        super.init(cellClass: "ExampleCell")
        //Load the nib file
        self.nib = UINib(nibName: self.cellClass, bundle: Bundle.init(for: self.classForCoder))
        //Height and width have default value but you can change it here or dynamically from extern
        self.height = 100
    }
}

open class ExampleCell : ImoTableViewCell {
    open override func setUpWithSource(source:AnyObject) {
        if source is ExampleCellSource {
            //TODO: Do your work here
        }
    }
}

```

# Use Example

- ImoTableView
  Is an subclass from UITableView

- ImoTableViewSection
  This object hold all sources for cells displayed in an section

- ImoTableViewSource
  This is base source which need to be subclassed

- ImoTableViewCell
  Base cell
