//
//  ContentView.swift
//  Fetch-Recipes
//
//  Created by Dev on 6/29/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: ContentView.ViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.loading {
                    ProgressView()
                } else {
                    List(viewModel.meals) { meal in
                        NavigationLink(destination: RecipeView(viewModel: RecipeView.ViewModel(meal: meal, api: viewModel.api))) {
                            MealListItem(meal: meal)
                        }
                    }
                    .refreshable {
                        Task {
                            await viewModel.retrieveDesserts()
                        }
                    }
                }
            }
            .navigationTitle("Fetch Desserts")
            .navigationBarTitleDisplayMode(.inline)
        }
        .padding(EdgeInsets(top: 10, leading: 24, bottom: 10, trailing: 24 ))
        .onAppear() {
            Task {
                await viewModel.retrieveDesserts()
            }
        }
    }
}

extension ContentView {
    
    @MainActor
    final class ViewModel: ObservableObject {
        
        let api: ApiDatasource
        @Published var loading = true
        @Published var meals = [Meal]()

        init(api: ApiDatasource) {
            self.api = api
        }
        
        func retrieveDesserts() async {
            loading = true
            do {
                meals = try await api.GET_desserts()
            } catch {
                meals = []
            }
            loading = false
        }
    }
}

#Preview {
    ContentView(viewModel: ContentView.ViewModel(api: MockAPI()))
}
 
