//
//  ContentView.swift
//  Priority
//
//  Created by Victor Zerefos on 06/07/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: -  Property
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State var task: String = ""
    @State private var showNewTaskItem: Bool = false
    
    
    // MARK: -  Fetching Data
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    // MARK: -  Body
    var body: some View {
        NavigationView {
            ZStack {
                // MARK: -  MAIN VIEW
                
                VStack {
                    
                    // MARK: -  HEADER
                    HStack(spacing: 10) {
                        //: - title
                        Text("Priority")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.black)
                            .padding(.leading, 4)
                            .shadow(radius: 3)
                        
                        Spacer()
                        
                        //: - Add Button
                        Button(action: {
                            showNewTaskItem = true
                            feedback.notificationOccurred(.success)
                        }, label: {
                            Image(systemName: "plus")
                                .font(.system(size: 16, weight: .black, design: .rounded))
                                .padding(.horizontal, 10)
                                .frame(minWidth: 60, minHeight: 24)
                                .background(
                                    Capsule().stroke(Color.white, lineWidth: 2)
                                )
                        })
                        
                        
                        //: - Edit button
                        EditButton()
                            .font(.system(size: 16, weight: .black, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth: 60, minHeight: 24)
                            .background(
                                Capsule().stroke(Color.white, lineWidth: 2)
                            )

                        //: - Appearence Button
                        Button(action: {
                            isDarkMode.toggle()
                            feedback.notificationOccurred(.success)
                        }, label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .frame(width: 24, height: 24, alignment: .center)
                                .font(.system(.title, design: .rounded))
                        })
                        
                    } //: - HSTACK
                    .padding()
                    .foregroundColor(.white)
                    
                    Spacer(minLength: 100)
                    
                    // MARK: -  TASKS
                    List {
                        ForEach(items) { item in
                           ListRowItemView(item: item)
                        }
                        .onDelete(perform: deleteItems)
                    } //: - LIST
                    .listStyle(InsetGroupedListStyle())
                    .shadow(radius: 10)
                } //: - VSTACK
                .blur(radius: showNewTaskItem ? 8 : 0, opaque: false)
                .transition(.move(edge: .bottom))
                .animation(.easeOut(duration: 0.5))
                
                // MARK: -  NEW TASK ITEM
                
                if showNewTaskItem {
                    BlankView(
                        backgroundColor:isDarkMode ? Color.black : Color.gray,
                        backgroundOpacity:isDarkMode ? 0.3 : 0.5)
                        .onTapGesture {
                            withAnimation() {
                                showNewTaskItem = false
                            }
                        }
                    
                    NewTaskItemView(isShowing: $showNewTaskItem)
                }
                
            } //: - ZSTACK
            .onAppear() {
                UITableView.appearance().backgroundColor = UIColor.clear
            }
            .navigationBarTitle("Priorities")
            .navigationBarHidden(true)
            .background(
                BackgroundImageView()
                    .blur(radius: showNewTaskItem ? 8 : 0, opaque: false)
            )
            .background(
                backgroundGradient.ignoresSafeArea(.all)
            )
        } //: - NAVIGATION
        .navigationViewStyle(StackNavigationViewStyle())
        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
    }
    
    // MARK: -  FUNCTIONS

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
