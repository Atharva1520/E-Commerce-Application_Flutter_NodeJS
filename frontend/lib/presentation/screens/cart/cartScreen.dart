import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/ui.dart';
import '../../../logic/cubit/cartCubit/cartCubit.dart';
import '../../../logic/cubit/cartCubit/cartState.dart';
import '../../../logic/service/calculations.dart';
import '../../../logic/service/formatter.dart';
import '../../widgets/cartListView.dart';
import '../order/orderDetails.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const routeName = "cart";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: SafeArea(
        child: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
          if (state is CartLoadingState && state.items.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is CartErrorState && state.items.isEmpty) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is CartLoadedState && state.items.isEmpty) {
            return const Center(child: Text("Cart items will show up here.."));
          }

          return Column(
            children: [
              Expanded(child: CartListView(items: state.items)),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${state.items.length} items",
                            style: TextStyles.body1
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Total: ${Formatter.formatPrice(Calculations.cartTotal(state.items))}",
                            style: TextStyles.heading3,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: CupertinoButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, OrderDetailScreen.routeName);
                        },
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 22),
                        color: AppColors.accent,
                        child: const Text("Place Order"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
