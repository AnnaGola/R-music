//
//  Playlist.swift
//  R • music
//
//  Created by anna on 29.07.2022.
//

import SwiftUI

struct Playlist: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                GeometryReader { geometry in
                HStack(spacing: 16) {
                    Button {
                        print("12345")
                    } label: {
                        Image(systemName: "play.fill")
                            .frame(width: geometry.size.width / 2 - 10, height: 50)
                            .accentColor(Color.init(#colorLiteral(red: 0.8425114751, green: 0.6422668695, blue: 0.550950408, alpha: 1)))
                            .background(Color.init(#colorLiteral(red: 0.8425114751, green: 0.6422668695, blue: 0.550950408, alpha: 0.2)))
                            .cornerRadius(10)
                    }
                    Button {
                        print("54321")
                    } label: {
                        Image(systemName: "arrow.2.circlepath")
                            .frame(width: geometry.size.width / 2 - 10, height: 50)
                            .accentColor(Color.init(#colorLiteral(red: 0.8425114751, green: 0.6422668695, blue: 0.550950408, alpha: 1)))
                            .background(Color.init(#colorLiteral(red: 0.8425114751, green: 0.6422668695, blue: 0.550950408, alpha: 0.2)))
                            .cornerRadius(10)
                    }
                }
            }.padding().frame(height: 50)
                Divider().padding(.leading).padding(.trailing)
                //Spacer()
                List {
                    PlaylistCell()
                }
            }
            .navigationBarTitle("Playlist")
        }
    }
}

struct PlaylistCell: View {
    var body: some View {
        HStack(spacing: 16) {
            Image("library").resizable().frame(width: 60, height: 60).cornerRadius(3)
            VStack {
                Text("Track name")
                Text("Artist name")
            }
        }
    }
}









struct Playlist_Previews: PreviewProvider {
    static var previews: some View {
        Playlist()
    }
}
