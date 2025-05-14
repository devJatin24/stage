import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stage/helper/app_utilities/method_utils.dart';
import 'package:stage/helper/dxWidget/dx_text.dart';

class SwitchButton extends StatefulWidget {
  final ValueChanged<bool> onChanged;

  const SwitchButton({Key? key, required this.onChanged}) : super(key: key);

  @override
  _MySwitchState createState() => _MySwitchState();
}

class _MySwitchState extends State<SwitchButton> {
  bool _isSwitched = false;

  static const String prefKey = 'isFavouriteSwitchOn';

  @override
  void initState() {
    super.initState();
    _loadSwitchValue();
  }

  Future<void> _loadSwitchValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isSwitched = prefs.getBool(prefKey) ?? false;
    });
  }

  Future<void> _handleSwitch(bool value) async {
    if (await MethodUtils.isInternetPresent()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(prefKey, value); // Save to shared preferences

      setState(() {
        _isSwitched = value;
      });

      widget.onChanged(value); // Trigger callback
    } else {
      MethodUtils.showNoInternetCustomDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DxTextWhite("Favourite", mBold: true),
        SizedBox(width: 5),
        Switch(
          value: _isSwitched,
          onChanged: _handleSwitch,
          activeColor: Colors.white,
        ),
      ],
    );
  }
}
