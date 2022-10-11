import 'package:dha_cleaning_app/model/maintenance_record.dart';
import 'package:dha_cleaning_app/utils/shared_service.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../widgets/record_tiles.dart';
import './input_screen.dart';
import './login.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // static const namedRoute = '/homepage';
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0F0A38),
          centerTitle: true,
          title: const Text('DHA Maintenance'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Color(0xFF0F0A38)),
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Color(0xFF0F0A38)),
                  accountName: Text(
                    'Ali Nadeem',
                    style: TextStyle(fontSize: 20),
                  ),
                  accountEmail: Text('DHA Number: FFFF2222'),
                  currentAccountPictureSize: Size.square(50),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Color(0xFF003367),
                    child: Text(
                      'A',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.pending_actions,
                  size: 26,
                  color: Color(0xFF0F0A38),
                ),
                title: const Text(
                  'Inprocess complaints',
                  style: TextStyle(color: Color(0xFF0F0A38), fontSize: 16),
                ),
                trailing: const CircleAvatar(
                  radius: 16,
                  backgroundColor: Color(0xFF0F0A38),
                  child: Text('26',
                      style: TextStyle(color: Colors.white, fontSize: 14)),
                ),
                onTap: () => Navigator.of(context).pop(),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.task_alt,
                  size: 26,
                  color: Color(0xFF0F0A38),
                ),
                title: const Text(
                  'Completed complaints',
                  style: TextStyle(color: Color(0xFF0F0A38), fontSize: 16),
                ),
                trailing: const CircleAvatar(
                  radius: 16,
                  backgroundColor: Color(0xFF0F0A38),
                  child: Text('19',
                      style: TextStyle(color: Colors.white, fontSize: 14)),
                ),
                onTap: () => Navigator.of(context).pop(),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.refresh,
                  size: 26,
                  color: Color(0xFF0F0A38),
                ),
                trailing: const CircleAvatar(
                  radius: 16,
                  backgroundColor: Color(0xFF0F0A38),
                  child: Text('0',
                      style: TextStyle(color: Colors.white, fontSize: 14)),
                ),
                title: const Text(
                  'Reopened complaints',
                  style: TextStyle(color: Color(0xFF0F0A38), fontSize: 16),
                ),
                onTap: () => Navigator.of(context).pop(),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                  size: 26,
                  color: Color(0xFF0F0A38),
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Color(0xFF0F0A38), fontSize: 16),
                ),
                onTap: () => SharedService.logout(context),
              ),
            ],
          ),
        ),
        body: ValueListenableBuilder(
          valueListenable:
              Hive.box<MaintenanceRecord>('maintenanceRecord').listenable(),
          builder: ((context, box, _) {
            return SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Image.asset(
                        'assets/img/dha_lahore_logo.png',
                        width: 130,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        'DHA Maintenance',
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 620,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: Column(
                            children: [
                              box.isEmpty
                                  ? Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 150),
                                      child: const Text(
                                        'No Record',
                                        style: TextStyle(fontSize: 32),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 300,
                                      child: Scrollbar(
                                        thumbVisibility: true,
                                        controller: _scrollController,
                                        child: ListView.builder(
                                          controller: _scrollController,
                                          itemCount: box.values.length,
                                          itemBuilder: (context, index) {
                                            MaintenanceRecord
                                                maintenanceRecord =
                                                box.getAt(index)!;
                                            return RecordTiles(
                                                maintenanceRecord, index);
                                          },
                                        ),
                                      ),
                                    ),
                              const SizedBox(
                                height: 40,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF003367),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 0),
                                  ),
                                  child: const Text('Add Complaint'),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                InputScreen())));
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF0F0A38),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 0),
                                  ),
                                  onPressed: null,
                                  child: const Text('Sync Records'),
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
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
