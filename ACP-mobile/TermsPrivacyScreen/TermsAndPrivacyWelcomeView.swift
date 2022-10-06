//
//  WelcomeTermsView.swift
//  ACP-mobile
//
//  Created by Eldar Tutnjic on 30. 9. 2022..
//

import SwiftUI

struct WelcomeTermsView: View {
    @State var currentTab: Int = 0
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                TabView(selection: self.$currentTab) {
                    WelcomeView().tag(0)
                    TermsAndPrivacyWelcomeView().tag(1)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .edgesIgnoringSafeArea(.all)

                TabBarView(currentTab: self.$currentTab)
            }
//            .background(currentTab == 0 ? .blue : .white).edgesIgnoringSafeArea(.all)
        }

    }
}

struct TabBarView: View {
    @Binding var currentTab: Int
    @Namespace var namespace
    var tabBarOptions: [String] = ["\(LocalizedStringKey("tab-1"))", "\(LocalizedStringKey("tab-2"))"]
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack() {
                        ForEach(Array(zip(self.tabBarOptions.indices, self.tabBarOptions)), id: \.0, content: {
                            index, name in
                            TabBarItem(curretnTab: self.$currentTab, namespace: namespace.self, tabBarItemName: name, tab: index)
                        })
                    }
                    .padding(.horizontal)
                }
                .frame(height: 80)
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct TabBarItem: View {
    @Binding var curretnTab: Int
    let namespace: Namespace.ID
    var tabBarItemName: String
    var tab: Int
    var body: some View {
        HStack(alignment: .center) {
            Button {
                self.curretnTab = tab
            } label: {
                VStack {
                    Text(tabBarItemName)
                    if curretnTab == tab {
                        Color.white.frame(height: 6)
                            .matchedGeometryEffect(
                                id: "underline",
                                in: namespace,
                                properties: .frame)
                    } else {
                        Color.blue.frame(height: 6)
                    }
                }
                .animation(.spring(), value: self.curretnTab)
            }
            .buttonStyle(.plain)
        }
    }
}
