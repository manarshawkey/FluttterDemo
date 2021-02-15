import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class FancyButton extends StatelessWidget {
  final Function _onPressed;
  final Widget _icon;
  final String _name;
  FancyButton(this._onPressed, this._icon, this._name);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RawMaterialButton(
        fillColor: Colors.deepPurple,
        splashColor: Colors.yellow,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 20.0),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _icon,
                SizedBox(width: 10.0),
                Text(
                  _name,
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ]
          ),
        ),
        onPressed: _onPressed,
        shape: const StadiumBorder(),
      ),
    );
  }
}
phoneCall() async {
  const url = 'tel:01282269699';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
browse() async {
  const url = 'https://pub.dev';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}