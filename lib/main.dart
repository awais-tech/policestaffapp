import 'package:flutter/material.dart';
import 'package:policestaffapp/AddDuties.dart';
import 'package:policestaffapp/PoliceSFSDutiesProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => PoliceSfsDutiesProvider(),
          ),

          // ChangeNotifierProvider(
          //   create: (ctx) => Orders(),
          // ),
        ],
        child: MaterialApp(
            title: 'BaltiApp',
            theme: ThemeData(
              primaryColor: Color(0xffB788E5),
              accentColor: Color(0xff8d43d6),
            ),
            home: AddDutiesScreen(),
            routes: {
              // HomeScreen.route: (ctx) => HomeScreen(),
              // LoginScreen1.routename: (ctx) => LoginScreen1(),
              // TabsScreen.route: (ctx) => TabsScreen(),
              // Mysignuppage.route: (ctx) => Mysignuppage(),
              // ForgotPasswordScreen.route: (ctx) =>
              //     ForgotPasswordScreen(),
              // ResetPassword.route: (ctx) => ResetPassword(),
              // VerifyEmail.route: (ctx) => VerifyEmail(),
              // HomeScreen.route: (ctx) => TabsScreen(),
              // Mycart.route: (ctx) => Mycart(),
              // ProductDetailScreen.routeName: (ctx) =>
              //     ProductDetailScreen(),
              // CheckoutScreen.route: (ctx) => CheckoutScreen(),
              // Profile.routeName: (ctx) => Profile(),
              // OrderStatus.routeName: (ctx) => OrderStatus(),
              // OrdersScreen.routeName: (ctx) => OrdersScreen(),
              // AboutUs.routeName: (ctx) => AboutUs(),
              // Address.routeName: (ctx) => Address(),
              // Sellerdashboard.routeName: (ctx) => Sellerdashboard(),
              // UserProductsScreen.routeName: (ctx) =>
              //     UserProductsScreen(),
              // AddProductScreen.routeName: (ctx) => AddProductScreen(),
              // FeedbackScreen.routename: (ctx) => FeedbackScreen(),
              // ManageFeedbacks.routeName: (ctx) => ManageFeedbacks(),
              // OrdersApprovalScreen.routeName: (ctx) =>
              //     OrdersApprovalScreen(),
              // Rating.routename: (ctx) => Rating(),
              // OrdersScreenprocessprocess.routeName: (ctx) =>
              //     OrdersScreenprocessprocess()
            }));
  }
}
