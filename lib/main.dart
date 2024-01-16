import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vritti_techno_machinetest/screen/edit.dart';
import 'package:vritti_techno_machinetest/screens/edit_employee_screen.dart';
import 'Database/db_helper.dart';
import 'Second_employee_page.dart';
import 'model/employee.dart';
import 'model/user.dart';
import 'my sqlite home page.dart';


void main() {
  runApp(
    const MaterialApp(
      home: EmployeeDirectoryApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
// void main() {
//   runApp(const EmployeeDirectoryApp());
// }
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
// class EmployeeNamesTab extends StatelessWidget {
//   const EmployeeNamesTab({super.key,});
//
//   // Method to fetch data from API and update the local database
//   Future<void> refreshData() async {
//     try {
//       // Fetch data from the API
//       final List<Employee> updatedData = await EmployeeDataLoader().loadEmployees();
//
//       // Update the local database with the new data
//       await DatabaseHelper.instance.refreshDatabase(updatedData);
//     } catch (e) {
//       print('Error refreshing data: $e');
//       // Handle the error as needed (e.g., show a dialog, log it, etc.)
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Employee>>(
//       // Use a FutureBuilder to display the employee data
//       future: EmployeeDataLoader().loadEmployees(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Text('No employees available.');
//         } else {
//           final employees = snapshot.data!;
//           return Column(
//             children: [
//               // Add a RefreshIndicator to enable pull-to-refresh
//               RefreshIndicator(
//                 onRefresh: refreshData,
//                 child: ListView.builder(
//                   itemCount: employees.length,
//                   itemBuilder: (context, index) {
//                     final employee = employees[index];
//                     return ListTile(
//                       title: Text('${employee.firstName} ${employee.lastName}'),
//                       subtitle: Text(employee.email),
//                       onTap: () {
//                         // Navigate to the EmployeeDetailsTab with the selected employee
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => EmployeeDetailsTab(employee: employee),
//                           ),
//                         );
//                       },
//                       trailing: IconButton(
//                         icon: const Icon(Icons.edit),
//                         onPressed: () {
//                           // Navigate to the EditEmployeeScreen with the selected employee
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => EditEmployeeScreen(employee: employee),
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         }
//       },
//     );
//   }
// }
class EmployeeNamesTab extends StatefulWidget {
  const EmployeeNamesTab({Key? key}) : super(key: key);

  @override
  _EmployeeNamesTabState createState() => _EmployeeNamesTabState();
}

class _EmployeeNamesTabState extends State<EmployeeNamesTab> {
  List<Employee> employeeList = [];

  // Method to fetch data from API and update the local database
  Future<void> _refreshData() async {
    try {
      List<Employee> employees = await DatabaseHelper.instance.getAllEmployees();

      // Update the state with the fetched employees
      setState(() {
        // Update this list with the fetched employees
        employeeList = employees;
      });

      // Optionally, you can show a success message or perform other UI updates
      // ...

    } catch (e) {
      // Handle errors, e.g., show an error message or log the error
      print('Error refreshing data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Employee>>(
      // Use a FutureBuilder to display the employee data
      future: EmployeeDataLoader().loadEmployees(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No employees available.');
        } else {
          final employees = snapshot.data!;
          return Column(
            children: [
              // Add a RefreshIndicator to enable pull-to-refresh
              RefreshIndicator(
                onRefresh: _refreshData,
                child: ListView.builder(
                  itemCount: employees.length,
                  itemBuilder: (context, index) {
                    final employee = employees[index];
                    return ListTile(
                      title: Text('${employee.firstName} ${employee.lastName}'),
                      subtitle: Text(employee.email),
                      onTap: () {
                        // Navigate to the EmployeeDetailsTab with the selected employee
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EmployeeDetailsTab(employee: employee),
                          ),
                        );
                      },
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Navigate to the EditEmployeeScreen with the selected employee
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  MyHomePage(title: '',),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}


class EmployeeDetailsTab extends StatelessWidget {
  final Employee employee;
  const EmployeeDetailsTab({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Details'),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.arrow_forward),
          //   onPressed: () {
          //     // Navigate to the SecondEmployeeDirectoryPage
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => SecondEmployeeDirectoryPage(),
          //       ),
          //     );
          //   },
          // ),
          // Add an edit icon for all employees
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigate to EditEmployeeScreen with the selected employee data
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(title: '',),
                ),
              );
            },
          ),
          // Add a delete icon for the current employee
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Show a confirmation dialog before deleting
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Delete Employee'),
                    content: const Text('Please confirm'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Implement the logic to delete the employee
                          // This could involve making an API call or updating your data source
                          // Once the employee is deleted, you can navigate back or show a success message
                          Navigator.pop(context); // Close the dialog
                          Navigator.pop(context); // Close the EmployeeDetailsTab
                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
    ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Employee ID: ${employee.id}'),
              const SizedBox(height: 16.0),
              Text('Name: ${employee.firstName} ${employee.lastName}'),
              const SizedBox(height: 16.0),
              Text('Email: ${employee.email}'),
              const SizedBox(height: 16.0),
              Image.network(employee.avatar),
              // Add profile details specific to Employee 1
            ],
          ),
        ),
      ),
    );
  }
}

// class EmployeeDirectoryApp extends StatelessWidget {
//   const EmployeeDirectoryApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: DefaultTabController(
//         length: 6,
//         child: Scaffold(
//           appBar: AppBar(
//             title: const Text('Employee Directory'),
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_forward),
//               onPressed: () {
//                 // Navigate to the next page
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => SecondEmployeeDirectoryPage(),
//                   ),
//                 );
//               },
//             ),
//             //title: const Text('Employee Directory'),
//             actions: [
//               ElevatedButton(
//                 // icon: const Icon(Icons.arrow_forward),
//                 onPressed: () {
//                   // Navigate to the next page
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const SecondEmployeeDirectoryPage(),
//                     ),
//                   );
//                 }, child: Text('forward'),
//               ),
//               // IconButton(
//               //   icon: const Icon(Icons.refresh),
//               //   onPressed: () {}, // Implement refresh functionality
//               // ),
//             ],
//             bottom: const TabBar(
//               isScrollable: true,
//               tabs: [
//                 Tab(text: 'Employee 1'),
//                 Tab(text: 'Employee 2'),
//                 Tab(text: 'Employee 3'),
//                 Tab(text: 'Employee 4'),
//                 Tab(text: 'Employee 5'),
//                 Tab(text: 'Employee 6'),
//
//               ],
//             ),
//           ),
//           body: const TabBarView(
//             children: [
//               EmployeeTab(employeeId: 1),
//               EmployeeTab(employeeId: 2),
//               EmployeeTab(employeeId: 3),
//               EmployeeTab(employeeId: 4),
//               EmployeeTab(employeeId: 5),
//               EmployeeTab(employeeId: 6),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
class EmployeeDirectoryApp extends StatelessWidget {
  const EmployeeDirectoryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                // Forward arrow
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    // Navigate to the next page (SecondEmployeeDirectoryPage)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SecondEmployeeDirectoryPage(),
                      ),
                    );
                  },
                ),
                // Employee Directory text
                Text('Employee-Page 1'),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {}, // Implement refresh functionality
              ),
            ],
            bottom: const TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'Employee 1'),
                Tab(text: 'Employee 2'),
                Tab(text: 'Employee 3'),
                Tab(text: 'Employee 4'),
                Tab(text: 'Employee 5'),
                Tab(text: 'Employee 6'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              EmployeeTab(employeeId: 1),
              EmployeeTab(employeeId: 2),
              EmployeeTab(employeeId: 3),
              EmployeeTab(employeeId: 4),
              EmployeeTab(employeeId: 5),
              EmployeeTab(employeeId: 6),
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
      future: EmployeeDataLoader().loadEmployee(employeeId), // Fetch employee data from the API
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

// class EmployeeDirectoryApp extends StatelessWidget {
//   const EmployeeDirectoryApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: DefaultTabController(
//         length: 3,
//         child: Scaffold(
//           appBar: AppBar(
//             title: const Text('Employee Directory'),
//             actions: [
//               IconButton(
//                 icon: const Icon(Icons.refresh),
//                 onPressed: () {}, // Implement refresh functionality
//               ),
//             ],
//             bottom: const TabBar(
//               isScrollable: true,
//               tabs: [
//                 Tab(text: 'Employee Names'),
//                 Tab(text: 'Employee 1'),
//                 Tab(text: 'Employee 2'),
//                 Tab(text: 'Employee 3'),
//               ],
//             ),
//           ),
//           body: const TabBarView(
//             children: [
//               EmployeeNamesTab(),
//               EmployeeProfileTab(), // Pass the selected employee instance
//               // EmployeeProfileTab(), // New tab for Employee 1 profile
//               // EmployeeDetailsTab(employee: Employee(id: 0, firstName: '', lastName: '', email: '', avatar: '')),
//               Center(child: Text('Employee Stats')),
//             ],
//           ),
//
//         ),
//       ),
//     );
//   }
// }


// import 'dart:convert';
//
// import'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import 'Database/db_helper.dart';
// void main() {
//   runApp(EmployeeDirectoryApp());
// }
// class EmployeeDataLoader {
//   final String apiEndpoint = 'https://reqres.in/api/users?page=1';
//
//   Future<List<Employee>> loadEmployees() async {
//     final response = await http.get(Uri.parse(apiEndpoint));
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final List<dynamic> users = data['data'];
//       final employees = users.map((user) => Employee.fromJson(user)).toList();
//       return employees;
//     } else {
//       throw Exception('Failed to load employees');
//     }
//   }
// }
//
//
// //
// // final employeeData = [
// //   {
// //     "id": 1,
// //     "first_name": "George",
// //     "last_name": "Bluth",
// //     "email": "george.bluth@reqres.in",
// //     "avatar": "https://reqres.in/img/faces/1-image.jpg"
// //   },
// //   {
// //     "id": 2,
// //     "first_name": "Janet",
// //     "last_name": "Weaver",
// //     "email": "janet.weaver@reqres.in",
// //     "avatar": "https://reqres.in/img/faces/2-image.jpg"
// //   },
// //   {
// //     "id": 3,
// //     "first_name": "Emma",
// //     "last_name": "Wong",
// //     "email": "emma.wong@reqres.in",
// //     "avatar": "https://reqres.in/img/faces/3-image.jpg"
// //   },
// //   {
// //     "id": 4,
// //     "first_name": "Eve",
// //     "last_name": "Holt",
// //     "email": "eve.holt@reqres.in",
// //     "avatar": "https://reqres.in/img/faces/4-image.jpg"
// //   },
// //   {
// //     "id": 5,
// //     "first_name": "Charles",
// //     "last_name": "Morris",
// //     "email": "charles.morris@reqres.in",
// //     "avatar": "https://reqres.in/img/faces/5-image.jpg"
// //   },
// //   {
// //     "id": 6,
// //     "first_name": "Tracey",
// //     "last_name": "Ramos",
// //     "email": "tracey.ramos@reqres.in",
// //     "avatar": "https://reqres.in/img/faces/6-image.jpg"
// //   },
// //   {
// //     "id": 7,
// //     "first_name": "George",
// //     "last_name": "Bluth",
// //     "email": "george.bluth@reqres.in",
// //     "avatar": "https://reqres.in/img/faces/1-image.jpg"
// //   },
// //   {
// //     "id": 8,
// //     "first_name": "Janet",
// //     "last_name": "Weaver",
// //     "email": "janet.weaver@reqres.in",
// //     "avatar": "https://reqres.in/img/faces/2-image.jpg"
// //   },
// //   {
// //     "id": 9,
// //     "first_name": "Emma",
// //     "last_name": "Wong",
// //     "email": "emma.wong@reqres.in",
// //     "avatar": "https://reqres.in/img/faces/3-image.jpg"
// //   },
// //   {
// //     "id": 10,
// //     "first_name": "Eve",
// //     "last_name": "Holt",
// //     "email": "eve.holt@reqres.in",
// //     "avatar": "https://reqres.in/img/faces/4-image.jpg"
// //   },
// //   {
// //     "id": 11,
// //     "first_name": "Charles",
// //     "last_name": "Morris",
// //     "email": "charles.morris@reqres.in",
// //     "avatar": "https://reqres.in/img/faces/5-image.jpg"
// //   },
// //   {
// //     "id": 12,
// //     "first_name": "Tracey",
// //     "last_name": "Ramos",
// //     "email": "tracey.ramos@reqres.in",
// //     "avatar": "https://reqres.in/img/faces/6-image.jpg"
// //   }
// // ];
// //
// // class Employee {
// //   final int id;
// //   final String firstName;
// //   final String lastName;
// //   final String email;
// //   final String avatar;
// //
// //   Employee({
// //     required this.id,
// //     required this.firstName,
// //     required this.lastName,
// //     required this.email,
// //     required this.avatar,
// //   });
// //
// //   factory Employee.fromJson(Map<String, dynamic> json) {
// //     return Employee(
// //       id: json['id'] as int,
// //       firstName: json['first_name'] as String,
// //       lastName: json['last_name'] as String,
// //       email: json['email'] as String,
// //       avatar: json['avatar'] as String,
// //     );
// //   }
// // }
//
// class EmployeeNamesTab extends StatelessWidget {
//   const EmployeeNamesTab({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var employeeData;
//     return ListView.builder(
//       itemCount: employeeData.length,
//       itemBuilder: (context, index) {
//         final Map<String, dynamic> employeeDataMap = employeeData[index]; // Rename 'employeeData' to 'employeeDataMap'
//         return ListTile(
//           title: Text('${employeeDataMap['first_name']} ${employeeDataMap['last_name']}'),
//           subtitle: Text(employeeDataMap['email']),
//           onTap: () {
//             // Convert the employee data into an Employee object
//             Employee employee = Employee.fromJson(employeeDataMap);
//
//             // Pass the Employee object to the EmployeeDetailsTab constructor
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => EmployeeDetailsTab(employee: employee),
//               ),
//             );
//           },
//         );
//       },
//     );
//
//
//
//
//   }
// }
//
// class EmployeeDetailsTab extends StatelessWidget {
//   final Employee employee;
//
//   const EmployeeDetailsTab({super.key, required this.employee});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//         title: Text('Employee Details'),
//     ),
//     body: SingleChildScrollView(
//     child: Padding(
//     padding: const EdgeInsets.all(16.0),
//     child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//     Text('Employee ID: ${employee.id}'),
//     const SizedBox(height: 16.0),
//     Text('Name: ${employee.firstName} ${employee.lastName}'),
//       const SizedBox(height: 16.0),
//       Text('Email: ${employee.email}'),
//       const SizedBox(height: 16.0),
//       Image.network(employee.avatar),
//     ],
//     ),
//     ),
//     ),
//     );
//   }
// }
//
// class EmployeeDirectoryApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: DefaultTabController(
//         length: 3, // Update the number of tabs
//         child: Scaffold(
//           appBar: AppBar(
//             title: const Text('Employee Directory'),
//             actions: [
//               IconButton(
//                 icon: Icon(Icons.refresh),
//                 onPressed: () {}, // Implement refresh functionality
//               ),
//             ],
//             bottom: const TabBar(
//               isScrollable: true, // Enable horizontal scrolling
//               tabs: [
//                 Tab(text: 'Employee Names'),
//                 Tab(text: 'Employee Details'),
//                 Tab(text: 'Employee Stats'),
//               ],
//
//             ),
//           ),
//           body: TabBarView(
//             children: [
//               const EmployeeNamesTab(),
//               EmployeeDetailsTab(employee: Employee(id: 0,
//                   firstName: '',
//                   lastName: '',
//                   email: '',
//                   avatar: ''),
//               ),
//               // Use EmployeeDetailsTab for employee selection
//               const Center(child: Text('Employee Stats')),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
