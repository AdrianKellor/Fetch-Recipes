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
                    List(viewModel.meals.sorted {($0.strMeal ?? "") < ($1.strMeal ?? "")}) { meal in
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
        
        let api: Api
        @Published var loading = true
        @Published var meals = [Meal]()

        init(api: Api) {
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
    ContentView(viewModel: ContentView.ViewModel(api: Api(apiDatasource: MockDatasource())))
}
 
