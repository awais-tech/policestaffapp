import 'package:flutter/material.dart';
import 'package:policestaffapp/AddDuties.dart';
import 'package:policestaffapp/Login.dart';
import 'package:policestaffapp/PoliceSFSDutiesProvider.dart';
import 'package:policestaffapp/ViewDetailsOfDuties.dart';
import 'package:policestaffapp/ViewDuties.dart';
import 'package:provider/provider.dart';
import 'Dashboard.dart';
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
            title: 'Police SFS',
            theme: ThemeData(
              primaryColor: Color(0xffB788E5),
            ),
            home: dutydetails(),
            routes: {
              Staffdashboard.routeName: (ctx) => Staffdashboard(),
              ViewDuties.routeName: (ctx) => ViewDuties()

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
