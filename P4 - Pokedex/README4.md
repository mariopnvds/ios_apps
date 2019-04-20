# IWEB - Project 4
## Authors
Pablo Caraballo Llorente
Mario Penavades Suárez

## Built With
- [Swift](https://www.apple.com/swift/)

## Statement
It is requested to make an app that implements a Pokedex that shows the types of existing pokemons and the races belonging to each type.

The Pokedex must have three screens that must be navigated using a Navigation Controller.

The first screen must be a Table View Controller that shows the types of existing pokemons (water, steel, earth, etc.). Use a custom cell style for the cells in this table, so that the type icon is located on the right side of the cell. The cells must show the type icon, the type name, and the number of pokemons that belong to the type. When you click on one of the cells in this screen, you must go to the second screen.

The second screen must be a Table View Controller that shows all pokemon races that belong to the selected type. Use Subtitle style cells for this table. The cells must show the race name in textLabel, the race code in detailTextLabel and the race icon in imageView. When you click on one of the cells in this screen, you must go to the third screen.

The third screen must be a View Controller that contains a UIWebView or a WKWebView in which the website will be displayed http://es.pokemon.wikia.com/wiki/RACENAME, where RACENAME should be replaced by the name of the race that was selected in the previous screen. If you use a WKWebView, do not forget to import the WebKit framework. Do not forget to configure ATS (App Transport Security) to allow viewing contents using the HTTP protocol.

To do this practice, the pokedex.plist file is provided with all the data about types and races that the app should show. The files Race.swift, Type.swift and PokedexModel.swift that implement the model of the app, and all the icons of the types and races are also provided.

The application must have icons, initial image, and adapt with the turns of the terminal, etc.

## Demo
![Demo](p4.gif){ height="400" style="display: block; margin: 0 auto" }