//
//  HomeView.swift
//  amortise-ios
//
//  Created by Ace Green on 2022-07-28.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext

    var fetchRequest: FetchRequest<ItemCoreDataModel>
    @FetchRequest(fetchRequest: ItemCoreDataModel.getAllExpenseData(sortBy: ItemCoreDataModelSort.occuredOn, ascending: false))
    var expense: FetchedResults<ItemCoreDataModel>
    var filter: ItemCoreDataModelFilterTime?

    @StateObject var viewModel = HomeViewModel()

    init(filter: ItemCoreDataModelFilterTime? = nil) {
        let sortDescriptor = NSSortDescriptor(key: "occuredOn", ascending: false)
        self.filter = filter
        if filter == .all {
            fetchRequest = FetchRequest<ItemCoreDataModel>(entity: ItemCoreDataModel.entity(), sortDescriptors: [sortDescriptor])
        } else {
            var startDate: NSDate!
            let endDate: NSDate = NSDate()
            if filter == .week { startDate = Date().getLast7Day()! as NSDate }
            else if filter == .month { startDate = Date().getLast30Day()! as NSDate }
            else { startDate = Date().getLast6Month()! as NSDate }
            let predicate = NSPredicate(format: "occuredOn >= %@ AND occuredOn <= %@", startDate, endDate)
            fetchRequest = FetchRequest<ItemCoreDataModel>(entity: ItemCoreDataModel.entity(), sortDescriptors: [sortDescriptor], predicate: predicate)
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.primary_color.edgesIgnoringSafeArea(.all)
                if fetchRequest.wrappedValue.isEmpty {
                    //                LottieView(animType: .empty_face).frame(width: 300, height: 300)
                    VStack {
                        TextView(text: "No Transaction Yet!", type: .h6).foregroundColor(Color.text_primary_color)
                        TextView(text: "Add a transaction and it will show up here", type: .body_1).foregroundColor(Color.text_primary_color).padding(.top, 2)
                    }.padding(.horizontal)
                } else {
                    List {
                        ForEach(self.fetchRequest.wrappedValue) { model in
                            NavigationLink(destination: DetailsView(model: model), label: {
                                HomeListModelView(image: model.categoryType.id,
                                                  name: model.title ?? "",
                                                  age: model.title ?? "",
                                                  about: model.title ?? "",
                                                  location: model.title ?? "",
                                                  gender: model.title ?? "").padding(.bottom, 4)
                            })
                        }
                        //                    .onDelete(perform: deleteItems)
                    }
                    .listStyle(PlainListStyle())
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

//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
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

    var image: String, name: String, age: String, about: String, location: String, gender: String

    var body: some View {
        HStack(spacing: 12) {
            Image(image)
                .resizable().scaledToFill()
                .frame(width: 100, height: 100).cornerRadius(16)
            VStack(alignment: .leading, spacing: 12) {
                Text(name).lineLimit(1).modifier(SailecFontModifier(.medium, size: 20)).foregroundColor(Color.text_primary_color)
                Text("\(age) yrs | \(about)").lineLimit(1).modifier(SailecFontModifier(.regular, size: 14)).foregroundColor(Color.text_primary_color)
                HStack(alignment: .center, spacing: 2) {
                    Image(IMAGE_LOC_ICON).resizable().frame(width: 20, height: 20)
                    Text("\(location) away").modifier(SailecFontModifier(.regular, size: 14))
                        .foregroundColor(Color.text_primary_color).padding(.top, 2)
                }
            }
            Spacer()
            VStack(alignment: .trailing) {
                GenderView(isMale: gender == "male")
                Spacer()
                Text("12 min ago").modifier(SailecFontModifier(.regular, size: 12))
                    .foregroundColor(Color.text_primary_color)
            }.padding(.vertical, 4)
        }
        .padding(16)
        .background(Color.secondary_color)
        .cornerRadius(16)
    }
}

struct GenderView: View {
    var isMale: Bool
    var body: some View {
        Text(isMale ? "Male" : "Female").modifier(SailecFontModifier(.regular, size: 12))
            .foregroundColor(isMale ? Color.blue_color : Color.red_color)
            .padding(.horizontal, 18).padding(.vertical, 8)
            .background(isMale ? Color.blue_color_trans : Color.red_color_trans)
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
