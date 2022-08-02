//
//  Playlist.swift
//  R • music
//
//  Created by anna on 02.08.2022.
//

import SwiftUI
import URLImage

struct Playlist: View {
    
    @State var songs = UserDefaults.standard.savedSong()
    @State var song: SearchViewModel.Cell!
    
    var tabBarDelegate: TabBarControllerDelegate?
    
    init() {
        UITableView.appearance().showsVerticalScrollIndicator = false
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                GeometryReader { geo in
                    HStack(spacing: 20) {
                        
                        Button {
                            self.song = self.songs[0]
                            self.tabBarDelegate?.maxSizeSongPlayer(viewModel: self.song)
                        } label: {
                            Image(systemName: "play.fill")
                                .frame(width: geo.size.width / 2 - 10, height: 50)
                                .accentColor(Color.init(#colorLiteral(red: 0.8425114751, green: 0.6422668695, blue: 0.550950408, alpha: 1)))
                                .background(Color.init(#colorLiteral(red: 1, green: 0.7956983447, blue: 0.683547914, alpha: 0.2)))
                                .cornerRadius(10)
                        }
 
                        Button {
                            self.songs = UserDefaults.standard.savedSong()
                        } label: {
                            Image(systemName: "arrow.2.circlepath")
                                .frame(width: geo.size.width / 2 - 10, height: 50)
                                .accentColor(Color.init(#colorLiteral(red: 0.8425114751, green: 0.6422668695, blue: 0.550950408, alpha: 1)))
                                .background(Color.init(#colorLiteral(red: 1, green: 0.7956983447, blue: 0.683547914, alpha: 0.2)))
                                .cornerRadius(10)
                        }
                    }
                }.padding().frame(height: 50)
                
                List {
                    ForEach(songs) { song in
                        PlaylistCell(cell: song).simultaneousGesture(TapGesture().onEnded({ _ in
                            let keyWindow = UIApplication.shared.connectedScenes
                                .filter { $0.activationState == .foregroundActive }
                                .map{ $0 as? UIWindowScene}
                                .compactMap{ $0 }
                                .first?.windows
                                .filter({ $0.isKeyWindow }).first //stackOverFlow
                            
                            let tabBarVC = keyWindow?.rootViewController as? TabBarController
                            tabBarVC?.songPlayer.delegate = self
                            
                            self.song = song
                            self.tabBarDelegate?.maxSizeSongPlayer(viewModel: self.song)
                        }))
                    }
                    .onDelete(perform: deleteFromList)
                }
            }
            .onAppear {
                UITableView.appearance().separatorColor = .clear
            }
            .navigationBarTitle("Playlist")
        }
    }
    
    func deleteFromList(at offsets: IndexSet) {
        songs.remove(atOffsets: offsets)
        
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: songs, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: UserDefaults.addedKeySong)
        }
    }
}

struct PlaylistCell: View {
    
    var cell: SearchViewModel.Cell
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            if let url = URL(string: cell.iconUrlString ?? "") {
            URLImage(url) { image in
                image.resizable().frame(width: 65, height: 65).cornerRadius(5)
                }
                VStack(alignment: .leading) {
                    Text("\(cell.trackName)")
                    Text("\(cell.artistName)")
                        .foregroundColor(.gray)
                }
         }
      }
   }
}

struct Playlist_Previews: PreviewProvider {
    static var previews: some View {
        Playlist()
    }
}
