//
//  ContentView.swift
//  GrazieMille
//
//  Created by Styles Weiler on 10/10/24.


import SwiftUI


struct ContentView: View {
    @StateObject var languageViewModel: LanguageViewModel
    
    var body: some View {
        NavigationStack {
            List(languageViewModel.topics) { topic in
                TopicCell(topic: topic, viewModel: languageViewModel)
            }
            .navigationTitle("Grazie Mille!")
        }
    }
}

#Preview {
    ContentView(languageViewModel: LanguageViewModel())
}


