// import 'package:flutter/material.dart';
// import '../Database/db_helper.dart';
// class EditEmployeeScreen extends StatefulWidget {
//   late  Employee employee;
//
// EditEmployeeScreen({Key? key, required this.employee}) : super(key: key);
//
//   @override
//   _EditEmployeeScreenState createState() => _EditEmployeeScreenState();
// }
//
// class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
//   late TextEditingController firstNameController;
//   late TextEditingController lastNameController;
//   late TextEditingController emailController;
//
//   @override
//   void initState() {
//     super.initState();
//     firstNameController = TextEditingController(text: widget.employee.firstName);
//     lastNameController = TextEditingController(text: widget.employee.lastName);
//     emailController = TextEditingController(text: widget.employee.email);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Employee'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Employee ID: ${widget.employee.id}'),
//             const SizedBox(height: 16.0),
//             Text('First Name:'),
//             TextField(controller: firstNameController),
//             const SizedBox(height: 16.0),
//             Text('Last Name:'),
//             TextField(controller: lastNameController),
//             const SizedBox(height: 16.0),
//             Text('Email:'),
//             TextField(controller: emailController),
//             ElevatedButton(
//               onPressed: () async {
//                 try {
//                   // Update the employee details in the local database
//                   final updatedEmployee = Employee(
//                     id: widget.employee.id,
//                     firstName: firstNameController.text,
//                     lastName: lastNameController.text,
//                     email: emailController.text,
//                     avatar: widget.employee.avatar,
//                   );
//
//                   // print('Before update: ${widget.employee}');
//                   // print('After update: $updatedEmployee');
//
//                   // Update the state implicitly by triggering a rebuild
//                   setState(() {
//                     widget.employee = updatedEmployee;
//                   });
//
//                   // Update the local database
//                   await DatabaseHelper.instance.updateEmployee(updatedEmployee);
//
//                   // Navigate back to the employee details page
//                   Navigator.pop(context);
//                 } catch (e) {
//                   print('Error updating employee: $e');
//                   // Handle the error as needed (e.g., show a dialog, log it, etc.)
//                 }
//               },
//               child: Text('Save Changes'),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import '../Database/db_helper.dart';

class EditEmployeeScreen extends StatefulWidget {
  final Employee employee;

  EditEmployeeScreen({Key? key, required this.employee}) : super(key: key);

  @override
  _EditEmployeeScreenState createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.employee.firstName);
    lastNameController = TextEditingController(text: widget.employee.lastName);
    emailController = TextEditingController(text: widget.employee.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Employee'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
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
                        onPressed: () async {
                          try {
                            // Implement the logic to delete the employee from the local database
                            await DatabaseHelper.instance.deleteEmployee(widget.employee.id);
                            // Navigate back to the previous screen or close the EditEmployeeScreen
                            Navigator.pop(context);
                          } catch (e) {
                            print('Error deleting employee: $e');
                            // Handle the error as needed (e.g., show a dialog, log it, etc.)
                          }
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Employee ID: ${widget.employee.id}'),
            const SizedBox(height: 16.0),
            Text('First Name:'),
            TextField(controller: firstNameController),
            const SizedBox(height: 16.0),
            Text('Last Name:'),
            TextField(controller: lastNameController),
            const SizedBox(height: 16.0),
            Text('Email:'),
            TextField(controller: emailController),
            ElevatedButton(
              onPressed: () async {
                try {
                  // Update the employee details in the local database
                  final updatedEmployee = Employee(
                    id: widget.employee.id,
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    email: emailController.text,
                    avatar: widget.employee.avatar,
                  );

                  // Update the local database
                  await DatabaseHelper.instance.updateEmployee(updatedEmployee);

                  // Navigate back to the employee details page
                  Navigator.pop(context);
                } catch (e) {
                  print('Error updating employee: $e');
                  // Handle the error as needed (e.g., show a dialog, log it, etc.)
                }
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
