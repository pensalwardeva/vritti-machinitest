// // // import 'package:flutter/material.dart';
// // // import '../Database/db_helper.dart';
// // // class EditEmployeeScreen extends StatefulWidget {
// // //   late  Employee employee;
// // //
// // // EditEmployeeScreen({Key? key, required this.employee}) : super(key: key);
// // //
// // //   @override
// // //   _EditEmployeeScreenState createState() => _EditEmployeeScreenState();
// // // }
// // //
// // // class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
// // //   late TextEditingController firstNameController;
// // //   late TextEditingController lastNameController;
// // //   late TextEditingController emailController;
// // //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     firstNameController = TextEditingController(text: widget.employee.firstName);
// // //     lastNameController = TextEditingController(text: widget.employee.lastName);
// // //     emailController = TextEditingController(text: widget.employee.email);
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Edit Employee'),
// // //       ),
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(16.0),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             Text('Employee ID: ${widget.employee.id}'),
// // //             const SizedBox(height: 16.0),
// // //             Text('First Name:'),
// // //             TextField(controller: firstNameController),
// // //             const SizedBox(height: 16.0),
// // //             Text('Last Name:'),
// // //             TextField(controller: lastNameController),
// // //             const SizedBox(height: 16.0),
// // //             Text('Email:'),
// // //             TextField(controller: emailController),
// // //             ElevatedButton(
// // //               onPressed: () async {
// // //                 try {
// // //                   // Update the employee details in the local database
// // //                   final updatedEmployee = Employee(
// // //                     id: widget.employee.id,
// // //                     firstName: firstNameController.text,
// // //                     lastName: lastNameController.text,
// // //                     email: emailController.text,
// // //                     avatar: widget.employee.avatar,
// // //                   );
// // //
// // //                   // print('Before update: ${widget.employee}');
// // //                   // print('After update: $updatedEmployee');
// // //
// // //                   // Update the state implicitly by triggering a rebuild
// // //                   setState(() {
// // //                     widget.employee = updatedEmployee;
// // //                   });
// // //
// // //                   // Update the local database
// // //                   await DatabaseHelper.instance.updateEmployee(updatedEmployee);
// // //
// // //                   // Navigate back to the employee details page
// // //                   Navigator.pop(context);
// // //                 } catch (e) {
// // //                   print('Error updating employee: $e');
// // //                   // Handle the error as needed (e.g., show a dialog, log it, etc.)
// // //                 }
// // //               },
// // //               child: Text('Save Changes'),
// // //             ),
// // //
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // //
// // import 'package:flutter/material.dart';
// // import '../Database/db_helper.dart';
// //
// // class EditEmployeeScreen extends StatefulWidget {
// //   final Employee employee;
// //
// //   const EditEmployeeScreen({Key? key, required this.employee}) : super(key: key);
// //
// //   @override
// //   _EditEmployeeScreenState createState() => _EditEmployeeScreenState();
// // }
// //
// // class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
// //   late TextEditingController firstNameController;
// //   late TextEditingController lastNameController;
// //   late TextEditingController emailController;
// //   late TextEditingController avatarController;
// //
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     firstNameController = TextEditingController(text: widget.employee.firstName);
// //     lastNameController = TextEditingController(text: widget.employee.lastName);
// //     emailController = TextEditingController(text: widget.employee.email);
// //     avatarController = TextEditingController(text: widget.employee.avatar);
// //
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Edit Employee'),
// //         actions: [
// //           IconButton(
// //             icon: const Icon(Icons.delete),
// //             onPressed: () async {
// //               // Show a confirmation dialog before deleting
// //               showDialog(
// //                 context: context,
// //                 builder: (BuildContext context) {
// //                   return AlertDialog(
// //                     title: const Text('Delete Employee'),
// //                     content: const Text('Please confirm'),
// //                     actions: [
// //                       TextButton(
// //                         onPressed: () {
// //                           Navigator.pop(context); // Close the dialog
// //                         },
// //                         child: const Text('Cancel'),
// //                       ),
// //                       TextButton(
// //                         onPressed: () async {
// //                           try {
// //                             // Implement the logic to delete the employee from the local database
// //                             await DatabaseHelper.instance.deleteEmployee(widget.employee.id);
// //                             // Navigate back to the previous screen or close the EditEmployeeScreen
// //                             Navigator.pop(context);
// //                           } catch (e) {
// //                             print('Error deleting employee: $e');
// //                             // Handle the error as needed (e.g., show a dialog, log it, etc.)
// //                           }
// //                         },
// //                         child: const Text('Delete'),
// //                       ),
// //                     ],
// //                   );
// //                 },
// //               );
// //             },
// //           ),
// //         ],
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text('Employee ID: ${widget.employee.id}'),
// //             const SizedBox(height: 16.0),
// //             const Text('First Name:'),
// //             TextField(controller: firstNameController),
// //             const SizedBox(height: 16.0),
// //             const Text('Last Name:'),
// //             TextField(controller: lastNameController),
// //             const SizedBox(height: 16.0),
// //             const Text('Email:'),
// //             TextField(controller: emailController),
// //             const SizedBox(height: 16.0),
// //          // Add Image.network to display the avatar
// //             Image.network(
// //               widget.employee.avatar,
// //               width: 100, // Adjust the width as needed
// //               height: 100, // Adjust the height as needed
// //             ),
// //             //
// //             ElevatedButton(
// //               onPressed: () async {
// //                 try {
// //                   // Update the employee details in the local database
// //                   final updatedEmployee = Employee(
// //                     id: widget.employee.id,
// //                     firstName: firstNameController.text,
// //                     lastName: lastNameController.text,
// //                     email: emailController.text,
// //                     avatar: avatarController.text, // Add this line
// //                   );
// //                   // Update the local database
// //                   await DatabaseHelper.instance.updateEmployee(updatedEmployee);
// //
// //                   // Navigate back to the employee details page
// //                   Navigator.pop(context);
// //                 } catch (e) {
// //                   print('Error updating employee: $e');
// //                   // Handle the error as needed (e.g., show a dialog, log it, etc.)
// //                 }
// //               },
// //               child: const Text('Save Changes'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //edit_employee_screen.dart
//
// // import 'package:flutter/material.dart';
// // import '../Database/db_helper.dart';
// //
// // class EditEmployeeScreen extends StatefulWidget {
// //   final Employee employee;
// //
// //   EditEmployeeScreen({Key? key, required this.employee}) : super(key: key);
// //
// //   @override
// //   _EditEmployeeScreenState createState() => _EditEmployeeScreenState();
// // }
// //
// // class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
// //   TextEditingController firstNameController = TextEditingController();
// //   TextEditingController lastNameController = TextEditingController();
// //   TextEditingController emailController = TextEditingController();
// //   TextEditingController avatarController = TextEditingController();
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     // Initialize text controllers with the existing data
// //     firstNameController.text = widget.employee.firstName;
// //     lastNameController.text = widget.employee.lastName;
// //     emailController.text = widget.employee.email;
// //     avatarController.text = widget.employee.avatar;
// //
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Edit Employee'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             TextField(
// //               controller: firstNameController,
// //               decoration: InputDecoration(labelText: 'First Name'),
// //             ),
// //             TextField(
// //               controller: lastNameController,
// //               decoration: const InputDecoration(labelText: 'Last Name'),
// //             ),
// //             TextField(
// //               controller: emailController,
// //               decoration: const InputDecoration(labelText: 'Email'),
// //             ),
// //             // const CircleAvatar(
// //             //     backgroundImage: NetworkImage('https://lh3.googleusercontent.com/a-/AAuE7mChgTiAe-N8ibcM3fB_qvGdl2vQ9jvjYv0iOOjB=s96-c'),
// //             //     radius: 100.0
// //             // ),
// //             const SizedBox(height: 16.0),
// //             ElevatedButton(
// //               onPressed: () {
// //                 // Save changes to the local database
// //                 _updateEmployee();
// //               },
// //               child: const Text('Save Changes'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   // Method to update the employee data in the local database
// //   void _updateEmployee() async {
// //     print('Updating employee...');
// //     try {
// //       // Create an updated employee object
// //       Employee updatedEmployee = widget.employee.copyWith(
// //         firstName: firstNameController.text,
// //         lastName: lastNameController.text,
// //         email: emailController.text,
// //         avatar: avatarController.text, // Assign the avatar value
// //       );
// //
// //       // Print the updated employee for debugging
// //       print('Updated Employee: $updatedEmployee');
// //
// //       // Update the employee in the local database
// //       await DatabaseHelper.instance.updateEmployee(updatedEmployee);
// //
// //       // Show a success message or navigate back
// //       Navigator.pop(context, true); // true indicates success
// //     } catch (e) {
// //       // Handle errors, e.g., show an error message or log the error
// //       print('Error updating employee: $e');
// //
// //       // Show an error message
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('Failed to update employee. Please try again.'),
// //         ),
// //       );
// //     }
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import '../Database/db_helper.dart';
// import '../services/employee.dart';
//
// class EditEmployeeScreen extends StatefulWidget {
//   final Employee employee;
//
//   EditEmployeeScreen({Key? key, required this.employee}) : super(key: key);
//
//   @override
//   _EditEmployeeScreenState createState() => _EditEmployeeScreenState();
// }
//
// class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
//   late TextEditingController firstNameController;
//   late TextEditingController lastNameController;
//   late TextEditingController emailController;
//   late TextEditingController avatarController;
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize text controllers with the existing data
//     firstNameController = TextEditingController(text: widget.employee.firstName);
//     lastNameController = TextEditingController(text: widget.employee.lastName);
//     emailController = TextEditingController(text: widget.employee.email);
//     avatarController = TextEditingController(text: widget.employee.avatar);
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
//           children: [
//             TextField(
//               controller: firstNameController,
//               decoration: const InputDecoration(labelText: 'First Name'),
//             ),
//             TextField(
//               controller: lastNameController,
//               decoration: const InputDecoration(labelText: 'Last Name'),
//             ),
//             TextField(
//               controller: emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: avatarController,
//               decoration: const InputDecoration(labelText: 'Avatar'),
//             ),
//             const SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 // Save changes to the local database
//                 _updateEmployee();
//               },
//               child: const Text('Save Changes'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Method to update the employee data in the local database
//   void _updateEmployee() async {
//     print('Updating employee...');
//     try {
//       // Create an updated employee object
//       Employee updatedEmployee = widget.employee.copyWith(
//         firstName: firstNameController.text,
//         lastName: lastNameController.text,
//         email: emailController.text,
//         avatar: avatarController.text,
//       );
//
//       // Update the employee in the local database
//       await DatabaseHelper.instance.updateEmployee(updatedEmployee);
//
//       // Show a success message or navigate back
//       Navigator.pop(context, true); // true indicates success
//     } catch (e) {
//       // Handle errors, e.g., show an error message or log the error
//       print('Error updating employee: $e');
//
//       // Show an error message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to update employee. Please try again.'),
//         ),
//       );
//     }
//   }
// }
