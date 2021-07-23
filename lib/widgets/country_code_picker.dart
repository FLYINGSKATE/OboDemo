import 'package:flutter/material.dart';
import 'package:flutter_app/model/countries.dart';


class CountryCodePicker extends StatefulWidget {
  final Color primaryColor;
  const CountryCodePicker({Key? key,this.primaryColor =  Colors.purple}) : super(key: key);

  @override
  _CountryCodePickerState createState() => _CountryCodePickerState();
}

class _CountryCodePickerState extends State<CountryCodePicker> {

  final List<Map<String,dynamic>> ch = [];
  final List<Map<String,dynamic>> all = [];

  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ch.addAll(Countries.country);
    all.addAll(Countries.country);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.50,
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 60,
                height: 8,
                decoration: BoxDecoration(
                  color: Color(0XFFF5F5F5),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10,),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: widget.primaryColor.withOpacity(0.2),
            ),
            child: Container(
              padding: EdgeInsets.only(left: 4),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: TextStyle(
                        fontSize: 14,

                        color: Color(0xFF212121),
                      ),
                      onChanged:_onSearch,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search here..',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF21212180),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 14)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: ch.length,
              itemBuilder: (_, i) => ListTile(
                onTap: (){
                  FocusScope.of(context).unfocus();
                  Future.delayed(Duration(milliseconds: 300));
                  Navigator.of(context).pop(ch[i]);
                },
                leading: CircleAvatar(
                  backgroundColor: widget.primaryColor,
                  radius: 20,
                  child: Text(ch[i]['code'] , style:TextStyle(fontSize: 14,color: Colors.white)),
                ),
                title: Text(ch[i]['name'] , style:TextStyle(fontSize: 14,color: Colors.black87)),
                trailing: Text(ch[i]['dial_code'] , style:TextStyle(fontSize: 14,color: Colors.black87)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onSearch(String key){
    ch.clear();

    all.forEach((element) {
      if(element['name'].toString().toLowerCase().contains('${key.toLowerCase()}')||element['code'].toString().toLowerCase().contains('${key.toLowerCase()}'))
        ch.add(element);
    });

    if(key.length==0){
      ch.addAll(all);
    }

    setState(() {

    });
  }
}
