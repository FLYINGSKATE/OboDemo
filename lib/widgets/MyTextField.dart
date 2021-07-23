import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final  TextCapitalization textCapitalization;
  final int maxLength;
  final double horizontal;
  final String suffixText;
  final bool suffixEnable;
  final Function(String val) onChanged;
  final Function(String val) onSubmit;
  final Function(String val) onSuffixClick;

  MyTextField({
    required this.controller,
    required this.hintText,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.textCapitalization=  TextCapitalization.none,
    this.suffixText='',
    required this.onChanged,
    required this.onSubmit,
    required this.onSuffixClick,
    this.suffixEnable=true,
    this.maxLength=50,
    this.horizontal=20,
  });

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  static String _fonts = 'SFPro';
  static String _POORICHfonts = 'POORICH';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: widget.horizontal),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      decoration: BoxDecoration(color: Color(0xFFD6E9EE),borderRadius: BorderRadius.circular(10)),
      child: TextField(
        scrollController: ScrollController(),
        controller: widget.controller,
        keyboardType: widget.textInputType,
        textInputAction: widget.textInputAction,
        textCapitalization:widget.textCapitalization,
        onChanged: (value) => widget.onChanged?.call(value),
        onSubmitted: (value) => widget.onSubmit?.call(value),
        maxLength: widget.maxLength,
        style:TextStyle(color: Colors.black, fontSize: 16, fontFamily: '$_fonts'),
        decoration: InputDecoration(
            hintText: widget.hintText,
            counterText: '',
            counter: null,
            hintStyle: TextStyle( color: Colors.grey, fontSize: 16, fontFamily: '$_fonts'),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(0),
            suffix: widget.suffixEnable? Container(
              width: 100,
              child: TextButton(
                onPressed:widget.suffixText.isNotEmpty? () => widget.onSuffixClick?.call(widget.controller.text):null,
                child: Text(
                    widget.suffixText, style: TextStyle(fontSize: 14,color: Colors.grey),),
              ),
            ):Container(width: 1,height: 1,)
        ),
      ),
    );
  }
}
