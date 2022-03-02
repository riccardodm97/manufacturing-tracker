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
                  decoration: const BoxDecoration(
                    color: color1,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(36),
                      bottomRight: Radius.circular(36),
                    ),
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
                          SizedBox(height: 30.0),
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
                        icon: Icon(Icons.add_rounded),
                        label: Text('Create New Product'),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: color7,
                          onPrimary: color1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(36.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                    ElevatedButton.icon(
                        onPressed: () {
                          model.navigateFindProductView(context);
                        },
                        icon: Icon(Icons.search_rounded),
                        label: Text('Find Product'),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: color7,
                          onPrimary: color1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(36.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                    ElevatedButton.icon(
                        onPressed: () {
                          model.navigateMyProductsView(context);
                        },
                        icon: Icon(Icons.shopping_cart_rounded),
                        label: Text('My Products'),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: color7,
                          onPrimary: color1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(36.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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
