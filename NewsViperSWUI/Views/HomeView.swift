//
//  HomeView.swift
//  NewsViperSWUI
//
//  Created by Jose Preatorian on 02-02-26.
//


import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {

            PopularNewsView()
                .tabItem {
                    Label("Titulares", systemImage: "newspaper.fill")
                }

            ProfileView()
                .tabItem {
                    Label("Perfil", systemImage: "person.text.rectangle.fill")
                }
        }
        .accentColor(.blue)
    }
}


struct ProfileView: View {
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Usuario")) {
                    Text("Configuración de Perfil")
                    Text("Notificaciones")
                }
            }
            .navigationTitle("Perfil")
        }
    }
}

#Preview {
    HomeView()
}

