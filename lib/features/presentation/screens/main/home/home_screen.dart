import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:price_tracker/core/network/socket_client.dart';
import 'package:price_tracker/features/presentation/components/shared/shared.dart';
import 'package:price_tracker/features/presentation/cubit/market/market_cubit.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  static const routeName = '/home';

  final socketClient = SocketClient();

  // void onConnection() {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Price Tracker'),
        centerTitle: true,
      ),
      body: BlocProvider<MarketCubit>(
        create: (context) => MarketCubit(socketClient)..connect(),
        child: BlocBuilder<MarketCubit, MarketState>(
          builder: (context, state) {
            if (state.markets.isNotEmpty) {
              BlocProvider.of<MarketCubit>(context).disconnect();
            } else {
              BlocProvider.of<MarketCubit>(context).getMarkets();
            }

            // return ListView.builder(
            //     itemCount: state.markets.length,
            //     itemBuilder: (context, index) {
            //       return Text(state.markets[index].marketDisplayName);
            //     });

            // return Column(
            //   children: (),
            // );
            // print('Markets Length: ${state.markets.length}');
            // return Container();

            //String selectedMarket = 'Forex';

            return state.markets.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomDropdown(
                      label: 'Select a Market',
                      value: state.markets.isNotEmpty
                          ? state.markets[0].displayName
                          : null,
                      list: state.markets
                          .map(
                            (e) => DropdownMenuItem(
                              value: e.displayName,
                              child: Text(e.displayName),
                              onTap: () {
                                // will detect for 
                              },
                            ),
                          )
                          .toList(),
                    ),
                  )
                : const LoadingIndicator();
          },
        ),
      ),
      // body: BlocProvider<WebSocketCubit>(
      //   create: ((context) => WebSocketCubit()..connect()),
      //   child: BlocBuilder<WebSocketCubit, WebSocketStatus>(
      //     builder: (context, state) {
      //       BlocProvider.of<WebSocketCubit>(context).sendMessage(
      //         jsonEncode(
      //           ActiveSymbolsRequest(
      //             activeSymbols: 'brief',
      //             productType: 'basic',
      //           ),
      //         ),
      //       );

      //       return Container();
      //     },
      //   ),
      // ),
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
