//
//  HomeView.swift
//  Carousel
//
//  Created by Jan Kott on 13.03.21.
//

import SwiftUI

struct HomeView : View {
    
    @State var index = 0
    @State var stories = [
        CarouselExtension(id: 0, image: "p0", offset: 0,title: "Black Castel"),
        CarouselExtension(id: 1, image: "p1", offset: 0,title: "Dreaming Moon"),
        CarouselExtension(id: 2, image: "p2", offset: 0,title: "Fallen In Love"),
        CarouselExtension(id: 3, image: "p3", offset: 0,title: "Hounted Ground")]
    @State var scrolled = 0
    @State var index1 = 0
    
    var body: some View{
        ScrollView(.vertical, showsIndicators: false) {
            VStack{
                HStack{
                    Button(action: {}) {
                        Image(systemName: "line.horizontal.3.decrease")
                            .font(Font.title.weight(.medium))
                            .imageScale(.small)
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "magnifyingglass")
                            .font(Font.title.weight(.medium))
                            .imageScale(.small)
                            .foregroundColor(.black)
                    }
                }
                .padding()
                
                HStack{
                    Text("Trending")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.black)
                    Spacer(minLength: 0)
                    Button(action: {}) {
                        Image(systemName: "ellipsis")
                            .font(Font.title.weight(.medium))
                            .imageScale(.small)
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal)
                
                HStack{
                    Text("Animated")
                        .font(.system(size: 15))
                        .foregroundColor(index == 0 ? .white : Color.gray.opacity(0.85))
                        .fontWeight(.bold)
                        .padding(.vertical,6)
                        .padding(.horizontal,20)
                        .background(Color.black.opacity(index == 0 ? 1 : 0))
                        .clipShape(Capsule())
                        .onTapGesture {
                            index = 0
                        }
                    
                    Text("25+ Stories")
                        .font(.system(size: 15))
                        .foregroundColor(index == 1 ? .white : Color.gray.opacity(0.85))
                        .fontWeight(.bold)
                        .padding(.vertical,6)
                        .padding(.horizontal,20)
                        .background(Color.black.opacity(index == 01 ? 1 : 0))
                        .clipShape(Capsule())
                        .onTapGesture {
                            index = 1
                        }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top,10)
                
                ZStack{
                    ForEach(stories.reversed()){story in
                        HStack{
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)){
                                Image(story.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: calculateWidth(), height: (UIScreen.main.bounds.height / 1.8) - CGFloat(story.id - scrolled) * 50)
                                    .cornerRadius(15)
                                
                                VStack(alignment: .leading,spacing: 18){
                                    HStack{
                                        Text(story.title)
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                        Spacer()
                                    }
                                    
                                    Button(action: {}) {
                                        Text("Read Later")
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .padding(.vertical,6)
                                            .padding(.horizontal,25)
                                            .background(Color.black)
                                            .clipShape(Capsule())
                                    }
                                }
                                .frame(width: calculateWidth() - 40)
                                .padding(.leading,20)
                                .padding(.bottom,20)
                            }
                            .offset(x: story.id - scrolled <= 2 ? CGFloat(story.id - scrolled) * 30 : 60)
                            
                            Spacer(minLength: 0)
                        }
                        .contentShape(Rectangle())
                        .offset(x: story.offset)
                        .gesture(DragGesture().onChanged({ (value) in
                            
                            withAnimation{
                                if value.translation.width < 0 && story.id != stories.last!.id {
                                    stories[story.id].offset = value.translation.width
                                } else if story.id > 0 {
                                    stories[story.id - 1].offset = -(calculateWidth() + 60) + value.translation.width
                                }
                            }
                        }).onEnded({ (value) in
                            withAnimation{
                                if value.translation.width < 0{
                                    if -value.translation.width > 180 && story.id != stories.last!.id{
                                        stories[story.id].offset = -(calculateWidth() + 60)
                                        scrolled += 1
                                    } else {
                                        stories[story.id].offset = 0
                                    }
                                } else if story.id > 0 {
                                    if value.translation.width > 180{
                                        stories[story.id - 1].offset = 0
                                        scrolled -= 1
                                    } else {
                                        stories[story.id - 1].offset = -(calculateWidth() + 60)
                                    }
                                }
                            }
                        }))
                    }
                }
                .frame(height: UIScreen.main.bounds.height / 1.8)
                .padding(.horizontal,25)
                .padding(.top,25)
                
                HStack{
                    Text("Favorites")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.black)
                    Spacer(minLength: 0)
                    Button(action: {}) {
                        Image(systemName: "ellipsis")
                            .font(Font.title.weight(.medium))
                            .imageScale(.small)
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal)
                .padding(.top,25)
                
                HStack{
                    Text("Latest")
                        .font(.system(size: 15))
                        .foregroundColor(index1 == 0 ? .white : Color.gray.opacity(0.85))
                        .fontWeight(.bold)
                        .padding(.vertical,6)
                        .padding(.horizontal,20)
                        .background(Color.black.opacity(index1 == 0 ? 1 : 0))
                        .clipShape(Capsule())
                        .onTapGesture {
                            index1 = 0
                        }
                    Text("9+ Stories")
                        .font(.system(size: 15))
                        .foregroundColor(index1 == 1 ? .white : Color.gray.opacity(0.85))
                        .fontWeight(.bold)
                        .padding(.vertical,6)
                        .padding(.horizontal,20)
                        .background(Color.black.opacity(index1 == 01 ? 1 : 0))
                        .clipShape(Capsule())
                        .onTapGesture {
                            index1 = 1
                        }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top,10)
                
                HStack{
                    Image("p3")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width - 80, height: 250)
                        .cornerRadius(15)
                    Spacer(minLength: 0)
                }
                .padding(.horizontal)
                .padding(.top,20)
                .padding(.bottom)
            }
        }
    }
    
    func calculateWidth()->CGFloat{
        let screen = UIScreen.main.bounds.width - 50
        let width = screen - (2 * 30)
        return width
    }
}
