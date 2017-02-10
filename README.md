![alt text](https://github.com/imodeveloperlab/ImoTableView/blob/master/Logo.png "ImoTableView Logo")

ImoTableView is an wrapper around **UITableView** which aims to facilitate working with tables and make work more reusable and more dynamic, make it simple and quick to implement, you don't need to work with standart **UITableView** delegates anymore.

## Quick Onboarding  ##

To start use **ImoTableView** you need to undesrstand the base concept, **ImoTableView** is composed from four classes.

1. **ImoTableView** is an subclass from **UITableView** and have the role to manage with **ImoTableViewSection**'s, add new sections, delete and update them.
2. **ImoTableViewSection** is an class which work with **ImoTableViewSource**'s, add new source, delete, update.
3. **ImoTableViewSource** is base object for your new **CellSource**'s this source contain base info about cell class, cell height, and other aditional proprietes which you want to show in your cell, user name for example. 
4. **ImoTableViewCell** is view representation of properties you have stored in your source.

![alt text](https://github.com/imodeveloperlab/ImoTableView/blob/master/ImoTableView.png "ImoTableView")

## Quick Implementation Example ##

Example of how quick and simple you can add an populate an tableView
```swift 
//Create table
let table = ImoTableView()
//Create an section for our table
let section = ImoTableViewSection()
//Create an source for section
let source = DemoCellSource(title:"Demo Cell")
//Add our source to section
section.add(source)
//Add section to table
table.add(section)
//Update our table view
table.reloadData()
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

### Example Implementation ###

```swift
import UIKit
import ImoTableView

class ViewController: UIViewController {

    @IBOutlet weak var tableView: ImoTableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Create new section
        let section = ImoTableViewSection()
        //Create new cellSource
        let actionCellSource = ActionCellCellSource(title: "Action")
        //Add cellSource to section
        section.add(actionCellSource)
        //Add section to table View
        tableView.add(section)
    }
}
```
