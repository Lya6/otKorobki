import 'package:flutter/material.dart';
import 'package:template_application/main.dart';
import 'package:template_application/viewmodels/region/region_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class ChoiceRegionPage extends StatefulWidget {
  @override
  _ChoiceRegionPageState createState() => _ChoiceRegionPageState();
}

class _ChoiceRegionPageState extends State<ChoiceRegionPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<RegionListViewModel>(context, listen: false).regions();
  }

  @override
  Widget build(BuildContext context) {
    var listViewModel = Provider.of<RegionListViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.color,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Выбрать регион"),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder(
          builder: (context, snapshot) {
            return ListView.builder(
                itemCount: listViewModel.listRegions.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(listViewModel.listRegions[index].name),
                    onTap: () async {
                      print(listViewModel.listRegions[index].id);

                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();

                      preferences.setString(
                          'parentId', listViewModel.listRegions[index].id);

                      preferences.setString(
                          'nameCity', listViewModel.listRegions[index].name);

                      // Navigator.pushAndRemoveUntil(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => MyAppSecond()),
                      //   (Route<dynamic> route) => false,
                      // );

                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return MyAppSecond();
                      }));
                    },
                  );
                });
          },
        ),
      ),
    );
  }
}
