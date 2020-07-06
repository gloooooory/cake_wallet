import 'package:cake_wallet/src/domain/exchange/exchange_provider_description.dart';
import 'package:cake_wallet/src/stores/action_list/action_list_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cake_wallet/generated/i18n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:cake_wallet/routes.dart';
import 'package:date_range_picker/date_range_picker.dart' as date_rage_picker;
import 'package:cake_wallet/themes.dart';
import 'package:cake_wallet/theme_changer.dart';

class ButtonHeader extends SliverPersistentHeaderDelegate {
  final sendImage = Image.asset('assets/images/send.png');
  final exchangeImage = Image.asset('assets/images/exchange.png');
  final buyImage = Image.asset('assets/images/coins.png');

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final _themeChanger = Provider.of<ThemeChanger>(context);
    Image filterButton;

    if (_themeChanger.getTheme() == Themes.darkTheme) {
      filterButton = Image.asset('assets/images/filter_button.png');
    } else {
      filterButton = Image.asset('assets/images/filter_light_button.png');
    }

    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      child: Container(
        color: Colors.red,
//        height: 75,
        padding: EdgeInsets.only(top: 26, left: 20, right: 20, bottom: 10),
//        color: Theme.of(context).backgroundColor,
        child: Stack(
          children: <Widget>[
            Center(
                child: Text(
              S.of(context).transactions,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryTextTheme.title.color),
            )),
            Positioned(
                right: 0,
                height: 36,
                child: PopupMenuButton<int>(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                        enabled: false,
                        value: -1,
                        child: Text(S.of(context).transactions,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .caption
                                    .color))),
//                          PopupMenuItem(
//                              value: 0,
//                              child: Observer(
//                                  builder: (_) => Row(
//                                      mainAxisAlignment:
//                                      MainAxisAlignment
//                                          .spaceBetween,
//                                      children: [
//                                        Text(S.of(context).incoming),
//                                        Checkbox(
//                                          value: actionListStore
//                                              .transactionFilterStore
//                                              .displayIncoming,
//                                          onChanged: (value) =>
//                                              actionListStore
//                                                  .transactionFilterStore
//                                                  .toggleIncoming(),
//                                        )
//                                      ]))),
//                          PopupMenuItem(
//                              value: 1,
//                              child: Observer(
//                                  builder: (_) => Row(
//                                      mainAxisAlignment:
//                                      MainAxisAlignment
//                                          .spaceBetween,
//                                      children: [
//                                        Text(S.of(context).outgoing),
//                                        Checkbox(
//                                          value: actionListStore
//                                              .transactionFilterStore
//                                              .displayOutgoing,
//                                          onChanged: (value) =>
//                                              actionListStore
//                                                  .transactionFilterStore
//                                                  .toggleOutgoing(),
//                                        )
//                                      ]))),
                    PopupMenuItem(
                        value: 2,
                        child: Text(S.of(context).transactions_by_date)),
                    PopupMenuDivider(),
                    PopupMenuItem(
                        enabled: false,
                        value: -1,
                        child: Text(S.of(context).trades,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .caption
                                    .color))),
                    PopupMenuItem(
                        value: 3,
                        child: Observer(
                            builder: (_) => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('XMR.TO'),
//                                        Checkbox(
//                                          value: actionListStore
//                                              .tradeFilterStore
//                                              .displayXMRTO,
//                                          onChanged: (value) =>
//                                              actionListStore
//                                                  .tradeFilterStore
//                                                  .toggleDisplayExchange(
//                                                  ExchangeProviderDescription
//                                                      .xmrto),
//                                        )
                                    ]))),
                    PopupMenuItem(
                        value: 4,
                        child: Observer(
                            builder: (_) => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Change.NOW'),
//                                        Checkbox(
//                                          value: actionListStore
//                                              .tradeFilterStore
//                                              .displayChangeNow,
//                                          onChanged: (value) =>
//                                              actionListStore
//                                                  .tradeFilterStore
//                                                  .toggleDisplayExchange(
//                                                  ExchangeProviderDescription
//                                                      .changeNow),
//                                        )
                                    ]))),
                    PopupMenuItem(
                        value: 5,
                        child: Observer(
                            builder: (_) => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('MorphToken'),
//                                        Checkbox(
//                                          value: actionListStore
//                                              .tradeFilterStore
//                                              .displayMorphToken,
//                                          onChanged: (value) =>
//                                              actionListStore
//                                                  .tradeFilterStore
//                                                  .toggleDisplayExchange(
//                                                  ExchangeProviderDescription
//                                                      .morphToken),
//                                        )
                                    ])))
                  ],
                  child: filterButton,
                  onSelected: (item) async {
                    if (item == 2) {
                      final List<DateTime> picked =
                          await date_rage_picker.showDatePicker(
                              context: context,
                              initialFirstDate:
                                  DateTime.now().subtract(Duration(days: 1)),
                              initialLastDate: (DateTime.now()),
                              firstDate: DateTime(2015),
                              lastDate: DateTime.now().add(Duration(days: 1)));

                      if (picked != null && picked.length == 2) {
//                              actionListStore.transactionFilterStore
//                                  .changeStartDate(picked.first);
//                              actionListStore.transactionFilterStore
//                                  .changeEndDate(picked.last);
                      }
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 164;

  @override
  double get minExtent => 66;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  Widget actionButton(
      {BuildContext context,
      @required Image image,
      @required String title,
      @required String route}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (route.isNotEmpty) {
                Navigator.of(context, rootNavigator: true).pushNamed(route);
              }
            },
            child: Container(
              height: 48,
              width: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryTextTheme.subhead.color,
                  shape: BoxShape.circle),
              child: image,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(140, 153, 201,
                      0.8) // Theme.of(context).primaryTextTheme.caption.color
                  ),
            ),
          )
        ],
      ),
    );
  }
}