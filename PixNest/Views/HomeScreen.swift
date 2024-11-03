//
//  HomeScreen.swift
//  PixNest
//
//  Created by Andrea Bottino on 31/10/24.
//

import SwiftUI

struct HomeScreen: View {
    
    @State private var searchViewModel = SearchViewModel()
    
    var body: some View {
        TabView {
            SearchView(searchViewModel: $searchViewModel)
                .tabItem {
                    Label("Pixnest", systemImage: K.Icons.pixnest)
                }
            
            FavouritesView(searchViewModel: $searchViewModel)
                .tabItem {
                    Label("My Favourites", systemImage: K.Icons.favourites)
                }
        }
    }
}


#Preview {
    HomeScreen()
}
