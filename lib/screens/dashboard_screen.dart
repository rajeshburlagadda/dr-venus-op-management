import 'package:flutter/material.dart';
import 'patient_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dr. Venus Institute"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("RAJESH"),
              accountEmail: Text("Administrator"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.local_hospital, color: Colors.blue, size: 40),
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),

            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text("Dashboard"),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.people),
              title: const Text("Patients"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PatientScreen(),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.medical_services),
              title: const Text("Doctors"),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.receipt_long),
              title: const Text("Prescriptions"),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.analytics),
              title: const Text("Reports"),
              onTap: () {},
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: [
            dashboardCard(context, Icons.people, "Patients", Colors.blue, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PatientScreen()),
              );
            }),

            dashboardCard(
              context,
              Icons.medical_services,
              "Doctors",
              Colors.green,
              () {},
            ),

            dashboardCard(
              context,
              Icons.receipt_long,
              "Prescriptions",
              Colors.orange,
              () {},
            ),

            dashboardCard(
              context,
              Icons.medication,
              "Medicines",
              Colors.purple,
              () {},
            ),

            dashboardCard(
              context,
              Icons.analytics,
              "Reports",
              Colors.teal,
              () {},
            ),

            dashboardCard(
              context,
              Icons.settings,
              "Settings",
              Colors.red,
              () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget dashboardCard(
    BuildContext context,
    IconData icon,
    String title,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: color.withOpacity(0.15),
              child: Icon(icon, size: 40, color: color),
            ),

            const SizedBox(height: 15),

            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
