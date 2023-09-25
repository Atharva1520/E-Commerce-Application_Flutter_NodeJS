import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../data/models/category/categoryModel.dart';
import '../data/models/product/productModel.dart';
import '../logic/cubit/categoryProductCubit/categoryProductCubit.dart';
import '../presentation/screens/auth/loginIn.dart';
import '../presentation/screens/auth/provider/loginProvider.dart';
import '../presentation/screens/auth/provider/signUpProvider.dart';
import '../presentation/screens/auth/signUp.dart';
import '../presentation/screens/cart/cartScreen.dart';
import '../presentation/screens/home/homescreen.dart';
import '../presentation/screens/order/myOrder.dart';
import '../presentation/screens/order/orderDetails.dart';
import '../presentation/screens/order/orderPlaced.dart';
import '../presentation/screens/order/providers/orderProvider.dart';
import '../presentation/screens/product/categoryProduct.dart';
import '../presentation/screens/product/productDetails.dart';
import '../presentation/screens/splash/splashScreen.dart';
import '../presentation/screens/user/editUser.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => LoginProvider(context),
                child: const LoginScreen()));

      case SignupScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => SignupProvider(context),
                child: const SignupScreen()));

      case HomeScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const HomeScreen());

      case SplashScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const SplashScreen());

      case ProductDetailsScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => ProductDetailsScreen(
                  productModel: settings.arguments as ProductModel,
                ));

      case CartScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const CartScreen());

      case CategoryProductScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                create: (context) =>
                    CategoryProductCubit(settings.arguments as CategoryModel),
                child: const CategoryProductScreen()));

      case EditProfileScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => const EditProfileScreen());

      case OrderDetailScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => OrderDetailProvider(),
                child: const OrderDetailScreen()));

      case OrderPlacedScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => const OrderPlacedScreen());

      case MyOrderScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const MyOrderScreen());

      default:
        return null;
    }
  }
}
