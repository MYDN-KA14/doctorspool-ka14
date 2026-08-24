import 'package:flutter/material.dart';

void main() => runApp(DocPoolApp());

class DocPoolApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DoctorsPool KA14',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedTaluk = 'Shimoga';
  final taluks = ['Shimoga', 'Bhadravati', 'Sagara', 'Thirthahalli', 'Shikaripura'];

  final doctors = [
    {'name': 'Dr. Ravi Kumar', 'spec': 'General Physician', 'taluk': 'Shimoga', 'place': 'Gandhi Bazaar', 'fee': '₹300'},
    {'name': 'Dr. Priya Shetty', 'spec': 'Pediatrician', 'taluk': 'Bhadravati', 'place': 'Old Town', 'fee': '₹400'},
    {'name': 'Dr. Manjunath', 'spec': 'Orthopedist', 'taluk': 'Sagara', 'place': 'Bus Stand Road', 'fee': '₹500'},
  ];

  @override
  Widget build(BuildContext context) {
    var filtered = doctors.where((d) => d['taluk'] == selectedTaluk).toList();
    return Scaffold(
      appBar: AppBar(title: Text('DoctorsPool - KA14 Shimoga'), backgroundColor: Colors.teal),
      body: Column(
        children: [
          Container(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: taluks.map((t) => Padding(
                padding: EdgeInsets.all(8),
                child: ChoiceChip(
                  label: Text(t),
                  selected: selectedTaluk == t,
                  onSelected: (v) => setState(() => selectedTaluk = t),
                ),
              )).toList(),
            ),
          ),
          Expanded(
            child: filtered.isEmpty 
            ? Center(child: Text('No doctors in $selectedTaluk yet.\nAdd via Admin soon!', textAlign: TextAlign.center))
            : ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (c, i) {
                var d = filtered[i];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    leading: Icon(Icons.local_hospital, color: Colors.teal),
                    title: Text(d['name']!),
                    subtitle: Text('${d['spec']} - ${d['place']}'),
                    trailing: Text(d['fee']!, style: TextStyle(fontWeight: FontWeight.bold)),
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Booking for ${d['name']} coming soon!'))),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
