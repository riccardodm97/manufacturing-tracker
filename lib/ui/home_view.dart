import 'package:dapp/ui/colors.dart';
import 'package:dapp/viewmodel/login_view_model.dart';
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
              leading: AuthButton(),
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
  AuthButton({Key? key}) : super(key: key);

  final loginController = TextEditingController();

  void dispose() {
    loginController.dispose();
  }

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
            color: color7,
            iconSize: 36.0,
            onPressed: () {
              showGeneralDialog(
                context: context,
                barrierDismissible: true,
                transitionDuration: const Duration(milliseconds: 500),
                barrierLabel: MaterialLocalizations.of(context).dialogLabel,
                barrierColor: Colors.black.withOpacity(0.5),
                pageBuilder: (context, _, __) {
                  return SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(
                            top: defaultPadding,
                            left: defaultPadding,
                            right: defaultPadding,
                            bottom: defaultPadding,
                          ),
                          height: MediaQuery.of(context).size.height * 0.28,
                          decoration: const BoxDecoration(
                            color: color1,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(24),
                              bottomRight: Radius.circular(24),
                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                const Text(
                                  'Enter your private key to login',
                                  style: TextStyle(
                                    color: color7,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Material(
                                  color: color7.withOpacity(0),
                                  child: TextField(
                                      controller: loginController,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                            borderSide: const BorderSide(
                                                color: color7, width: 1.5)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                            borderSide: const BorderSide(
                                                color: color7, width: 1.5)),
                                        labelText: 'Private key',
                                        labelStyle: TextStyle(
                                            color: color7.withOpacity(0.5)),
                                      ),
                                      style: const TextStyle(color: color1)),
                                ),
                                ElevatedButton.icon(
                                    onPressed: () {
                                      viewModel.login(
                                          context, loginController.text);
                                    },
                                    icon: const Icon(Icons.login_rounded),
                                    label: const Text(
                                      'Login',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      elevation: 10,
                                      primary: color7,
                                      onPrimary: color1,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 15),
                                    )),
                              ]),
                        ),
                      ],
                    ),
                  );
                },
                transitionBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOut,
                    ).drive(Tween<Offset>(
                      begin: Offset(0, -1.0),
                      end: Offset.zero,
                    )),
                    child: child,
                  );
                },
              );
            });
  }
}
//             onPressed: () {
//               showModalBottomSheet(
//                   shape: const RoundedRectangleBorder(
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(24.0),
//                         topRight: Radius.circular(24.0)),
//                   ),
//                   context: context,
//                   builder: (context) {
//                     return Container(
//                         padding: const EdgeInsets.only(
//                           top: defaultPadding,
//                           left: defaultPadding,
//                           right: defaultPadding,
//                           bottom: defaultPadding,
//                         ),
//                         height: MediaQuery.of(context).size.height * 0.3,
//                         decoration: BoxDecoration(
//                           color: color7,
//                           borderRadius: const BorderRadius.only(
//                             topLeft: Radius.circular(24),
//                             topRight: Radius.circular(24),
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.5),
//                               spreadRadius: 5,
//                               blurRadius: 7,
//                               offset: const Offset(
//                                   0, -1), // changes position of shadow
//                             ),
//                           ],
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: <Widget>[
//                                 const Text(
//                                   'Enter your private key to login',
//                                   style: TextStyle(
//                                       color: color1,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 24.0),
//                                 ),
//                                 SizedBox(
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.8,
//                                   child: TextField(
//                                       controller: loginController,
//                                       decoration: InputDecoration(
//                                         enabledBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(24.0),
//                                             borderSide: const BorderSide(
//                                                 color: color1, width: 1.5)),
//                                         focusedBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(24.0),
//                                             borderSide: const BorderSide(
//                                                 color: color1, width: 1.5)),
//                                         labelText: 'Private key',
//                                         labelStyle: TextStyle(
//                                             color: color1.withOpacity(0.5)),
//                                       ),
//                                       style: const TextStyle(color: color1)),
//                                 ),
//                                 ElevatedButton.icon(
//                                     onPressed: () {
//                                       viewModel.login(
//                                           context, loginController.text);
//                                     },
//                                     icon: const Icon(Icons.login_rounded),
//                                     label: const Text(
//                                       'Login',
//                                       style: TextStyle(
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     style: ElevatedButton.styleFrom(
//                                       elevation: 10,
//                                       primary: color1,
//                                       onPrimary: color7,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(24.0),
//                                       ),
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 30, vertical: 15),
//                                     )),
//                               ],
//                             ),
//                           ],
//                         ));
//                   });
//             },
//             color: color7,
//             iconSize: 36.0,
//           );
//   }
// }
