import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    this.label,
    this.padding,
    this.value,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: <Widget>[
          Theme(
            data: new ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: value,
              checkColor: Colors.black,
              focusColor: Colors.blue,
              activeColor: Colors.white,
              hoverColor: Colors.white,
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
          ),
          SizedBox(width: 10,),
          //Expanded(child: Text(label)),
          RichText(
          text:new TextSpan(
            children: [
              new TextSpan(
                text: 'Agree to T&C \n \n',
                style: new TextStyle(color: Colors.white),
              ),
              new TextSpan(
                text: '(View Terms & Conditions)',
                style: new TextStyle(color: Colors.blue),
                recognizer: new TapGestureRecognizer()
                  ..onTap = () { launch('https://drive.google.com/file/d/1pMnwkTk02F0B-gOeDROMWxq4ZTpms_cp/view?usp=sharing');
                  },
              ),
            ],
          ),
        ),
        ],
      ),
    );
  }
}
