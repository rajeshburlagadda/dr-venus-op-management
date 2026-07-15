import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/patient_model.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  List<Patient> patients = [];

  @override
  void initState() {
    super.initState();
    loadPatients();
  }

  Future<void> loadPatients() async {
    patients = await DatabaseHelper.instance.getAllPatients();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Patient List"),
        backgroundColor: Colors.blue,
      ),
      body: patients.isEmpty
          ? const Center(
              child: Text("No Patients Found", style: TextStyle(fontSize: 18)),
            )
          : ListView.builder(
              itemCount: patients.length,
              itemBuilder: (context, index) {
                final patient = patients[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(patient.name),
                    subtitle: Text(
                      "Age: ${patient.age} | ${patient.gender}\n"
                      "Mobile: ${patient.mobile}",
                    ),
                    isThreeLine: true,
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                );
              },
            ),
    );
  }
}
