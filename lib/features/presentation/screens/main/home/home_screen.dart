import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:price_tracker/core/network/socket_client.dart';
import 'package:price_tracker/features/domain/entities/request/active_symbols_request.dart';
import 'package:price_tracker/features/presentation/components/shared/shared.dart';
import 'package:price_tracker/features/presentation/cubit/market/market_cubit.dart';
import 'package:price_tracker/features/presentation/cubit/websocket/websocket_cubit.dart';
import 'package:price_tracker/features/presentation/cubit/websocket/websocket_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final socketClient = SocketClient();

  //late String selectedMarket;
  //List<MarketResponse> marketOptions;

  @override
  void initState() {
    super.initState();
    // final marketCubit = MarketCubit();
    // marketCubit.getMarkets();
  }

  // void onConnection() {
  //   debugPrint('onConnection');
  //   socketClient.connect(Constant.wssUrl);
  //   socketClient.listen((message) {
  //     marketOptions.add(
  //       MarketResponse.fromJson(message['active_symbols']),
  //     );
  //     debugPrint(log(message));
  //   });
  // }

  // void onSend() {
  //   debugPrint('onSend...');
  //   socketClient.send(
  //     jsonEncode(ActiveSymbolsRequest(
  //       activeSymbols: 'brief',
  //       productType: 'basic',
  //     )),
  //   );
  // }

  // String log(jsonObject) {
  //   var encoder = const JsonEncoder.withIndent("     ");
  //   return encoder.convert(jsonObject);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Price Tracker'),
        centerTitle: true,
      ),
      body: BlocProvider<WebSocketCubit>(
        create: ((context) => WebSocketCubit()..connect()),
        child: BlocBuilder<WebSocketCubit, WebSocketStatus>(
          builder: (context, state) {
            BlocProvider.of<WebSocketCubit>(context).sendMessage(
              jsonEncode(
                ActiveSymbolsRequest(
                  activeSymbols: 'brief',
                  productType: 'basic',
                ),
              ),
            );

            return Container();
          },
        ),
      ),
      // body: BlocProvider<MarketCubit>(
      //   create: (context) => MarketCubit()..connect(),
      //   child: BlocBuilder<MarketCubit, MarketState>(
      //     builder: (context, state) {
      //       BlocProvider.of<MarketCubit>(context).send();
      //       return CustomDropdown(
      //         label: 'Select a Market',
      //         value: '',
      //         list: state.markets
      //             .map(
      //               (e) => DropdownMenuItem(
      //                 value: e.marketDisplayName,
      //                 child: Text(e.marketDisplayName),
      //               ),
      //             )
      //             .toList(),
      //       );
      //     },
      //   ),
      // ),
      // body: Column(
      //   children: [
      //     // Padding(
      //     //   padding: const EdgeInsets.all(16.0),
      //     //   child: CustomDropdown(
      //     //     value: '',
      //     //     label: 'Select a Market',
      //     //     list: marketOptions
      //     //         .map(
      //     //           (e) => DropdownMenuItem(
      //     //             value: e.marketDisplayName,
      //     //             onTap: () {},
      //     //             child: Text(e.marketDisplayName),
      //     //           ),
      //     //         )
      //     //         .toList(),
      //     //   ),
      //     // ),
      //   ],
      // ),
      // body: const LoadingIndicator(),
      // body: ElevatedButton.icon(
      //   onPressed: () {
      //     onSend();
      //   },
      //   icon: const Icon(
      //     Icons.download,
      //     size: 24.0,
      //   ),
      //   label: const Text('Download'), // <-- Text
      // ),
    );
  }
}
