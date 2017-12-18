## Basic Example

```swift
//TABLE
let table = ImoTableView(on: self.view)

//SECTION
let section = ImoTableViewSection()

//FAKER
let faker = Faker.init()

let firstName = TextCellSource(text: "First Name: \(faker.name.firstName())")
section.add(firstName)

let lastName = TextCellSource(text: "Last Name: \(faker.name.lastName())")
section.add(lastName)

let company = TextCellSource(text: "Company: \(faker.company.name())")
section.add(company)

table.add(section: section)
```
## Result

![alt text](BasicExample.gif "ImoTableView Logo")
