import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
   String employeeTable = 'employees';

  // Private constructor to make it a singleton
 DatabaseHelper._privateConstructor();

  static Database? _database;

  // Define your table and column names
  static const String tableEmployee = 'employee';
  static const String columnId = 'id';
  static const String columnFirstName = 'first_name';
  static const String columnLastName = 'last_name';
  static const String columnEmail = 'email';
  static const String columnAvatar = 'avatar';

  // Open the database
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'employee_database.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableEmployee (
            $columnId INTEGER PRIMARY KEY,
            $columnFirstName TEXT,
            $columnLastName TEXT,
            $columnEmail TEXT,
            $columnAvatar TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  // Insert an employee into the database
  Future<int> insertEmployee(Employee employee,) async {
    Database db = await instance.database;
    return await db.insert(tableEmployee, employee.toMap());
  }
  updateData(table, data) async {
    var connection =
    await database;
    return await connection?.update(
        table,
        data,
        where: 'id=?',
        whereArgs: [data['id']]);
  }
  // ... your existing code ...

  Future<Employee> getEmployeeById(int id) async {
  final db = await instance.database;

  final List<Map<String, dynamic>> maps = await db.query(
  'employee',
  where: 'id = ?',
  whereArgs: [id],
  );

  if (maps.isNotEmpty) {
  // Assuming that you have a method to convert a Map to an Employee object
  return Employee.fromMap(maps.first);
  } else {
  throw Exception('Employee with id $id not found');
  }
  }

  // ... other methods in your DatabaseHelper class ...
  Future<void> updateEmployee(Employee employee) async {
    final db = await instance.database;

    await db.update(
      'employee',
      employee.toMap(), // Assuming toMap converts Employee to Map<String, dynamic>
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }
  // Method to update employee data in the local database

  Future<void> deleteEmployee(int employeeId) async {
    final db = await instance.database;
    await db.delete(
      employeeTable,
      where: '$columnId = ?',
      whereArgs: [employeeId],
    );
  }

  // Insert or update employees in the database
  Future<void> insertOrUpdateEmployee(Employee employee) async {
    final db = await database;
    await db.insert(
      'employees',
      employee.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  // Get all employees from the database
  Future<List<Employee>> getAllEmployees() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(tableEmployee);
    return List.generate(maps.length, (index) => Employee.fromMap(maps[index]));
  }
  // Implement the refreshDatabase method to update the local database
  Future<void> refreshDatabase(List<Employee> updatedData) async {
    // Delete all existing records in the 'employees' table
    final db = await database;
    await db.delete('employees');

    // Insert the updatedData into the 'employees' table
    await insertOrUpdateEmployee(updatedData as Employee);
  }
}

class Employee {
  final int id;
  late final String firstName;
  late final String lastName;
  late final String email;
  final String avatar;

  Employee({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatar,
  });

  // Convert Employee to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'avatar': avatar,
    };
  }

  // Create Employee from Map
  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      email: map['email'],
      avatar: map['avatar'],
    );
  }
}
