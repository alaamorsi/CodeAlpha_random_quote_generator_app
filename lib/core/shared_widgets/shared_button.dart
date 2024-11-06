import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SharedButton extends StatelessWidget {
  final Color color;
  final String text;
  final IconData? icon;
  final void Function() onPressed;

  const SharedButton(
      {super.key, required this.color, required this.text, this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(color),
          alignment: Alignment.center,
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),side: BorderSide(width: 2.0.sp,color: Colors.white))),
          fixedSize: WidgetStatePropertyAll(Size.fromHeight(45.0.sp))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
                fontSize: 21.0.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
          icon == null
              ? Container()
              : SizedBox(
                  width: 5.0.sp,
                ),
          icon == null
              ? Container()
              : Icon(
                  icon,
                  color: Colors.white,
                ),
        ],
      ),
    );
  }
}
