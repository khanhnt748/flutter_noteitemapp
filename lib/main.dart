import 'package:flutter/material.dart';

void main() {
  runApp(
    NoteApp()
  );
}

class Item {
  Item(@required this._name);
  final String _name;
}

typedef OnTapCallback(Item item);
typedef OnLongPressCallback(Item item);
class ItemUI extends StatelessWidget {
  ItemUI({this.item, this.onTapCallback, this.onLongPressCallback, this.isNeedBuy});
  final Item item;
  final bool isNeedBuy;
  final OnTapCallback onTapCallback;
  final OnLongPressCallback onLongPressCallback;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(item._name[0]),
          backgroundColor: isNeedBuy ? null : Colors.black45,
        ),
        title: Container(
          child: Text(
            item._name,
            style: TextStyle(
              decoration: isNeedBuy ? null : TextDecoration.lineThrough,
              fontWeight: isNeedBuy ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        onTap: (){ onTapCallback(item); },
        onLongPress: (){ onLongPressCallback(item); },
      ),
    );
  }
}

class NoteApp extends StatefulWidget {
  List<Item> itemList = [Item("Hello"),Item("Test")];
  @override
  NoteAppState createState() => NoteAppState();
}

class NoteAppState extends State<NoteApp> {
  var inCartItemList = Set<Item>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Note Item App",
      home: Scaffold(
        body: Container(
          width: 400,
          alignment: Alignment.topCenter,
          child: ListView(
            children: widget.itemList.map((Item item) {
              return ItemUI(
                item: item,
                isNeedBuy: !inCartItemList.contains(item),
                onTapCallback: _handleItemOnTap,
                onLongPressCallback: _handleItemOnLongPress,
              );
            }).toList(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Adding new item note',
          child: Icon(Icons.add),
          onPressed: _handleFloatingButtonAdd,
        ),
      ),
    );
  }

  void _handleItemOnTap(item) {
    setState(() {
      if (inCartItemList.contains(item)) {
        inCartItemList.remove(item);
      } else {
        inCartItemList.add(item);
      }
    });
  }

  void _handleItemOnLongPress(Item item){

  }

  void _handleFloatingButtonAdd () async {

  }
}