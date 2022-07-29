//
//  HomeView.swift
//  amortise-ios
//
//  Created by Ace Green on 2022-07-28.
//

import SwiftUI
import CoreData
import Lottie

struct HomeView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(fetchRequest: ItemCoreDataModel.getAllExpenseData(sortBy: ItemCoreDataModelSort.createdDate, ascending: false))
    var items: FetchedResults<ItemCoreDataModel>
    var filter: ItemCoreDataModelFilterTime?

    @StateObject var viewModel = HomeViewModel()

//    init(filter: ItemCoreDataModelFilterTime? = nil) {
//        let sortDescriptor = NSSortDescriptor(key: "createdDate", ascending: false)
//        self.filter = filter
//        if filter == .all {
//            fetchRequest = FetchRequest<ItemCoreDataModel>(entity: ItemCoreDataModel.entity(), sortDescriptors: [sortDescriptor])
//        } else {
//            var startDate: NSDate!
//            let endDate: NSDate = NSDate()
//            if filter == .week { startDate = Date().getLast7Day()! as NSDate }
//            else if filter == .month { startDate = Date().getLast30Day()! as NSDate }
//            else { startDate = Date().getLast6Month()! as NSDate }
//            let predicate = NSPredicate(format: "createdDate >= %@ AND createdDate <= %@", startDate, endDate)
//            fetchRequest = FetchRequest<ItemCoreDataModel>(entity: ItemCoreDataModel.entity(), sortDescriptors: [sortDescriptor], predicate: predicate)
//        }
//    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.primary_color.edgesIgnoringSafeArea(.all)
                if items.isEmpty {
                    LottieView(animType: .empty_face).frame(width: 300, height: 300)
                    VStack {
                        TextView(text: "No Items Yet!", type: .h6).foregroundColor(Color.text_primary_color)
                        TextView(text: "Add a item and it will show up here", type: .body_1).foregroundColor(Color.text_primary_color).padding(.top, 2)
                    }.padding(.horizontal)
                } else {
                    List {
                        ForEach(self.items) { model in
                            ZStack {
                                HomeListModelView(image: model.categoryType.id,
                                                  title: model.title ?? "",
                                                  amount: String(model.principleAmount),
                                                  createdOn: itemFormatter.string(from: model.purchaseDate ?? Date()),
                                                  isOpen: true).padding(.bottom, 4)
                                NavigationLink(destination: DetailsView(model: model), label: {
                                    EmptyView()
                                }).frame(width: 0).opacity(0.0)
                            }
                        }
                        //                    .onDelete(perform: deleteItems)
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
            .toolbar {
                ToolbarItem {
                    NavigationLink(
                        destination: AddItemView(viewModel: AddItemViewModel()),
                        label: {
                            Label("Add Item", systemImage: "plus")
                        })
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { viewModel.itemsList[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

struct HomeListModelView: View {

    var image: String, title: String, amount: String, createdOn: String, isOpen: Bool

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(image)
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(16)
            VStack(alignment: .leading, spacing: 12) {
                Text(title).lineLimit(1)
                    .modifier(SailecFontModifier(.medium, size: 20))
                    .foregroundColor(Color.text_primary_color)
                Text("\(createdOn)")
                    .modifier(SailecFontModifier(.regular, size: 14))
                    .foregroundColor(Color.text_primary_color)
            }
            Spacer()
            VStack(alignment: .trailing) {
                StatusView(isOpen: isOpen)
                HStack(alignment: .center, spacing: 5) {
                    Image(systemName: "clock.badge.checkmark.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("\(amount) left")
                        .modifier(SailecFontModifier(.regular, size: 20))
                        .foregroundColor(Color.text_primary_color)
                        .padding(.top, 2)
                }
            }.padding(.vertical, 4)
        }
        .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
        .background(Color.secondary_color)
        .cornerRadius(16)
    }
}

struct StatusView: View {
    var isOpen: Bool
    var body: some View {
        Text(isOpen ? "ONGOING" : "COMPLETED").modifier(SailecFontModifier(.regular, size: 12))
            .foregroundColor(isOpen ? Color.blue_color : Color.red_color)
            .padding(.horizontal, 18).padding(.vertical, 8)
            .background(isOpen ? Color.blue_color_trans : Color.red_color_trans)
            .cornerRadius(12)
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
