//
//  AddItemView.swift
//  amortise-ios
//
//  Created by Ace Green on 2022-07-28.
//

import SwiftUI

struct AddItemView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    // CoreData
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var confirmDelete = false
    @State var showAttachSheet = false
    
    @StateObject var viewModel: AddItemViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.primary_color.edgesIgnoringSafeArea(.all)
                VStack {
                    Group {
                        if viewModel.coreDataObject == nil {
                            ToolbarModelView(title: "Add Item") { self.presentationMode.wrappedValue.dismiss() }
                        } else {
                            ToolbarModelView(title: "Edit Item", button1Icon: IMAGE_DELETE_ICON) { self.presentationMode.wrappedValue.dismiss() }
                                button1Method: { self.confirmDelete = true }
                        }
                    }.alert(isPresented: $confirmDelete,
                            content: {
                                Alert(title: Text(APP_NAME), message: Text("Are you sure you want to delete this item?"),
                                    primaryButton: .destructive(Text("Delete")) {
                                        viewModel.deleteItem(managedObjectContext: self.managedObjectContext)
                                    }, secondaryButton: Alert.Button.cancel(Text("Cancel"), action: { confirmDelete = false })
                                )
                            })
                    
                    ScrollView(showsIndicators: false) {
                        
                        VStack(spacing: 12) {
                            
                            TextField("Title", text: $viewModel.title)
                                .modifier(SailecFontModifier(.regular, size: 16))
                                .accentColor(Color.text_primary_color)
                                .frame(height: 50).padding(.leading, 16)
                                .background(Color.secondary_color)
                                .cornerRadius(4)
                            
                            TextField("Amount", text: $viewModel.principleAmount)
                                .modifier(SailecFontModifier(.regular, size: 16))
                                .accentColor(Color.text_primary_color)
                                .frame(height: 50).padding(.leading, 16)
                                .background(Color.secondary_color)
                                .cornerRadius(4).keyboardType(.decimalPad)
                            
                            DropdownButton(shouldShowDropdown: $viewModel.showTagDrop, displayText: $viewModel.buttonTitle,
                                           options: CategoryType.allCases, mainColor: Color.text_primary_color,
                                           backgroundColor: Color.secondary_color, cornerRadius: 4, buttonHeight: 50) { key in
                                let selectedObj = CategoryType.allCases.filter({ $0.description == key }).first
                                if let object = selectedObj {
                                    viewModel.buttonTitle = object.description
                                    viewModel.selectedCategory = CategoryType(rawValue: object.rawValue) ?? CategoryType.allCases[0]
                                }
                                viewModel.showTagDrop = false
                            }
                            
                            HStack {
                                DatePicker("PickerView", selection: $viewModel.purchaseDate,
                                           displayedComponents: [.date, .hourAndMinute]).labelsHidden().padding(.leading, 16)
                                Spacer()
                            }
                            .frame(height: 50).frame(maxWidth: .infinity)
                            .accentColor(Color.text_primary_color)
                            .background(Color.secondary_color).cornerRadius(4)
                            
                            TextField("Note", text: $viewModel.note)
                                .modifier(SailecFontModifier(.regular, size: 16))
                                .accentColor(Color.text_primary_color)
                                .frame(height: 50).padding(.leading, 16)
                                .background(Color.secondary_color)
                                .cornerRadius(4)
                            
                            Button(action: { viewModel.attachImage() }, label: {
                                HStack {
                                    Image(systemName: "paperclip")
                                        .font(.system(size: 18.0, weight: .bold))
                                        .foregroundColor(Color.text_primary_color)
                                        .padding(.leading, 16)
                                    TextView(text: "Attach an image", type: .button).foregroundColor(Color.text_primary_color)
                                    Spacer()
                                }
                            })
                            .frame(height: 50).frame(maxWidth: .infinity)
                            .background(Color.secondary_color)
                            .cornerRadius(4)
                            .actionSheet(isPresented: $showAttachSheet) {
                                ActionSheet(title: Text("Do you want to remove the attachment?"), buttons: [
                                    .default(Text("Remove")) { viewModel.removeImage() },
                                    .cancel()
                                ])
                            }
                            
                            if let image = viewModel.imageAttached {
                                Button(action: { showAttachSheet = true }, label: {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 250).frame(maxWidth: .infinity)
                                        .background(Color.secondary_color)
                                        .cornerRadius(4)
                                })
                            }
                            
                            Spacer().frame(height: 150)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity).padding(.horizontal, 8)
                        .alert(isPresented: $viewModel.showAlert,
                               content: { Alert(title: Text(APP_NAME), message: Text(viewModel.alertMsg), dismissButton: .default(Text("OK"))) })
                    }
                    
                }.edgesIgnoringSafeArea(.top)
                
                VStack {
                    Spacer()
                    VStack {
                        Button(action: { viewModel.saveItem(managedObjectContext: managedObjectContext) }, label: {
                            HStack {
                                Spacer()
                                TextView(text: viewModel.actionButtonText, type: .button).foregroundColor(.white)
                                Spacer()
                            }
                        })
                        .padding(.vertical, 12).background(Color.main_color).cornerRadius(8)
                    }.padding(.bottom, 16).padding(.horizontal, 8)
                }
                
            }
        }
        .dismissKeyboardOnTap()
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onReceive(viewModel.$closePresenter) { close in
            if close { self.presentationMode.wrappedValue.dismiss() }
        }
    }
}

//struct AddExpenseView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddExpenseView()
//    }
//}
