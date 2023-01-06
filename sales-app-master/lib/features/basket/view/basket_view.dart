import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/core/constants/app_constants.dart';
import 'package:sales_app/features/basket/view_model/basket_view_model.dart';

class BasketView extends StatefulWidget {
  const BasketView({Key? key}) : super(key: key);

  @override
  State<BasketView> createState() => _BasketViewState();
}

class _BasketViewState extends State<BasketView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<BasketViewModel>(context, listen: false).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 50),
        child: Container(
          width: width,
          height: 50,
          decoration: BoxDecoration(
            color: Color(0xffF24E1E),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: width / 3,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Image(
                        color: Colors.white,
                        image: AssetImage(
                          "assets/icons/bagIcon.png",
                        ),
                      ),
                      const Text(
                        " 12.9 \$",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    "Contact the dealer",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 24,
            ),
            const Center(
              child: Text(
                "Basket",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontSize: 22),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const SizedBox(
              height: 8,
            ),
            FutureBuilder(
              future: Provider.of<BasketViewModel>(context).getProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Column(
                    children: Provider.of<BasketViewModel>(context).products,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
