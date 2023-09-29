import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Customer {
  final String firstName;
  final String lastName;
  final int customerID;
  final String type;

  Customer({
    required this.firstName,
    required this.lastName,
    required this.customerID,
    required this.type,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Customer List',
      home: CustomerListPage(),
    );
  }
}

class CustomerListPage extends StatefulWidget {
  const CustomerListPage({super.key});

  @override
  _CustomerListPageState createState() => _CustomerListPageState();
}

class _CustomerListPageState extends State<CustomerListPage> {
  bool isLoading = false;
  List<Customer> customers = [];

  void loadCustomers() {
    setState(() {
      isLoading = true;
    });

    // List of random Marvel character names
    final marvelCharacterNames = [
      'Tony Stark',
      'Natasha Romanoff',
      'Steve Rogers',
      'Bruce Banner',
      'Thor Odinson',
      'Peter Parker',
      'Carol Danvers',
      'T\'Challa',
      'Scott Lang',
      'Wanda Maximoff',
    ];

    // Simulate loading from a database with a delay of 3 seconds.
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
        customers = List.generate(
          10,
          (index) {
            final randomMarvelName =
                marvelCharacterNames[index % marvelCharacterNames.length];
            final nameParts = randomMarvelName.split(' ');
            return Customer(
              firstName: nameParts.first,
              lastName: nameParts.last,
              customerID: index + 1,
              type: ['Saver', 'Spender', 'Occasional', 'Frequent'][index % 4],
            );
          },
        );
      });
    });
  }

  void reset() {
    setState(() {
      isLoading = false;
      customers = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer List'),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : customers.isEmpty
                ? const Text('Press "Load Items" to load customers.')
                : ListView.builder(
                    itemCount: customers.length,
                    itemBuilder: (context, index) {
                      final customer = customers[index];
                      return ListTile(
                        title:
                            Text('${customer.firstName} ${customer.lastName}'),
                        subtitle: Text(
                            'ID: ${customer.customerID}, Type: ${customer.type}'),
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isLoading ? null : () => loadCustomers(),
        tooltip: 'Load Items',
        child: const Icon(Icons.refresh),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
