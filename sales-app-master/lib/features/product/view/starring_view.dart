import 'package:flutter/material.dart';
import 'package:sales_app/core/constants/app_constants.dart';

class StarringView extends StatefulWidget {
  const StarringView({Key? key, required this.rate, required this.doubleRate})
      : super(key: key);
  final List<Icon> rate;
  final double doubleRate;

  @override
  State<StarringView> createState() => _StarringViewState();
}

class _StarringViewState extends State<StarringView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: widget.rate,
        ),
        Text(
          " ${widget.doubleRate}",
          style: TextStyle(
              color: AppConstants.primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
