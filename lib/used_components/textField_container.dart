import 'package:flutter/material.dart';



class TextFieldContainer extends StatelessWidget {

  TextInputType ? insertedtype;
  bool obscureText ;
  void Function(String) onChanged;
  String insertedHint;
  IconData insertedIcon;
  Color iconColor;
  Color containerColor;
  // const EmailContainer({Key? key}) : super(key: key);

  TextFieldContainer({required this.containerColor,
    this.insertedtype,
    this.obscureText = false,
    required this.onChanged,
    required this.iconColor,
    required this.insertedHint,
    required this.insertedIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.grey.shade600,fontSize: 17),
        keyboardType: insertedtype,
        textAlign: TextAlign.start,
        onChanged: onChanged,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: insertedHint,
          enabledBorder: UnderlineInputBorder( //<-- SEE HERE
            borderSide: BorderSide(
                width: 3, color: Colors.grey.shade600),
          ),

          prefixIcon: Icon(
            insertedIcon,
            color: iconColor,
          ),
          floatingLabelStyle: MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
            final Color color = states.contains(MaterialState.error)
                ? Theme.of(context).colorScheme.error
                : Colors.grey.shade600;
            return TextStyle(color: color, letterSpacing: 1.3);
          }),
          labelStyle:
          MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
            final Color color = states.contains(MaterialState.error)
                ? Theme.of(context).colorScheme.error
                : Colors.grey.shade600;
            return TextStyle(color: color, letterSpacing: 1.3);
          }),
        ),
      ),
    );
  }
}
