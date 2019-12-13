import 'package:flutter/material.dart';

class TacButton extends StatelessWidget {
  final String title;

  TacButton({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildButton(context, title);
  }

  Widget _buildButton(BuildContext context, String title) {
    return Stack(children: <Widget>[
      Row(children: <Widget>[
        Expanded(
            child: Card(
          elevation: 15.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          color: Theme.of(context).primaryColor,
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
        ))
      ]),
      Container(
          margin: EdgeInsets.only(top: 5.0, right: 5.0),
          alignment: Alignment.centerRight,
          child: FloatingActionButton(
            heroTag: "jhiuhuh",
            mini: true,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {},
          ))
    ]);
  }
}
