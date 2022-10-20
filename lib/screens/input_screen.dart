import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../model/maintenance_record.dart';
import '../model/dummy_data.dart';
import '../model/phase_model.dart';
import '../model/phase_record.dart';
import '../utils/api_constants.dart';
import '../utils/api_service.dart';
import '../utils/shared_service.dart';

class InputScreen extends StatefulWidget {
  // static const namedRoute = '/inputScreen';
  MaintenanceRecord? appRecord;

  InputScreen({super.key, this.appRecord});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  var _phases = [];
  var _sectors = [];

  String? phase;
  String? sector;

  final formKey = GlobalKey<FormState>();
  late List<PhaseRecord>? phaseModel = [];
  String btnText = 'Save';
  String? siteStatus;
  bool isCompleted = false;
  String? phaseValue;
  String? sectorValue;
  String? categoryValue;
  String? complaintValue;
  String? lat;
  String? long;
  Map map1 = {};
  bool disabledDropDown = true;
  List<DropdownMenuItem<String>> phaseMenuItem = [];
  List<DropdownMenuItem<String>> categoryMenuItem = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  File? _image1, _image2, _image3, _image4;
  Uint8List? bytes1, bytes2, bytes3, bytes4;
  String? _img1, _img2, _img3, _img4;

  // Box<PhasesRecords>? box1;

  // _getData() async {
  //   phaseModel = (await ApiService().getPhases());
  //   // for (var i = 0; i < phaseModel.length; i++) {
  //   //   map1 = phaseModel![i].docs!.asMap();
  //   // }
  //   print('Phase Map Length: ${phaseModel!.length}');
  //   Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  // }

  Future getPhaseData() async {
    var loginDetails = await SharedService.loginDetails();
    var allPhases = [];
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'x-access-token': loginDetails!.token
    };
    var response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.sectorEndpoint),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      // print('This is the list of jsonResponse: $jsonResponse');
      setState(() {
        allPhases = jsonResponse;
      });
      print('This is the list of phases: $_phases');
    }
  }

  void _getData() async {
    phaseModel = (await ApiService().getPhases());
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

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
    // return null;
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
                Navigator.popUntil(context, (route) => route.isFirst);
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

  Future<void> submitData(
      pVal,
      sVal,
      catVal,
      comVal,
      remark,
      beforeDate,
      afterDate,
      beforeImg1,
      beforeImg2,
      afterImage1,
      afterImage2,
      lat,
      long) async {
    // await Hive.openBox<MaintenanceRecord>('maintenanceRecord');
    final box = Hive.box<MaintenanceRecord>('maintenanceRecord');
    if (widget.appRecord != null) {
      // if (widget.appRecord?.imageAfter1 != null ||
      //     widget.appRecord?.imageAfter2 != null) {
      //   Navigator.of(context).pop();
      // } else {
      widget.appRecord?.status = '1';
      widget.appRecord?.completedAt = afterDate;
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
          createdAt: beforeDate,
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

  void populatePhase(Map<String, String> phaseMap) {
    for (String key in phaseMap.keys) {
      phaseMenuItem.add(
        DropdownMenuItem(
          value: phaseMap[key],
          child: Text(phaseMap[key] as String),
        ),
      );
    }
  }

  void populateCategory(Map<String, String> categoryMap) {
    for (String key in categoryMap.keys) {
      categoryMenuItem.add(
        DropdownMenuItem(
          value: categoryMap[key],
          child: Text(categoryMap[key] as String),
        ),
      );
    }
  }

  void phaseValChange(value) {
    if (value == '1') {
      phaseMenuItem = [];
      populatePhase(phase1);
    } else if (value == '2') {
      phaseMenuItem = [];
      populatePhase(phase2);
    } else if (value == '3') {
      phaseMenuItem = [];
      populatePhase(phase3);
    } else if (value == '4') {
      phaseMenuItem = [];
      populatePhase(phase4);
      // populatePhase4();
    } else if (value == '5') {
      phaseMenuItem = [];
      populatePhase(phase5);
    } else if (value == '6') {
      phaseMenuItem = [];
      populatePhase(phase6);
    } else if (value == '7') {
      phaseMenuItem = [];
      populatePhase(phase7);
    } else if (value == '8') {
      phaseMenuItem = [];
      populatePhase(phase8);
    } else if (value == '9') {
      phaseMenuItem = [];
      populatePhase(phase9);
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
      populateCategory(admin);
    } else if (value == 'Building & Roads') {
      categoryMenuItem = [];
      populateCategory(building);
    } else if (value == 'Mechanical') {
      categoryMenuItem = [];
      populateCategory(mechanical);
    } else if (value == 'Electrical') {
      categoryMenuItem = [];
      populateCategory(electrical);
    } else if (value == 'Sewerage') {
      categoryMenuItem = [];
      populateCategory(sewerage);
    } else if (value == 'Water Supply') {
      categoryMenuItem = [];
      populateCategory(watersupply);
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
    getPhaseData();
    // _getData();
    // submitPhasesRecord();
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
        actions: [
          IconButton(onPressed: null, icon: Icon(Icons.safety_check)),
        ],
      ),
      body: _phases.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
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
                            // items: _phases.map((e) {
                            //   return DropdownMenuItem(
                            //     child: Text(e["Docs"]),
                            //     value: e["Docs"],
                            //   );
                            // }).toList(),
                            onChanged: widget.appRecord != null
                                ? null
                                : (value) => phaseValChange(value),
                            icon: const Icon(
                                Icons.arrow_drop_down_circle_outlined),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
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
                            icon: const Icon(
                                Icons.arrow_drop_down_circle_outlined),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
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
                            icon: const Icon(
                                Icons.arrow_drop_down_circle_outlined),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
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
                            icon: const Icon(
                                Icons.arrow_drop_down_circle_outlined),
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
                                    child: Image.memory(
                                        base64Decode(widget
                                            .appRecord!.imageBefore1
                                            .toString()),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Container(
                                  height: 165,
                                  width: 165,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.memory(
                                        base64Decode(widget
                                            .appRecord!.imageBefore2
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
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: IconButton(
                                          icon: const Icon(
                                              Icons.camera_alt_outlined),
                                          onPressed: () {
                                            captureImage1();
                                          },
                                        ),
                                      )
                                    : Container(
                                        height: 165,
                                        width: 165,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          child: Image.memory(
                                            base64Decode(_img1!.toString()),
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
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: IconButton(
                                          icon: const Icon(
                                              Icons.camera_alt_outlined),
                                          onPressed: () {
                                            captureImage2();
                                          },
                                        ),
                                      )
                                    : Container(
                                        height: 165,
                                        width: 165,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          child: Image.memory(
                                              base64Decode(_img2!.toString()),
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
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              child: Image.memory(
                                                  base64Decode(widget
                                                      .appRecord!.imageAfter1
                                                      .toString()),
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          Container(
                                            height: 165,
                                            width: 165,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              child: Image.memory(
                                                  base64Decode(widget
                                                      .appRecord!.imageAfter2
                                                      .toString()),
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
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
                                                    color:
                                                        const Color(0xFFC3C3C3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: IconButton(
                                                    icon: const Icon(Icons
                                                        .camera_alt_outlined),
                                                    onPressed: () {
                                                      captureImage3();
                                                    },
                                                  ),
                                                )
                                              : SizedBox(
                                                  height: 165,
                                                  width: 165,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    child: Image.memory(
                                                      base64Decode(
                                                          _img3!.toString()),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                          _img4 == null
                                              ? Container(
                                                  height: 165,
                                                  width: 165,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFC3C3C3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: IconButton(
                                                    icon: const Icon(Icons
                                                        .camera_alt_outlined),
                                                    onPressed: () {
                                                      captureImage4();
                                                    },
                                                  ),
                                                )
                                              : SizedBox(
                                                  height: 165,
                                                  width: 165,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    child: Image.memory(
                                                        base64Decode(
                                                            _img4!.toString()),
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                        ],
                                      ),
                              ],
                            ),
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
                                              .format(DateTime.now()),
                                          DateFormat.yMMMMd()
                                              .add_jm()
                                              .format(DateTime.now()),
                                          _img1,
                                          _img2,
                                          _img3,
                                          _img4,
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
                                              .format(DateTime.now()),
                                          DateFormat.yMMMMd()
                                              .add_jm()
                                              .format(DateTime.now()),
                                          _img1,
                                          _img2,
                                          _img3,
                                          _img4,
                                          lat,
                                          long);
                                      Navigator.of(context).pop();
                                    }
                                  }
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
