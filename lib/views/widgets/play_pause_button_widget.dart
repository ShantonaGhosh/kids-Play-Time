import 'package:flutter/material.dart';

class PlayerPlayPauseButton extends StatelessWidget {
  const PlayerPlayPauseButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    this.buttonColor,
    this.iconData,
  }) : super(key: key);

  final Color? buttonColor;
  final String buttonText;
  final IconData? iconData;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: 120,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: buttonColor ?? Colors.deepPurple,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 10),
            Text(
              buttonText,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            Icon(
              iconData ?? Icons.play_arrow,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
