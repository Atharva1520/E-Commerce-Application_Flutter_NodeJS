import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_frontend/presentation/screens/home/profileScreen.dart';
import 'package:flutter_ecommerce_frontend/presentation/screens/home/userFeed.dart';

import '../../../logic/cubit/cartCubit/cartCubit.dart';
import '../../../logic/cubit/cartCubit/cartState.dart';
import '../../../logic/cubit/userCubit/userCubit.dart';
import '../../../logic/cubit/userCubit/userState.dart';
import '../cart/cartScreen.dart';
import '../splash/splashScreen.dart';
import 'categoryScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> screens = const [
    UserFeedScreen(),
    CategoryScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoggedOutState) {
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Ecommerce App"),
          actions: [
            IconButton(onPressed: () {
              Navigator.pushNamed(context, CartScreen.routeName);
            }, icon:
                BlocBuilder<CartCubit, CartState>(builder: (context, state) {
              return Badge(
                  label: Text("${state.items.length}"),
                  isLabelVisible: (state is CartLoadingState) ? false : true,
                  child: const Icon(CupertinoIcons.cart_fill));
            })),
          ],
        ),
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: "Categories"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
