# ImoTableView

ImoTableView is an wrapper around UITableView which aims to facilitate working with tables

## Example  ##

<pre><code>let section = ImoTableViewSection()
let source = DemoCellSource()
section.add(source)
tableView.addSection(section)</pre></code>

# Use Example

- ImoTableView
  Is an subclass from UITableView

- ImoTableViewSection
  This object hold all sources for cells displayed in an section

- ImoTableViewSource
  This is base source which need to be subclassed

- ImoTableViewCell
  Base cell
