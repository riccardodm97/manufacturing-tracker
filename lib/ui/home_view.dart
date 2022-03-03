import 'package:dapp/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../viewmodel/home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.nonReactive(
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: const AuthButton(),
              backgroundColor: color1,
            ),
            body: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(
                    left: defaultPadding,
                    right: defaultPadding,
                    bottom: 36 + defaultPadding,
                  ),
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                    color: color1,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            'Product Checker',
                            style: TextStyle(
                                color: color7,
                                fontWeight: FontWeight.bold,
                                fontSize: 36.0),
                          ),
                          SizedBox(height: 20.0),
                          Text('Breve descrizione',
                              style: TextStyle(
                                color: color7,
                                fontSize: 16.0,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                        onPressed: () {
                          model.navigateToCreateProductView(context);
                        },
                        icon: const Icon(Icons.add_rounded),
                        label: const Text(
                          'Add Product',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          primary: color7,
                          onPrimary: color1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                        )),
                    ElevatedButton.icon(
                        onPressed: () {
                          model.navigateFindProductView(context);
                        },
                        icon: const Icon(Icons.search_rounded),
                        label: const Text(
                          'Find Product',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          primary: color7,
                          onPrimary: color1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                        )),
                    ElevatedButton.icon(
                        onPressed: () {
                          model.navigateMyProductsView(context);
                        },
                        icon: const Icon(Icons.shopping_cart_rounded),
                        label: const Text(
                          'My Products',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          primary: color7,
                          onPrimary: color1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                        )),
                  ],
                ))
              ],
            )));
  }
}

class AuthButton extends ViewModelWidget<HomeViewModel> {
  const AuthButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return viewModel.isUserLogged
        ? IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () {
              viewModel.logOut();
            },
            color: color7,
            iconSize: 36.0,
          )
        : IconButton(
            icon: const Icon(Icons.login_rounded),
            onPressed: () {
              viewModel.navigateToLoginView(context);
            },
            color: color7,
            iconSize: 36.0,
          );
  }
}
