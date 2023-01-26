import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_app/resource/dimen.dart';

class ShelfDetailBottomSheetView extends StatelessWidget {
  final Function renameAction;
  final Function deleteShelfAction;
  final String shelfName;

  ShelfDetailBottomSheetView(
      {required this.renameAction,
      required this.deleteShelfAction,
      required this.shelfName});

  List<String> bottomSheetOptions = [
    "Rename shelf",
    "Delete shelf",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MARGIN_MEDIUM_2,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: MARGIN_MEDIUM_2),
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Text(
                      "$shelfName",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: FONT_REGULAR_2X,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MARGIN_SMALL,
                  ),
                ],
              )
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                itemCount: bottomSheetOptions.length,
                itemBuilder: (BuildContext context, int index) {
                  return BottomSheetOptionsListView(
                      options: bottomSheetOptions,
                      index: index,
                      respectiveFunction: () {
                        if (index == 0) {
                          renameAction();
                        } else if (index == 1) {
                          deleteShelfAction();
                        }
                      });
                }),
          )
        ],
      ),
    );
  }
}

class BottomSheetOptionsListView extends StatelessWidget {
  BottomSheetOptionsListView({
    required this.options,
    required this.index,
    required this.respectiveFunction,
  });

  final List<String> options;
  int index;
  final Function respectiveFunction;
  List<Icon> iconList = [
    Icon(
      Icons.create,
      color: Colors.black87,
    ),
    Icon(
      Icons.delete,
      color: Colors.black87,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
            // border: Border.all(color:PAYMENT_CONTAINER_BORDER),
            // borderRadius: BorderRadius.circular(BORDER_RADIUS_NORMAL),
            ),
        margin: EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10.0,
                ),
                // Image.network("${options[index].iconPath}",color: Colors.white,),
                iconList[index],
                SizedBox(
                  width: MARGIN_MEDIUM_2,
                ),
                GestureDetector(
                  child: Text(options[index] ?? ""),
                  onTap: () {
                    respectiveFunction();
                  },
                )
              ],
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.white,
            )
          ],
        ),
      ),
      onTap: () {
        respectiveFunction();
      },
    );
  }
}
