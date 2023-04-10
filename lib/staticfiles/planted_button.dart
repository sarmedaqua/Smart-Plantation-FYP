import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class PlantedButton extends StatelessWidget {
  const PlantedButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      onPressed: () {},
      child: Text(
          'PLANTED',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: (
            Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Color(
                0x980E7911)
        ),
        fixedSize: Size(180, 50),
      ),
    );
  }
}





