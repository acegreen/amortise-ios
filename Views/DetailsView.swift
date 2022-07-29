//
//  ContentView.swift
//  amortise-ios
//
//  Created by Ace Green on 2022-07-28.
//

import SwiftUI

struct DetailsView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext

    @ObservedObject var viewModel: DetailsViewModel

    init(model: ItemCoreDataModel) {
        viewModel = DetailsViewModel(model: model)
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.primary_color.edgesIgnoringSafeArea(.all)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ZStack(alignment: .top) {
                            Image(viewModel.model.categoryType.id).resizable()
                                .frame(height: 400).frame(maxWidth: .infinity)
                            HStack {
                                Button(action: { self.presentationMode.wrappedValue.dismiss() },
                                       label: { Image(IMAGE_BACK_ICON).resizable().frame(width: 34, height: 34) })
                                Spacer()
                                Button(action: { viewModel.favouriteMethod() },
                                       label: { Image(IMAGE_FAV_ICON).resizable().frame(width: 26, height: 26) })
                            }.padding(.horizontal, 24).padding(.top, 46)
                        }
                        Group {
                            HStack {
                                Text(viewModel.model.titleUnwrapped).modifier(SailecFontModifier(.bold, size: 24)).lineLimit(1)
                                    .foregroundColor(Color.text_primary_color)
                                Spacer()
                                GenderView(isMale: viewModel.model.titleUnwrapped == "male")
                            }.padding(.vertical, 8)

                            HStack(alignment: .center) {
                                HStack(alignment: .center, spacing: 2) {
                                    Image(IMAGE_LOC_ICON).resizable().frame(width: 24, height: 24)
                                    Text("\(viewModel.model.titleUnwrapped) away").modifier(SailecFontModifier(.regular, size: 14))
                                        .foregroundColor(Color.text_primary_color).padding(.top, 2)
                                }
                                Spacer()
                                Text("\(viewModel.model.titleUnwrapped) yrs | \(viewModel.model.titleUnwrapped)").modifier(SailecFontModifier(.regular, size: 14))
                                    .lineLimit(1).foregroundColor(Color.text_primary_color)
                            }

                            HStack {
                                Text("12 min ago").modifier(SailecFontModifier(.regular, size: 14))
                                    .foregroundColor(Color.text_primary_color)
                                Spacer()
                            }.padding(.leading, 6).padding(.top, 2)

                            VStack(spacing: 16) {
                                HStack {
                                    Text("My Story").modifier(SailecFontModifier(.bold, size: 18))
                                        .foregroundColor(Color.text_primary_color)
                                    Spacer()
                                }
                                Text(viewModel.model.titleUnwrapped).modifier(SailecFontModifier(.regular, size: 16))
                                    .foregroundColor(Color.text_primary_color)
                            }.padding(.vertical, 16)

                            VStack(spacing: 16) {
                                HStack {
                                    Text("Quick Info").modifier(SailecFontModifier(.bold, size: 18))
                                        .foregroundColor(Color.text_primary_color)
                                    Spacer()
                                }
                                HStack(spacing: 8) {
                                    DetailsInfoView(primary: "\(viewModel.model.titleUnwrapped) yrs", secondary: "Age")
                                    DetailsInfoView(primary: "\(viewModel.model.titleUnwrapped)", secondary: "Color")
                                    DetailsInfoView(primary: "\(viewModel.model.titleUnwrapped)", secondary: "Weight")
                                }
                            }.padding(.vertical, 16)

                            VStack(spacing: 16) {
                                HStack {
                                    Text("Owner Info").modifier(SailecFontModifier(.bold, size: 18))
                                        .foregroundColor(Color.text_primary_color)
                                    Spacer()
                                }
                                ManufacturerDetailsView(image: viewModel.model.titleUnwrapped, name: viewModel.model.titleUnwrapped, bio: viewModel.model.titleUnwrapped, messageMethod: viewModel.messageMethod)
                            }.padding(.vertical, 16)

                            Button(action: { viewModel.adoptMethod() },
                                   label: { Text("Adopt me").modifier(SailecFontModifier(.medium, size: 16)).foregroundColor(.white) })
                                .frame(height: 50).frame(maxWidth: .infinity)
                                .background(Color.main_color).cornerRadius(8)
                                .padding(.vertical, 24)

                        }.padding(.horizontal, 16).padding(.top, 8)
                    }.background(Color.primary_color)

                    Spacer()
                    Spacer().frame(height: 150)
                }
                .edgesIgnoringSafeArea(.all)
                .navigationBarHidden(true)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct ManufacturerDetailsView: View {
    var image: String, name: String, bio: String
    var messageMethod: () -> ()
    var body: some View {
        HStack {
            Image(image).resizable().scaledToFill().frame(width: 60, height: 60).cornerRadius(30)
            VStack(alignment: .leading, spacing: 8) {
                Text(name).modifier(SailecFontModifier(.medium, size: 16))
                    .foregroundColor(Color.text_primary_color)
                Text(bio).modifier(SailecFontModifier(.regular, size: 14))
                    .foregroundColor(Color(hex: "828282"))
            }.padding(.leading, 8)
            Spacer()
            Button(action: { self.messageMethod() },
                   label: { Image(IMAGE_MSG_ICON).resizable().frame(width: 20, height: 20) })
                .frame(width: 45, height: 45).background(Color.main_color).cornerRadius(25)
        }
    }
}

struct DetailsInfoView: View {
    var primary: String, secondary: String
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 8) {
                Text(primary).modifier(SailecFontModifier(.medium, size: 16))
                    .foregroundColor(Color.text_primary_color)
                Text(secondary).modifier(SailecFontModifier(.regular, size: 12))
                    .foregroundColor(Color(hex: "828282"))
            }
            Spacer()
        }
        .padding(.vertical, 12)
        .background(Color.secondary_color)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10).stroke(Color(hex: "DDDDDD"), lineWidth: 0.25)
        )
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DetailsView(model: ItemCoreDataModel()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
