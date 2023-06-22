//
//  ListLayout.swift
//  Moonshot
//
//  Created by Pooja Agrawal on 22/06/23.
//

import SwiftUI

struct ListLayout: View {
    let missions : [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    var body: some View {
        List {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label : {
                    HStack {
                        Image(mission.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100,height:100)
                            .padding()
                        
                        VStack {
                            Text(mission.displayName)
                                .font(.title.bold())
                                .foregroundColor(.white)
                            Text(mission.formattedLaunchDate)
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .padding()
                    }
                    .padding()
                }
            }.listRowBackground(Color.darkBackground)
        }.listStyle(.plain)
    }
}

struct ListLayout_Previews: PreviewProvider {
    static var previews: some View {
        ListLayout()
    }
}
