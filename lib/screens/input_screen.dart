import 'dart:convert';
import 'dart:typed_data';

import 'package:dha_cleaning_app/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import '../model/maintenance_record.dart';
import './homepage.dart';

class InputScreen extends StatefulWidget {
  static const namedRoute = '/inputScreen';
  MaintenanceRecord? appRecord;

  InputScreen({super.key, this.appRecord});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final formKey = GlobalKey<FormState>();
  String btnText = 'Save';
  String? siteStatus;
  bool isCompleted = false;
  String? phaseValue;
  String? sectorValue;
  String? categoryValue;
  String? complaintValue;
  String? lat;
  String? long;
  bool disabledDropDown = true;
  List<DropdownMenuItem<String>> phaseMenuItem = [];
  List<DropdownMenuItem<String>> categoryMenuItem = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  File? _image1, _image2, _image3, _image4;
  Uint8List? bytes1, bytes2, bytes3, bytes4;
  String? _img1, _img2, _img3, _img4;

  // File? _image2;
  // Uint8List? bytes2;
  // String? _img2;

  // File? _image3;
  // Uint8List? bytes3;
  // String? _img3;

  // File? _image4;
  // Uint8List? bytes4;
  // String? _img4;

  // List<XFile> _image = [];
  // List imagesAsBytes = [];
  // MaintenanceRecord obj = MaintenanceRecord();
  // XFile? _img1;
  // XFile? _img2;
  // XFile? _img3;
  // XFile? _img4;

  Future<void> captureImage1() async {
    var picker = ImagePicker();
    PickedFile? image;
    image = await picker.getImage(source: ImageSource.camera);
    if (image!.path.isEmpty == false) {
      setState(() {
        _image1 = File(image!.path);
      });
    }
    bytes1 = File(_image1!.path).readAsBytesSync();
    _img1 = base64Encode(bytes1!);
  }

  Future<void> captureImage2() async {
    var picker = ImagePicker();
    PickedFile? image;
    image = await picker.getImage(source: ImageSource.camera);
    if (image!.path.isEmpty == false) {
      setState(() {
        _image2 = File(image!.path);
      });
    }
    bytes2 = File(_image2!.path).readAsBytesSync();
    _img2 = base64Encode(bytes2!);
  }

  Future<void> captureImage3() async {
    var picker = ImagePicker();
    PickedFile? image;
    image = await picker.getImage(source: ImageSource.camera);
    if (image!.path.isEmpty == false) {
      setState(() {
        _image3 = File(image!.path);
      });
    }
    bytes3 = File(_image3!.path).readAsBytesSync();
    _img3 = base64Encode(bytes3!);
  }

  Future<void> captureImage4() async {
    var picker = ImagePicker();
    PickedFile? image;
    image = await picker.getImage(source: ImageSource.camera);
    if (image!.path.isEmpty == false) {
      setState(() {
        _image4 = File(image!.path);
      });
    }
    bytes4 = File(_image4!.path).readAsBytesSync();
    _img4 = base64Encode(bytes4!);
  }

  // Future<void> captureImage1() async {
  //   final image1 =
  //       await ImagePicker.platform.getImage(source: ImageSource.camera);

  //   // await ImagePicker.platform.getMultiImage();
  //   if (image1 != null) {
  //     setState(() => _img1 = image1);
  //   }
  // }

  // Future<void> captureImage2() async {
  //   final image2 =
  //       await ImagePicker.platform.getImage(source: ImageSource.camera);
  //   // await ImagePicker.platform.getMultiImage();
  //   if (image2 != null) {
  //     setState(() => _img2 = image2);
  //   }
  // }

  // Future<void> captureImage3() async {
  //   final image3 =
  //       await ImagePicker.platform.getImage(source: ImageSource.camera);
  //   // await ImagePicker.platform.getMultiImage();
  //   if (image3 != null) {
  //     setState(() => _img3 = image3);
  //   }
  // }

  // Future<void> captureImage4() async {
  //   final image4 =
  //       await ImagePicker.platform.getImage(source: ImageSource.camera);
  //   // await ImagePicker.platform.getMultiImage();
  //   if (image4 != null) {
  //     setState(() => _img4 = image4);
  //   }
  // }

  // Future<void> captureImage() async {
  //   final List<XFile> image =
  //       // await ImagePicker.platform.getImage(source: ImageSource.camera);
  //       await ImagePicker.platform.getMultiImage() ?? [];

  //   if (image.isNotEmpty) {
  //     setState(() => _image.addAll(image));
  //   }
  //   // for (var i in _image) {
  //   //   File file = File(i.path);
  //   //   imagesAsBytes.add(file.readAsBytesSync());
  //   // }
  //   // obj.imageUrl = imagesAsBytes.cast<Uint8List>();

  //   print('Image list length: ${_image.length}');
  // }

  Future<Position?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error(showError());
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(showError());
      }
    }
    if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      return Future.error(showError());
    }
    Position currentPostion = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    setState(() {
      lat = currentPostion.latitude.toString();
      long = currentPostion.longitude.toString();
    });
  }

  Future<void> showError() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Please configure the location services.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Dismiss'),
              onPressed: () {
                Navigator.of(context).popAndPushNamed(HomePage.namedRoute);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialog1() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Please choose the images first'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Dismiss'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> submitData(pVal, sVal, catVal, comVal, remark, date, beforeImg1,
      beforeImg2, afterImage1, afterImage2, lat, long) async {
    // await Hive.openBox<MaintenanceRecord>('maintenanceRecord');
    final box = Hive.box<MaintenanceRecord>('maintenanceRecord');
    if (widget.appRecord != null) {
      // if (widget.appRecord?.imageAfter1 != null ||
      //     widget.appRecord?.imageAfter2 != null) {
      //   Navigator.of(context).pop();
      // } else {
      widget.appRecord?.status = '1';
      widget.appRecord?.imageAfter1 = afterImage1;
      widget.appRecord?.imageAfter2 = afterImage2;
      widget.appRecord?.save();

      // }
    } else {
      await box.add(
        MaintenanceRecord(
          phase: pVal,
          sector: sVal,
          category: catVal,
          complainType: comVal,
          // status: status,
          remarks: remark,
          createdAt: date,
          imageBefore1: beforeImg1,
          imageBefore2: beforeImg2,
          imageAfter1: afterImage1,
          imageAfter2: afterImage2,
          lat: lat,
          long: long,
        ),
      );
      Navigator.of(context).pop();
    }
  }

  List<String> phases = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
  ];
  List<String> categories = [
    'Admin',
    'Building & Roads',
    'Mechanical',
    'Electrical',
    'Sewerage',
    'Water Supply',
  ];
  final admin = {
    '1': 'Garbage Basket',
    '2': 'Garbage Bags',
    '3': 'Waste Management',
    '4': 'Debris & Wild Growth',
    '5': 'Dengue Spray',
    '6': 'Cleaning of Plots',
  };
  final building = {
    '1': 'Painting & Sign Writing',
    '2': 'Wood Work / Carpenting',
    '3': 'Welding Works',
    '4': 'Masonary',
    '5': 'Road Repair & Patch Work',
  };
  final mechanical = {
    '1': 'Gen Sets',
    '2': 'Motor Winding',
    '3': 'SDSs / TWs Motor Winding',
  };
  final electrical = {
    '1': 'Street Lights',
    '2': 'Parks',
    '3': 'Masajids & Offrs Accn',
    '4': 'Family Qtrs & SM Accn',
    '5': 'ACs',
    '6': 'Tubewells',
    '7': 'Traffic Signals',
    '8': 'Sound Sys',
    '9': 'UPS Sys',
    '10': 'U/G Elect',
  };
  final sewerage = {
    '1': 'Line Blockage',
    '2': 'Sew Connection',
    '3': 'Main Hole Cover',
    '4': 'Septic Tank Cleaning',
    '5': 'Connection Replacement',
  };
  final watersupply = {
    '1': 'New / Replacement Connection',
    '2': 'Line Leakage',
    '3': 'Low Pressure',
  };

  final phase1 = {
    '1': 'Sector A',
    '2': 'Sector B',
    '3': 'Sector C',
    '4': 'Sector D',
    '5': 'Sector E',
    '6': 'Sector F',
    '7': 'Sector G',
    '8': 'Sector H',
    '9': 'Sector J',
    '10': 'Sector K',
    '11': 'Sector L',
    '12': 'Sector M',
    '13': 'Sector N',
    '14': 'Sector P',
  };
  final phase2 = {
    '1': 'Sector Q',
    '2': 'Sector R',
    '3': 'Sector S',
    '4': 'Sector T',
    '5': 'Sector U',
    '6': 'Sector V',
  };
  final phase3 = {
    '1': 'Sector W',
    '2': 'Sector X',
    '3': 'Sector Y',
    '4': 'Sector Z',
    '5': 'Sector XX',
  };
  final phase4 = {
    '1': 'Sector AA',
    '2': 'Sector BB',
    '3': 'Sector CC',
    '4': 'Sector DD',
    '5': 'Sector EE',
    '6': 'Sector FF',
    '7': 'Sector GG',
    '8': 'Sector HH',
    '9': 'Sector JJ',
    '10': 'Sector KK',
  };
  final phase5 = {
    '1': 'Sector A',
    '2': 'Sector B',
    '3': 'Sector C',
    '4': 'Sector D',
    '5': 'Sector E',
    '6': 'Sector F',
    '7': 'Sector G',
    '8': 'Sector H',
    '9': 'Sector J',
    '10': 'Sector K',
    '11': 'Sector L',
    '12': 'Sector M',
  };

  void populatePhase1() {
    for (String key in phase1.keys) {
      phaseMenuItem.add(
        DropdownMenuItem(
          value: phase1[key],
          child: Text(phase1[key] as String),
        ),
      );
    }
  }

  void populatePhase2() {
    for (String key in phase2.keys) {
      phaseMenuItem.add(
        DropdownMenuItem(
          value: phase2[key],
          child: Text(phase2[key] as String),
        ),
      );
    }
  }

  void populatePhase3() {
    for (String key in phase3.keys) {
      phaseMenuItem.add(
        DropdownMenuItem(
          value: phase3[key],
          child: Text(phase3[key] as String),
        ),
      );
    }
  }

  void populatePhase4() {
    for (String key in phase4.keys) {
      phaseMenuItem.add(
        DropdownMenuItem(
          value: phase4[key],
          child: Text(phase4[key] as String),
        ),
      );
    }
  }

  void populatePhase5() {
    for (String key in phase5.keys) {
      phaseMenuItem.add(
        DropdownMenuItem(
          value: phase5[key],
          child: Text(phase5[key] as String),
        ),
      );
    }
  }

  void populateAdmin() {
    for (String key in admin.keys) {
      categoryMenuItem.add(
        DropdownMenuItem(
          value: admin[key],
          child: Text(admin[key] as String),
        ),
      );
    }
  }

  void populateBuilding() {
    for (String key in building.keys) {
      categoryMenuItem.add(
        DropdownMenuItem(
          value: building[key],
          child: Text(building[key] as String),
        ),
      );
    }
  }

  void populateMechanical() {
    for (String key in mechanical.keys) {
      categoryMenuItem.add(
        DropdownMenuItem(
          value: mechanical[key],
          child: Text(mechanical[key] as String),
        ),
      );
    }
  }

  void populateElectrical() {
    for (String key in electrical.keys) {
      categoryMenuItem.add(
        DropdownMenuItem(
          value: electrical[key],
          child: Text(electrical[key] as String),
        ),
      );
    }
  }

  void populateSewerage() {
    for (String key in sewerage.keys) {
      categoryMenuItem.add(
        DropdownMenuItem(
          value: sewerage[key],
          child: Text(sewerage[key] as String),
        ),
      );
    }
  }

  void populateWaterSupply() {
    for (String key in watersupply.keys) {
      categoryMenuItem.add(
        DropdownMenuItem(
          value: watersupply[key],
          child: Text(watersupply[key] as String),
        ),
      );
    }
  }

  void phaseValChange(value) {
    if (value == '1') {
      phaseMenuItem = [];
      populatePhase1();
    } else if (value == '2') {
      phaseMenuItem = [];
      populatePhase2();
    } else if (value == '3') {
      phaseMenuItem = [];
      populatePhase3();
    } else if (value == '4') {
      phaseMenuItem = [];
      populatePhase4();
    } else if (value == '5') {
      phaseMenuItem = [];
      populatePhase5();
    }
    setState(() {
      sectorValue = null;
      phaseValue = value;
      disabledDropDown = false;
    });
  }

  void categoryValChange(value) {
    if (value == 'Admin') {
      categoryMenuItem = [];
      populateAdmin();
    } else if (value == 'Building & Roads') {
      categoryMenuItem = [];
      populateBuilding();
    } else if (value == 'Mechanical') {
      categoryMenuItem = [];
      populateMechanical();
    } else if (value == 'Electrical') {
      categoryMenuItem = [];
      populateElectrical();
    } else if (value == 'Sewerage') {
      categoryMenuItem = [];
      populateSewerage();
    } else if (value == 'Water Supply') {
      categoryMenuItem = [];
      populateWaterSupply();
    }
    setState(() {
      complaintValue = null;
      categoryValue = value;
      disabledDropDown = false;
    });
  }

  void sectorValChange(value) {
    setState(() {
      sectorValue = value;
    });
  }

  void complaintValChange(value) {
    setState(() {
      complaintValue = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController remarksController = TextEditingController(
        text: widget.appRecord == null ? null : widget.appRecord!.remarks);
    TextEditingController statusController = TextEditingController(
        text: widget.appRecord?.status == '1' ? 'Completed' : 'Inprocess');
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0A38),
        centerTitle: true,
        title: Text(widget.appRecord == null ? 'Add Record' : 'View Record'),
      ),
      body: SingleChildScrollView(
          child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Image.asset(
                  'assets/img/dha_lahore_logo.png',
                  width: 100,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'DHA Maintenance',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Phase',
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFC1C1C1),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                      disabledHint: widget.appRecord == null
                          ? null
                          : Text(widget.appRecord!.phase!),
                      value: phaseValue,
                      items: phases.map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: widget.appRecord != null
                          ? null
                          : (value) => phaseValChange(value),
                      icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                      iconEnabledColor: const Color(0xFF0F0A38),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Sector',
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFC1C1C1),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Choose the option from dropdown';
                        } else {
                          return null;
                        }
                      },
                      isExpanded: true,
                      hint: const Text(
                        'Choose option',
                        style: TextStyle(color: Color(0xFFC1C1C1)),
                      ),
                      disabledHint: widget.appRecord == null
                          ? const Text(
                              'Select the phase first',
                              style: TextStyle(color: Color(0xFFC1C1C1)),
                            )
                          : Text(widget.appRecord!.sector!),
                      value: sectorValue,
                      items: phaseMenuItem,
                      onChanged: disabledDropDown
                          ? null
                          : (value) => sectorValChange(value),
                      icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                      iconEnabledColor: const Color(0xFF0F0A38),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Category',
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFC1C1C1),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                      hint: const Text(
                        'Choose option',
                        style: TextStyle(color: Color(0xFFC1C1C1)),
                      ),
                      disabledHint: widget.appRecord == null
                          ? null
                          : Text(widget.appRecord!.category!),
                      value: categoryValue,
                      items: categories.map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: widget.appRecord != null
                          ? null
                          : (value) => categoryValChange(value),
                      icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                      iconEnabledColor: const Color(0xFF0F0A38),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Complaint Type',
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFC1C1C1),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Choose the option from dropdown';
                        } else {
                          return null;
                        }
                      },
                      isExpanded: true,
                      hint: const Text(
                        'Choose option',
                        style: TextStyle(color: Color(0xFFC1C1C1)),
                      ),
                      disabledHint: widget.appRecord == null
                          ? const Text(
                              'Choose option',
                              style: TextStyle(color: Color(0xFFC1C1C1)),
                            )
                          : Text(widget.appRecord!.complainType!),
                      value: complaintValue,
                      items: categoryMenuItem,
                      onChanged: disabledDropDown
                          ? null
                          : (value) => complaintValChange(value),
                      icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                      iconEnabledColor: const Color(0xFF0F0A38),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Status',
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  readOnly: true,
                  controller: statusController,
                  cursorColor: const Color(0xFF0F0A38),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFe9ecef),
                    labelText: 'Site Status',
                    labelStyle: TextStyle(
                      color: Color(0xFFC3C3C3),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFC3C3C3),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF0F0A38),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Before',
                      textAlign: TextAlign.start,
                    )),
                const SizedBox(
                  height: 8,
                ),
                widget.appRecord != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 165,
                            width: 165,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.file(
                                  File(widget.appRecord!.imageBefore1
                                      .toString()),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Container(
                            height: 165,
                            width: 165,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.file(
                                  File(widget.appRecord!.imageBefore2
                                      .toString()),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _img1 == null
                              ? Container(
                                  height: 165,
                                  width: 165,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFC3C3C3),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.camera_alt_outlined),
                                    onPressed: () {
                                      captureImage1();
                                    },
                                  ),
                                )
                              : Container(
                                  height: 165,
                                  width: 165,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.file(
                                      File(_img1!.path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                          _img2 == null
                              ? Container(
                                  height: 165,
                                  width: 165,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFC3C3C3),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.camera_alt_outlined),
                                    onPressed: () {
                                      captureImage2();
                                    },
                                  ),
                                )
                              : Container(
                                  height: 165,
                                  width: 165,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.file(File(_img2!.path),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                        ],
                      ),
                widget.appRecord == null
                    ? Container()
                    : Column(
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          const SizedBox(
                              width: double.infinity,
                              child: Text(
                                'After',
                                textAlign: TextAlign.start,
                              )),
                          const SizedBox(
                            height: 8,
                          ),
                          widget.appRecord?.imageAfter1 != null ||
                                  widget.appRecord?.imageAfter2 != null
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 165,
                                      width: 165,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Image.file(
                                            File(widget.appRecord!.imageAfter1
                                                .toString()),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    Container(
                                      height: 165,
                                      width: 165,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Image.file(
                                            File(widget.appRecord!.imageAfter2
                                                .toString()),
                                            fit: BoxFit.cover),
                                      ),
                                    ),

                                    // widget.appRecord!.imageAfter1 != null
                                    //     ? Container(
                                    //         height: 80,
                                    //         width: 80,
                                    //         child: ClipRRect(
                                    //           borderRadius: BorderRadius.circular(4),
                                    //           child: Image.file(
                                    //               File(widget.appRecord!.imageAfter1
                                    //                   .toString()),
                                    //               fit: BoxFit.cover),
                                    //         ),
                                    //       )
                                    //     : const Placeholder(
                                    //         fallbackHeight: 10,
                                    //         fallbackWidth: 10,
                                    //       ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _img3 == null
                                        ? Container(
                                            height: 165,
                                            width: 165,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFC3C3C3),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: IconButton(
                                              icon: const Icon(
                                                  Icons.camera_alt_outlined),
                                              onPressed: () {
                                                captureImage3();
                                              },
                                            ),
                                          )
                                        : Container(
                                            height: 165,
                                            width: 165,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              child: Image.file(
                                                File(_img3!.path),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                    _img4 == null
                                        ? Container(
                                            height: 165,
                                            width: 165,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFC3C3C3),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: IconButton(
                                              icon: const Icon(
                                                  Icons.camera_alt_outlined),
                                              onPressed: () {
                                                captureImage4();
                                              },
                                            ),
                                          )
                                        : Container(
                                            height: 165,
                                            width: 165,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              child: Image.file(
                                                  File(_img4!.path),
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                  ],
                                ),
                        ],
                      ),
                // widget.appRecord!.status == "1"
                //     ? Container()
                // Column(
                //   children: [
                //     const SizedBox(
                //       height: 12,
                //     ),
                //     const SizedBox(
                //         width: double.infinity,
                //         child: Text(
                //           'After',
                //           textAlign: TextAlign.start,
                //         )),
                //     const SizedBox(
                //       height: 8,
                //     ),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         _img3 == null
                //             ? Container(
                //                 height: 165,
                //                 width: 165,
                //                 decoration: BoxDecoration(
                //                   color: const Color(0xFFC3C3C3),
                //                   borderRadius: BorderRadius.circular(4),
                //                 ),
                //                 child: IconButton(
                //                   icon: const Icon(Icons.camera_alt_outlined),
                //                   onPressed: () {
                //                     captureImage3();
                //                   },
                //                 ),
                //               )
                //             : Container(
                //                 height: 165,
                //                 width: 165,
                //                 child: ClipRRect(
                //                   borderRadius: BorderRadius.circular(4),
                //                   child: Image.file(File(_img3!.path),
                //                       fit: BoxFit.cover),
                //                 )),
                //         _img4 == null
                //             ? Container(
                //                 height: 165,
                //                 width: 165,
                //                 decoration: BoxDecoration(
                //                   color: const Color(0xFFC3C3C3),
                //                   borderRadius: BorderRadius.circular(4),
                //                 ),
                //                 child: IconButton(
                //                   icon: const Icon(Icons.camera_alt_outlined),
                //                   onPressed: () {
                //                     captureImage4();
                //                   },
                //                 ),
                //               )
                //             : Container(
                //                 height: 165,
                //                 width: 165,
                //                 child: ClipRRect(
                //                   borderRadius: BorderRadius.circular(4),
                //                   child: Image.file(File(_img4!.path),
                //                       fit: BoxFit.cover),
                //                 ),
                //               ),
                //       ],
                //     )

                //     widget.appRecord != null
                //         ? Row(
                //             mainAxisAlignment:
                //                 MainAxisAlignment.spaceBetween,
                //             children: [
                //               Container(
                //                 height: 165,
                //                 width: 165,
                //                 child: ClipRRect(
                //                   borderRadius: BorderRadius.circular(4),
                //                   child: Image.file(
                //                       File(widget.appRecord!.imageAfter1
                //                           .toString()),
                //                       fit: BoxFit.cover),
                //                 ),
                //               ),
                //               Container(
                //                 height: 165,
                //                 width: 165,
                //                 child: ClipRRect(
                //                   borderRadius: BorderRadius.circular(4),
                //                   child: Image.file(
                //                       File(widget.appRecord!.imageAfter2
                //                           .toString()),
                //                       fit: BoxFit.cover),
                //                 ),
                //               ),
                //             ],
                //           )
                //         : Row(
                //             mainAxisAlignment:
                //                 MainAxisAlignment.spaceBetween,
                //             children: [
                //               _img3 == null
                //                   ? Container(
                //                       height: 165,
                //                       width: 165,
                //                       decoration: BoxDecoration(
                //                         color: const Color(0xFFC3C3C3),
                //                         borderRadius:
                //                             BorderRadius.circular(4),
                //                       ),
                //                       child: IconButton(
                //                         icon: const Icon(
                //                             Icons.camera_alt_outlined),
                //                         onPressed: () {
                //                           captureImage3();
                //                         },
                //                       ),
                //                     )
                //                   : Container(
                //                       height: 165,
                //                       width: 165,
                //                       child: ClipRRect(
                //                         borderRadius:
                //                             BorderRadius.circular(4),
                //                         child: Image.file(
                //                           File(_img3!.path),
                //                           fit: BoxFit.cover,
                //                         ),
                //                       ),
                //                     ),
                //               _img4 == null
                //                   ? Container(
                //                       height: 165,
                //                       width: 165,
                //                       decoration: BoxDecoration(
                //                         color: const Color(0xFFC3C3C3),
                //                         borderRadius:
                //                             BorderRadius.circular(4),
                //                       ),
                //                       child: IconButton(
                //                         icon: const Icon(
                //                             Icons.camera_alt_outlined),
                //                         onPressed: () {
                //                           captureImage4();
                //                         },
                //                       ),
                //                     )
                //                   : Container(
                //                       height: 165,
                //                       width: 165,
                //                       child: ClipRRect(
                //                         borderRadius:
                //                             BorderRadius.circular(4),
                //                         child: Image.file(
                //                             File(_img4!.path),
                //                             fit: BoxFit.cover),
                //                       ),
                //                     ),
                //             ],
                //           ),
                //   ],
                // ),

                // if (widget.appRecord == null)
                // Row(children: [
                //   // _image.isEmpty
                //   widget.appRecord != null
                //       ? Row(
                //           children: [
                //             Container(
                //               height: 80,
                //               width: 80,
                //               child: ClipRRect(
                //                 borderRadius: BorderRadius.circular(4),
                //                 child: Image.file(
                //                   File(widget.appRecord!.imageUrl.toString()),
                //                 ),
                //               ),
                //             ),
                //           ],
                //         )
                //       : _image.isEmpty
                //           ? const Placeholder(
                //               fallbackHeight: 80,
                //               fallbackWidth: 80,
                //             )
                //           : Expanded(
                //               child: GridView(
                //                 shrinkWrap: true,
                //                 gridDelegate:
                //                     const SliverGridDelegateWithMaxCrossAxisExtent(
                //                         childAspectRatio: 2 / 2,
                //                         crossAxisSpacing: 4,
                //                         maxCrossAxisExtent: 100),
                //                 children: _image
                //                     .map(
                //                       ((e) => ClipRRect(
                //                             borderRadius:
                //                                 BorderRadius.circular(4),
                //                             child: Image.file(
                //                               File(e.path),
                //                               fit: BoxFit.cover,
                //                             ),
                //                           )),
                //                     )
                //                     .toList(),
                //                 // ClipRRect(
                //                 //   borderRadius: BorderRadius.circular(4),
                //                 //   child: Image.file(
                //                 //     File(_image![index].path),
                //                 //     fit: BoxFit.cover,
                //                 //   ),
                //                 // );
                //               ),
                //             ),
                //   // widget.appRecord != null
                //   //     ? Row(
                //   //         children: [
                //   //           Container(
                //   //             height: 80,
                //   //             width: 80,
                //   //             child: ClipRRect(
                //   //               borderRadius: BorderRadius.circular(4),
                //   //               child: Image.file(
                //   //                 File(widget.appRecord!.imageUrl.toString()),
                //   //               ),
                //   //             ),
                //   //           ),
                //   //         ],
                //   //       )
                //   //     : Text('No Image'),
                // ]),
                // if (widget.appRecord != null)
                // const SizedBox(
                //           width: 80, height: 80, child: ),
                // const SizedBox(
                //   height: 20,
                // ),
                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: const Color(0xFF0F0A38),
                //       padding: const EdgeInsets.symmetric(
                //           vertical: 18, horizontal: 0),
                //     ),
                //     onPressed: () async {
                //       captureImage();
                //     },
                //     child: const Text(
                //       'Take Picture',
                //       style: TextStyle(fontSize: 18),
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 12,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Remarks',
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[a-z A-Z 0-9]+$').hasMatch(value)) {
                      return 'Enter correct remarks';
                    } else {
                      return null;
                    }
                  },
                  readOnly: widget.appRecord != null ? true : false,
                  keyboardType: TextInputType.text,
                  controller: remarksController,
                  maxLines: 4,
                  cursorColor: const Color(0xFF0F0A38),
                  decoration: const InputDecoration(
                    labelText: 'Enter your remarks',
                    labelStyle: TextStyle(
                      color: Color(0xFFC3C3C3),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFC3C3C3),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF0F0A38),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F0A38),
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 0),
                    ),
                    onPressed: widget.appRecord?.imageAfter1 != null ||
                            widget.appRecord?.imageAfter2 != null
                        ? null
                        : () {
                            if (widget.appRecord == null) {
                              if (formKey.currentState!.validate()) {
                                const snackbar = SnackBar(
                                  content: Text('Data Submitted'),
                                  duration: Duration(seconds: 2),
                                  behavior: SnackBarBehavior.floating,
                                );
                                if (_img1 == null || _img2 == null) {
                                  _showMyDialog1();
                                } else {
                                  submitData(
                                    phaseValue?.trim(),
                                    sectorValue?.trim(),
                                    categoryValue?.trim(),
                                    complaintValue?.trim(),
                                    // '0',
                                    remarksController.text.trim(),
                                    DateFormat.yMMMMd()
                                        .add_jm()
                                        .format(DateTime.now())
                                        .trim(),
                                    _img1?.path,
                                    _img2?.path,
                                    _img3?.path,
                                    _img4?.path,
                                    lat,
                                    long,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackbar);
                                }
                              }
                            } else {
                              if (_img3 == null || _img4 == null) {
                                _showMyDialog1();
                              } else {
                                submitData(
                                    phaseValue?.trim(),
                                    sectorValue?.trim(),
                                    categoryValue?.trim(),
                                    complaintValue?.trim(),
                                    // '0',
                                    remarksController.text.trim(),
                                    DateFormat.yMMMMd()
                                        .add_jm()
                                        .format(DateTime.now())
                                        .trim(),
                                    _img1?.path,
                                    _img2?.path,
                                    _img3?.path,
                                    _img4?.path,
                                    lat,
                                    long);
                                Navigator.of(context).pop();
                              }
                            }
                            // Navigator.of(context).pop();
                            // print('Image Lenght + ${_image.length}');
                            // }
                            // }
                            // if (_image.isEmpty) {
                            //   Navigator.of(context).pop();
                            // } else {
                            // }
                          },
                    child: Text(
                      widget.appRecord == null ? 'Save' : 'Complete',
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Image.asset(
                  'assets/img/pitb_logo.png',
                  width: 40,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Powered By PITB'),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
