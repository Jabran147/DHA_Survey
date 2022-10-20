import 'package:flutter/material.dart';
import '../utils/api_service.dart';
import '../model/clients_record.dart';
import 'dart:convert';

class CountryDemo extends StatefulWidget {
  const CountryDemo({super.key});

  @override
  State<CountryDemo> createState() => _CountryDemoState();
}

class _CountryDemoState extends State<CountryDemo> {
  bool isSectorSelected = false;
  late List<Welcome>? clientsModel = [];
  late List? allClients = [];
  List<Address> allCities = [];
  String? client;
  String? city;
  @override
  void initState() {
    super.initState();
    _getClients();
  }

  void _getClients() async {
    clientsModel = (await ApiService().getClients());
    print(clientsModel!.length);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rest Api'),
        centerTitle: true,
      ),
      body: clientsModel!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 5),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                          ),
                          isExpanded: true,
                          validator: (value) {
                            if (value == null) {
                              return 'Choose the option from dropdown';
                            } else {
                              return null;
                            }
                          },
                          // underline: Container(),
                          hint: const Text(
                            'Choose option',
                            style: TextStyle(color: Color(0xFFC1C1C1)),
                          ),
                          value: client,
                          // items: phases.map((String value) {
                          //   return DropdownMenuItem(
                          //     value: value,
                          //     child: Text(value),
                          //   );
                          // }).toList(),
                          items: clientsModel!.map((e) {
                            return DropdownMenuItem(
                              value: e.name,
                              child: Text(e.name as String),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              allCities = [];
                              client = value;
                              for (var i = 0; i < clientsModel!.length; i++) {
                                if (clientsModel![i].name == value) {
                                  allCities =
                                      clientsModel![i].address as List<Address>;
                                }
                                print("All the cities $allCities");
                              }
                              isSectorSelected = true;
                            });
                          },
                          icon:
                              const Icon(Icons.arrow_drop_down_circle_outlined),
                          iconEnabledColor: const Color(0xFF0F0A38),
                        ),
                      ),
                    ),
                  ),
                  isSectorSelected
                      ? Expanded(
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                ),
                                isExpanded: true,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Choose the option from dropdown';
                                  } else {
                                    return null;
                                  }
                                },
                                // underline: Container(),
                                hint: const Text(
                                  'Choose option',
                                  style: TextStyle(color: Color(0xFFC1C1C1)),
                                ),
                                value: city,
                                // items: phases.map((String value) {
                                //   return DropdownMenuItem(
                                //     value: value,
                                //     child: Text(value),
                                //   );
                                // }).toList(),
                                items: allCities.map((e) {
                                  return DropdownMenuItem(
                                    value: e.city,
                                    child: Text(e.city as String),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    city = value;
                                  });
                                },
                                icon: const Icon(
                                    Icons.arrow_drop_down_circle_outlined),
                                iconEnabledColor: const Color(0xFF0F0A38),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
    );
  }
}
