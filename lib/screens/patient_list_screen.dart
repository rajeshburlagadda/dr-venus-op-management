import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/patient_model.dart';
import 'patient_screen.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  List<Patient> patients = [];
  List<Patient> filteredPatients = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadPatients();
  }

  Future<void> loadPatients() async {
    patients = await DatabaseHelper.instance.getAllPatients();
    filteredPatients = List.from(patients);
    setState(() {});
  }

  void searchPatients(String value) {
    setState(() {
      filteredPatients = patients.where((patient) {
        return patient.name.toLowerCase().contains(value.toLowerCase()) ||
            patient.mobile.contains(value);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Patient List"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: "Search by Name or Mobile",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: searchPatients,
            ),
          ),

          Expanded(
            child: filteredPatients.isEmpty
                ? const Center(
                    child: Text(
                      "No Patients Found",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredPatients.length,
                    itemBuilder: (context, index) {
                      final patient = filteredPatients[index];
                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: InkWell(
                          onTap: () {
                            print("Tapped patient: ${patient.name}");
                            print("Tapped ID: ${patient.id}");

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PatientScreen(patient: patient),
                              ),
                            );
                          },
                          child: ListTile(
                            leading: const CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                            title: Text(patient.name),
                            subtitle: Text(
                              "Age: ${patient.age} | ${patient.gender}\n"
                              "Mobile: ${patient.mobile}",
                            ),
                            isThreeLine: true,
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ), // ListTile
                        ), // InkWell
                      ); // Card
                    },
                  ),
          ),
        ], // children
      ), // Column
    ); // Scaffold // Column // Scaffold
  }
}
