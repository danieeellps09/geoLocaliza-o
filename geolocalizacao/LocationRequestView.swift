import SwiftUI

struct LocationRequestView: View {
    var body: some View {
        ZStack {
            Color(.systemPurple).ignoresSafeArea()

            VStack {
                Spacer()

                Image(systemName: "paperplane.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(32)

                Text("Would you like to explore places nearby?")
                    .font(.system(size: 28, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .padding()

                Text("Start sharing your location with us")
                    .multilineTextAlignment(.center)
                    .frame(width: 140)
                    .padding()

                Spacer()

                VStack {
                    Button {
                        LocationManager.shared.requestLocation()
                        print("Request Location from user")
                    } label: {
                        Text("Allow Location")
                            .padding()
                            .font(.headline)
                            .foregroundColor(Color(.systemBlue))
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .padding(.horizontal, -32)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .padding()

                    Button {
                        print("Dismiss")
                    } label: {
                        Text("Maybe later")
                    }
                }
            }
            .padding(.bottom, 32)
        }
        .foregroundColor(.white)
    }
}

#Preview {
    LocationRequestView()
}
