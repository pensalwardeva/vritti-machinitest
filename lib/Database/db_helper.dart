import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../employee.dart';

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
      version: 2,
    );
  }

  // Insert an employee into the database
  Future<int> insertEmployee(Employee employee,) async {
    Database db = await instance.database;
    return await db.insert(tableEmployee, employee.toMap());
  }

  // Update an employee in the database
  Future<void> updateEmployee(Employee employee) async {
    final db = await instance.database;

    // Print the SQL statement for debugging
    print(
        'Executing SQL: UPDATE $tableEmployee SET $columnFirstName = ?, $columnLastName = ?, $columnEmail = ?, $columnAvatar = ? WHERE $columnId = ?');

    await db.update(
      tableEmployee,
      {
        columnFirstName: employee.firstName,
        columnLastName: employee.lastName,
        columnEmail: employee.email,
        columnAvatar: employee.avatar,
      },
      where: '$columnId = ?',
      whereArgs: [employee.id],
    );
  }


  // Delete an employee from the database
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

    // Insert each employee from updatedData into the 'employees' table
    for (Employee employee in updatedData) {
      await insertOrUpdateEmployee(employee);
    }
  }
}
