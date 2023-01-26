import 'package:flutter/material.dart';
import 'package:library_app/blocs/library_page_bloc.dart';
import 'package:library_app/resource/dimen.dart';
import 'package:provider/provider.dart';

import '../resource/enums.dart';

class ViewAsBottomSheetView extends StatelessWidget {

  final ViewStyle choice;
  final Function(ViewStyle) onTapAction;

  ViewAsBottomSheetView({
    required this.choice,
   required this.onTapAction
});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 32, top: 35),
            child: Text(
              "View as",
              style: TextStyle(
                fontSize: LARGE_FONT_SIZE,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: MARGIN_MEDIUM_2,
          ),
          ListTile(
            key: Key("viewAsListKey"),
            onTap: (){
              onTapAction(ViewStyle.ListView);
            },
            title: Text("List"),
            leading: Radio<ViewStyle>(
              value: ViewStyle.ListView,
              groupValue: choice,
              onChanged: (ViewStyle? value) {
                onTapAction(value!);
              },
            ),
          ),
          ListTile(
            key: Key("viewAsSmallGridKey"),
            onTap: (){
              onTapAction(ViewStyle.SmallGrid);
            },
            title: Text("Small grid"),
            leading: Radio<ViewStyle>(
              value: ViewStyle.SmallGrid,
              groupValue: choice,
              onChanged: (ViewStyle? value) {
                onTapAction(value!);
              },
            ),
          ),
          ListTile(
            key: Key("viewAsLargeGridKey"),
            onTap: (){
              onTapAction(ViewStyle.LargeGrid);
            },
            title: Text("Large grid"),
            leading: Radio<ViewStyle>(
              value: ViewStyle.LargeGrid,
              groupValue: choice,
              onChanged: (ViewStyle? value) {
                onTapAction(value!);
              },
            ),
          ),

        ],
      ),
    );
  }
}
