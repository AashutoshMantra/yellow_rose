import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final Color color;
  const Loader({super.key, this.color = Colors.black26});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: color,
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: const CupertinoActivityIndicator(
          color: Colors.black87,
          radius: 35,
        ),
      ),
    );
  }
}
