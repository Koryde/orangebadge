//
//  DrinksListView.swift
//  OITNB
//
//  Created by Andrea Masturzo on 16/01/23.
//

import SwiftUI

struct DrinksListView: View {
    
    @EnvironmentObject var drinkViewModel: DrinkViewModel
    @State var searchText = ""
    @State var selectedCategories = Set<Category>()
    @State var presentAddDrinkView = false
    
    var body: some View {
        NavigationStack {
            filterTags()
            List {
                ForEach(drinkViewModel.allDrinks.filter { drink in
                    let search = searchText.isEmpty || drink.name.lowercased().contains(searchText.lowercased())
                    let filtered = selectedCategories.isEmpty || selectedCategories.contains(drink.category)
                    return search && filtered
                }, id: \.self) { drink in
                    DrinksListItem(drink: drink)
                }
            }
            .searchable(text: $searchText, prompt: "Search for a drink")
            .sheet(isPresented: $presentAddDrinkView, content: {
                AddNewDrinkView()
            })
            .toolbar {
                //Button to show AddNewDrink modal view
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: {
                        presentAddDrinkView.toggle()
                    }, label:  {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Add drink")
                        }
                        .foregroundColor(Color("MainColor"))
                    })
                    Spacer()
                }
            }
        }
    }
    func filterTags() -> some View {
        return ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Category.allCases, id: \.self) { category in
                    Button(action: {
                        if selectedCategories.contains(category) {
                            selectedCategories.remove(category)
                        } else {
                            selectedCategories.insert(category)
                        }
                    }, label: {
                        Text(category.name)
                            .padding(5)
                            .foregroundColor(self.selectedCategories.contains(category) ? Color("MainColor") : Color.gray)
                    })
                }
            }
        }
    }
}

struct DrinksListItem: View {
    
    @EnvironmentObject var drinkViewModel: DrinkViewModel
    var drink: Drink
    
    var body: some View {
        HStack {
            HStack {
                Image(drink.category.listIconName)
                VStack(alignment: .leading) {
                    Text(drink.name)
                        .bold()
                    Text(String(format: "%.1f", drink.alcoholByVolume))
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
            Image(systemName: drink.isFavorite ? "star.fill" : "star")
                .foregroundColor(Color("MainColor"))
                .onTapGesture {
                    print(drink.isFavorite)
                    drinkViewModel.addOrRemoveFavorite(drink: drink)
                }
        }
    }
}


//struct DrinksListView_Previews: PreviewProvider {
//    static var previews: some View {
//        DrinksListView()
//    }
//}
