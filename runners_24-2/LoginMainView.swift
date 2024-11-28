import SwiftUI

struct Login: View {
  var body: some View {
    ZStack() {
      Group {
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 310, height: 51)
          .background(Color(red: 0.26, green: 0.26, blue: 0.26).opacity(0.20))
          .cornerRadius(23)
          .overlay(
            RoundedRectangle(cornerRadius: 23)
              .inset(by: 0.50)
              .stroke(Color(red: 0.52, green: 0.49, blue: 0.49), lineWidth: 0.50)
          )
          .offset(x: -6, y: -83.50)
          .opacity(0.52)
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 310, height: 51)
          .background(Color(red: 0.26, green: 0.26, blue: 0.26).opacity(0.20))
          .cornerRadius(23)
          .overlay(
            RoundedRectangle(cornerRadius: 23)
              .inset(by: 0.50)
              .stroke(Color(red: 0.52, green: 0.49, blue: 0.49), lineWidth: 0.50)
          )
          .offset(x: -6, y: -9.50)
          .opacity(0.52)
        Text("ID")
          .font(Font.custom("Inria Sans", size: 26))
          .foregroundColor(.black)
          .offset(x: -5, y: -82.50)
          .opacity(0.36)
        Text("PW")
          .font(Font.custom("Inria Sans", size: 26))
          .foregroundColor(.black)
          .offset(x: -6, y: -9.50)
          .opacity(0.36)
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 295, height: 56)
          .background(Color(red: 1, green: 0.32, blue: 0.16).opacity(0.80))
          .cornerRadius(23)
          .offset(x: -5.50, y: 101)
          .shadow(
            color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 2
          )
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 295, height: 56)
          .background(Color(red: 1, green: 0.99, blue: 0.99))
          .cornerRadius(23)
          .overlay(
            RoundedRectangle(cornerRadius: 23)
              .inset(by: 1)
              .stroke(Color(red: 1, green: 0.32, blue: 0.16), lineWidth: 1)
          )
          .offset(x: -6.50, y: 180)
          .shadow(
            color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 2
          )
        Text("Join Us")
          .font(Font.custom("Jalnan Gothic", size: 26))
          .foregroundColor(Color(red: 1, green: 0.32, blue: 0.16))
          .offset(x: -6.50, y: 180)
        Text("Log In")
          .font(Font.custom("Jalnan Gothic", size: 26))
          .foregroundColor(.white)
          .offset(x: -6.50, y: 103)
          Ellipse()
          .foregroundColor(Color(red: 1, green: 0.45, blue: 0.33))
          .frame(width: 140, height: 134)
          .offset(x: -5, y: -223)
        HStack(spacing: 0) {

        }
        .padding(
          EdgeInsets(top: 14.25, leading: 20.33, bottom: 14.25, trailing: 20.33)
        )
        .frame(width: 122, height: 114)
        .offset(x: -6, y: -228)
      }
    }
    .frame(width: 402, height: 874)
    .background(.white);
  }
}
