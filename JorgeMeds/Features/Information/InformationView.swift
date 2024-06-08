//
//  InformationView.swift
//  JorgeMeds
//
//  Created by Mateus Andreatta on 04/06/24.
//

import SwiftUI

struct InformationView: View {
    var body: some View {
        NavigationStack {
            Text("Seus dados")
                .navigationTitle("Seus dados")
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
