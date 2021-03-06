<h1 align="center">Manufacturing Tracker </h1>
<p align="center">

<img src="https://img.shields.io/badge/-flutter-blue" />
<img src="https://img.shields.io/badge/web3dart-2.3.5-green" />
<img src="https://img.shields.io/badge/solidity-0.8.11-red" />
<img src="https://img.shields.io/badge/-firebase-yellow" />
<img src="https://img.shields.io/badge/-truffle-yellowgreen" />


<br/>

<div align="center">
    <img src="assets/images/app_icon.png" width="150px" alt="Blockchain Logo"/>
</div>

<br> 

Manufacturing Tracker is a mobile decentralized-App that allows you to be informed on crucial information about goods sold in markets and shops, via Blockchain technology. Those information, such as production date, production location, manufacturer name, etc, concern both the product itself and each and every of its constituents (e.g. ingredients for food or cosmetics). This way, the authenticity or locality of a product with its constituents can be verified, and knowledge about the product chain, from the raw materials to the finished good can be obtained. 

Through the app, manufacturers can upload products details on the system which stores them on the Ethereum Blockchain by means of smartcontracts, which means no possibility of counterfeiting . At every step of the manufacturing process, information are uploaded on the blockchain so that the entire history of a product can then be retrieved. 
Each tracked item (smart contract) has an id (eth address) associated to it, which can be used as it is or in the form of a QR code to obtain all its details. In this way the end user can learn important information about the product they are about to buy. 

## Technology stack 
- Backend
  - [Solidity](https://docs.soliditylang.org/en/v0.8.15) for writing smart contracts.
  - [Truffle](https://trufflesuite.com) for deploying contracts to the blockchain .
  - [Ganache](https://trufflesuite.com/ganache) as testnet. 
  - [Web3dart](https://github.com/xclud/web3dart) to connect and interact with the Ethereum blockchain.
- Frontend
  - [Flutter](https://github.com/flutter/flutter) for UI components.
   
 
## Demo 
<p align="center">
<img src="res/demo.gif" alt="" data-canonical-src="res/presentation.gif" width="25%" height="25%" />
</p>

## Set up the development environment 
- Necessary programs and plugins 
    - Clone this repo
    - Install Flutter: https://docs.flutter.dev/get-started/install
    - Install Node.js and Npm: https://nodejs.org/en/
    - Install Truffle: `npm install -g truffle`
    - Download Ganache from: https://www.trufflesuite.com/ganache
    - Install FlutterFire CLI following this guide: https://firebase.flutter.dev/docs/cli
    - Install the flutter extension for VsCode (or the IDE of your choice)
- Set up the project 
    - run `flutter pub get` 
    - set the desired Http JSON-RPC API endpoint URL in the [config.dart file](lib/setup/config.dart)
    - generate a new firebase_options.dart file [like this](lib/setup/firebase_options.dart) 
      <br> to do so run `flutterfire configure -o "lib/setup/firebase_options.dart"` 
      <br> or follow this guide https://firebase.flutter.dev/docs/overview/
    - open Ganache , create a testnet and run it locally on port `7545`
    - enter the [smartcontracts folder](smartcontract) on the terminal and run `truffle migrate` 

## Run the application
- connect a device or open the emulator in Android Studio / Xcode
- start the flutter app : `flutter run`

## Authors 
- [Riccardo de Matteo](https://github.com/riccardodm97) 
- [Giacomo Berselli](https://github.com/JackBerselli)
