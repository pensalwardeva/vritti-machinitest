import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Database/db_helper.dart';
import 'employee.dart';
import 'main.dart';
class EmployeeDataLoader {
  final String apiEndpoint = 'https://reqres.in/api/users';

  Future<List<Employee>> loadEmployees() async {
    final response = await http.get(Uri.parse('$apiEndpoint?page=1'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> users = data['data'];
      final employees = users.map((user) => Employee.fromMap(user)).toList();
      return employees;
    } else {
      throw Exception('Failed to load employees');
    }
  }

  Future<Employee> loadEmployee(int employeeId) async {
    final response = await http.get(Uri.parse('$apiEndpoint/$employeeId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Employee.fromMap(data['data']);
    } else {
      throw Exception('Failed to load employee');
    }
  }
}


class SecondEmployeeDirectoryPage extends StatelessWidget {
  const SecondEmployeeDirectoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                // Navigate back to the Employee Directory
                Navigator.pop(context);
              },
            ),
            title: const Text('Employee-Page 2'),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {}, // Implement refresh functionality
              ),
            ],
            bottom: const TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'Employee 7'),
                Tab(text: 'Employee 8'),
                Tab(text: 'Employee 9'),
                Tab(text: 'Employee 10'),
                Tab(text: 'Employee 11'),
                Tab(text: 'Employee 12'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              EmployeeTab(employeeId: 7),
              EmployeeTab(employeeId: 8),
              EmployeeTab(employeeId: 9),
              EmployeeTab(employeeId: 10),
              EmployeeTab(employeeId: 11),
              EmployeeTab(employeeId: 12),
            ],
          ),
          ),
        ),
    );
  }
}

class EmployeeTab extends StatelessWidget {
  final int employeeId;

  const EmployeeTab({Key? key, required this.employeeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Employee>(
      future: EmployeeDataLoader().loadEmployee(employeeId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return const Text('No employee data available.');
        } else {
          final employee = snapshot.data!;
          return EmployeeDetailsTab(employee: employee);
        }
      },
    );
  }
}

