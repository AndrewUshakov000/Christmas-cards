//
//  DetailView.swift
//  Christmas cards
//
//  Created by Andrew Ushakov on 12/16/21.
//

import SwiftUI
import UIKit

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
            print("Save finished!")
        }
}

struct DetailView: View {
    @State private var name = ""
    @State private var text = ""
    @State private var titleColor = Color(.systemBackground)
    @State private var nameColor = Color(.systemBackground)
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    @State private var image: Image?
    var darkRed: Color = Color.init(red: 128 / 255, green: 0, blue: 32 / 255)
    @State private var opacityValue: Double = 1
    @State private var fontSizeDown = 24.0
    @State private var fontSizeUp = 24.0
    
    private var fullScreenAd: Interstitial?
         init() {
             fullScreenAd = Interstitial()
         }
    var imageView : some View {
        ZStack {
            image!
            .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(width: 400, height: 300)
                .offset(y: -20)
                .opacity(opacityValue)
        VStack {
            Text(text)
                .font(.custom("Chalkboard SE", size: fontSizeUp))
                .padding([.leading, .trailing], 30)
                    .lineLimit(3)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .foregroundColor(titleColor)
                    .offset(y: 70)
                   
            Spacer()
           
            Text("by \(name)")
                .font(.custom("Chalkboard SE", size: fontSizeDown))
                .offset(y: -80)
                .foregroundColor(nameColor)
                .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                            ImagePicker(image: $inputImage)
                        }
                
        }
       
        Text("Made with Ancards").offset(x: 125, y: 88)
                .font(.caption)
            .foregroundColor(.white)
           
        
        
        }.frame(height: 240)
    }
    var body: some View {
        VStack {
                ZStack {
                   
                    if image != nil {
                        image!
                        .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .frame(width: 390, height: 300)
                            .offset(y: -20)
                            .opacity(opacityValue)
                    } else {
                        VStack {
                        Text("Select image")
                            .bold()
                            .font(.title3)
                            Image(systemName: "arrow.down")
                                .font(.largeTitle)
                        }
                            
                    }
                    VStack {
                        Text(text)
                            .font(.custom("Chalkboard SE", size: fontSizeUp))
                            .padding([.leading, .trailing], 30)
                                .lineLimit(3)
                                .multilineTextAlignment(.center)
                                .lineSpacing(4)
                                .foregroundColor(titleColor)
                                .offset(y: 70)
                               
                        Spacer()
                       
                        Text("by \(name)")
                            .font(.custom("Chalkboard SE", size: fontSizeDown))
                            .offset(y: -80)
                            .foregroundColor(nameColor)
                            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                                        ImagePicker(image: $inputImage)
                                    }
                            .disabled(image == nil)
                            
                    }
                   
                    Text("Made with Ancards").offset(x: 110, y: 110)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .disabled(image == nil)
                        
                    
                    
                }.frame(width: 300, height: 240)
            ScrollView {
                VStack {
                    HStack {
                        Button {
                            showingImagePicker.toggle()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 185, height: 50)
                                    .foregroundColor(.yellow)
                                Text("Select image")
                                    .bold()
                                    .foregroundColor(.black)
                            }
                        }
                        if image != nil {
                            Button {
                                image = nil
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 185, height: 50)
                                        .foregroundColor(.red)
                                    Text("Delete image")
                                        .bold()
                                        .foregroundColor(.white)
                                        
                                }
                            }
                        }
                    }.padding(.bottom)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                        ForEach(1..<7) { num in
                         
                            Image("\(num)")
                                .resizable()
                                .frame(width: 90, height: 60)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .onTapGesture {
                                    image = Image("\(num)")
                                }
                            }
                        }
                    }
                    HStack {
                        Slider(value: $opacityValue, in: 0...1)
                        Divider()
                        Text("Opacity is \(1.0 - opacityValue, specifier: "%.1f")")
                            
                    }.padding(10).frame(width: 380).overlay(RoundedRectangle(cornerRadius: 10).stroke())
                   
                    
                }.padding()
                
            
                
                
                ZStack {
                    TextField("Write your wish...", text: $text)
                    .padding(.leading)
                        .frame(width: 380, height: 55)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(darkRed))
                        
                ColorPicker("", selection: $titleColor)
                        .offset(x: -25)
                    
                }
                HStack {
                    Slider(value: $fontSizeUp, in: 20...40)
                    Divider()
                    Text("Size is \(fontSizeUp, specifier: "%.0f")")
                        
                }.padding(9).frame(width: 380).overlay(RoundedRectangle(cornerRadius: 10).stroke()).padding(.bottom)
                ZStack {
                    TextField("Name of receiver...", text: $name)
                    .padding(.leading)
                        .frame(width: 380, height: 55)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(darkRed))
                        
                ColorPicker("", selection: $nameColor)
                        .offset(x: -25)
                }
                HStack {
                    Slider(value: $fontSizeDown, in: 20...40)
                    Divider()
                    Text("Size is \(fontSizeDown, specifier: "%.0f")")
                        
                }.padding(9).frame(width: 380).overlay(RoundedRectangle(cornerRadius: 10).stroke())
                    
                
                Spacer()
                Button {
                    self.fullScreenAd!.showAd()
                    let ourPhoto = imageView.snapshot()
                    let imageSaver = ImageSaver()
                    imageSaver.writeToPhotoAlbum(image: ourPhoto)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(image == nil ? .gray : .orange)
                        Text("Save")
                            .bold()
                            .foregroundColor(image == nil ? .gray : .white)
                            
                    }
                }.disabled(image == nil).frame(width: 250, height: 50).padding()
                

            }.padding()
        }
        
    }
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
