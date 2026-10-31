import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const FinoUzApp());
}

class FinoUzApp extends StatelessWidget {
  const FinoUzApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FinoUz',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFEFEFEF),
      ),
      home: const HomeScreen(),
    );
  }
}

class Transaction {
  final String category;
  final double amount;
  final bool isIncome;
  final DateTime date;

  Transaction({required this.category, required this.amount, required this.isIncome, required this.date});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isListView = false;
  double balance = 17159330.00;

  List<Transaction> transactions = [
    Transaction(category: 'Зарплата (Oylik)', amount: 12048682.00, isIncome: true, date: DateTime(2026, 10, 30)),
    Transaction(category: 'Депозиты (Depozit)', amount: 630000.00, isIncome: true, date: DateTime(2026, 10, 30)),
    Transaction(category: 'Связь (Aloqa)', amount: 237150.00, isIncome: false, date: DateTime(2026, 10, 31)),
    Transaction(category: 'Еда (Ovqat)', amount: 36000.00, isIncome: false, date: DateTime(2026, 10, 31)),
    Transaction(category: 'Жилье (Uy-joy)', amount: 5370461.00, isIncome: false, date: DateTime(2026, 10, 20)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF73b69a),
        title: const Text('FinoUz - Все счета', style: TextStyle(fontSize: 16)),
        actions: [
          IconButton(
            icon: Icon(isListView ? Icons.pie_chart : Icons.format_list_bulleted),
            onPressed: () {
              setState(() {
                isListView = !isListView;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            color: const Color(0xFF73b69a),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Октябрь', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                  child: Text('Баланс ${balance.toStringAsFixed(2)} uzs', style: const TextStyle(color: Color(0xFF73b69a), fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Expanded(
            child: isListView ? buildListView() : buildChartView(),
          ),
        ],
      ),
    );
  }

  Widget buildChartView() {
    return Center(
      child: SizedBox(
        width: 280,
        height: 280,
        child: PieChart(
          PieChartData(
            sectionsSpace: 2,
            centerSpaceRadius: 70,
            sections: [
              PieChartSectionData(color: Colors.blue, value: 40, title: '24%', radius: 40),
              PieChartSectionData(color: Colors.orange, value: 30, title: '38%', radius: 40),
              PieChartSectionData(color: Colors.pink, value: 15, title: '7%', radius: 40),
              PieChartSectionData(color: Colors.purple, value: 15, title: '6%', radius: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListView() {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final tx = transactions[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: tx.isIncome ? Colors.green.shade100 : Colors.red.shade100,
              child: Icon(tx.isIncome ? Icons.arrow_downward : Icons.arrow_upward, color: tx.isIncome ? Colors.green : Colors.red),
            ),
            title: Text(tx.category, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${tx.date.day} Октябрь'),
            trailing: Text(
              '${tx.isIncome ? "+" : "-"} ${tx.amount.toStringAsFixed(2)} uzs',
              style: TextStyle(color: tx.isIncome ? Colors.green : Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
