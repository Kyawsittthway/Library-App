import 'package:flutter/material.dart';
import 'package:library_app/blocs/library_page_bloc.dart';
import 'package:library_app/resource/dimen.dart';
import 'package:provider/provider.dart';

import '../resource/enums.dart';

class SortByBottomSheetView extends StatelessWidget {
  SortStyle choice;
 final Function(SortStyle) onTapAction;

 SortByBottomSheetView({
   required this.choice,
   required this.onTapAction
});

  @override
  Widget build(BuildContext context) {
    return  Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left:32,top:35),
                child: Text(
                  "Sort By",
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
                title: Text("Recently opened"),
                leading: Radio<SortStyle>(
                  value: SortStyle.Recent,
                  groupValue: choice,
                  onChanged: (SortStyle? value) {
                    onTapAction(value!);
                  },
                ),
              ),
              ListTile(
                key: Key("SortByTitleKey"),
                title: Text("Title"),
                onTap: (){
                 onTapAction(SortStyle.Title);
                },
                leading: Radio<SortStyle>(
                  value: SortStyle.Title,
                  groupValue: choice,
                  onChanged: (SortStyle? value) {
                    onTapAction(value!);
                  },
                ),
              ),
              ListTile(
                key: Key("SortByAuthorKey"),
                title: Text("Author"),
                onTap: (){
                  onTapAction(SortStyle.Author);
                  },
                leading: Radio<SortStyle>(
                  value: SortStyle.Author,
                  groupValue: choice,
                  onChanged: (SortStyle? value) {
                    onTapAction(value!);
                  },
                ),
              )
            ],
          ),
        );
  }
}


