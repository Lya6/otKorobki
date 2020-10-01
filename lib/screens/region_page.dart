import 'package:flutter/material.dart';
import 'package:template_application/screens/choice_region_page.dart';
import 'package:template_application/viewmodels/region/region_list_view_model.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class RegionPage extends StatefulWidget {
  @override
  _RegionPageState createState() => _RegionPageState();
}

class _RegionPageState extends State<RegionPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<RegionListViewModel>(context, listen: false).regions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Image(
            image: AssetImage('images/location.png'),
            height: 400,
          ),
          Text(
            "Укажите ваш регион \n (область)",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ChoiceRegionPage()));

          // ChoiceRegionPage();
        },
        label: Text("       ВЫБРАТЬ РЕГИОН       "),
        backgroundColor: Constants.color,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
