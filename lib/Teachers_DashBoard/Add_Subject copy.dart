import 'dart:io';
import 'dart:ui';
import 'package:attend_ease/Teachers_Dashboard/Sections.dart';
import 'package:attend_ease/ui_components/util.dart';
import 'package:attend_ease/Teachers_DashBoard/Teachers_Dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp1());
}

class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(215, 130, 255, 1),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: 'Flutter Demo Home Page',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Variables Required
var validate_course_name = false;
var validate_course_code = false;
var validate_classes_held = false;

var branch_codes = [
  'AE',
  'AIDS',
  'AIML',
  'BT',
  'CH',
  'CSBS',
  'CSDS',
  'CSE',
  'CSIOT',
  'CV',
  'EC',
  'EEE',
  'EI',
  'ET',
  'IEM',
  'ISE',
  'MD',
  'ME'
];

var dropdownvalue_branch = "CSE";
var dropdownvalue_semester = 2;
var current_cycle = "Even";
var dropdownvalue_section = 'A';
var sem = [2, 4, 6, 8];
var section = ['A', 'B'];
var course_name = TextEditingController();
var course_code = TextEditingController();
var classes_held = TextEditingController();

var dropdown_course = "Mathematical foundation";
var cse1 = [
  "Mathematical foundation",
  "Applied Physics for Computer Science Stream",
  "Principles of Programming in C",
  "Professional Writing Skills in English",
  "Innovation and Design Thinking",
  "Introduction to Electronics Engineering",
  "Introduction to Electrical Engineering",
  "Introduction to Civil Engineering",
  "Introduction to Mechanical Engineering",
  "Introduction to Python Programing",
  "Samskritika Kannada",
  "Balake Kannada",
  "Introduction to Web Programing"
];

bool enable_section = false;
bool enable_Course = false;

class _MyHomePageState extends State<MyHomePage> {
  check(current_cycle) {
    if (current_cycle == "Even") {
      sem = [2, 4, 6, 8];
      dropdownvalue_semester = 2;
      setState(() {});
    }
    if (current_cycle == "Odd") {
      sem = [1, 3, 5, 7];
      dropdownvalue_semester = 1;
      setState(() {});
    }

    if ((dropdownvalue_branch == "CSIOT" ||
            dropdownvalue_branch == "AIDS" ||
            dropdownvalue_branch == "CSDS") &&
        (current_cycle == "Odd")) {
      sem = [1, 3];
      dropdownvalue_semester = 1;
      setState(() {});
    }

    if ((dropdownvalue_branch == "CSIOT" ||
            dropdownvalue_branch == "AIDS" ||
            dropdownvalue_branch == "CSDS") &&
        (current_cycle == "Even")) {
      sem = [2, 4];
      dropdownvalue_semester = 2;
      setState(() {});
    }
  }

// Start
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Center(
              child: Text('AttendEase'),
            )),

        // Background Color of the home page.
        backgroundColor: Color.fromRGBO(255, 246, 254, 1),

        // UI
        body: Container(
          width: 400,
          margin: EdgeInsets.only(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Enter Course Details",
                style: GoogleFonts.poppins(
                  textStyle: font25(textColor: Colors.purpleAccent),

                  // Retreiving from the theme

                  // Theme.of(context).textTheme.displayLarge
                  // !.copyWith(color: Colors.deepPurpleAccent[500]),
                ),
              ),

              // Branch Selection
              Padding(
                padding: EdgeInsets.only(top: 40, left: 10),
                child: Row(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Container(
                          child: Text(
                        "Select Branch:",
                        style: font_details(),
                      )),
                    ),

                    // options
                    Padding(
                        padding: EdgeInsets.only(left: 46),
                        child: Container(
                            height: 21,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                    value: dropdownvalue_branch,
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    // Items from the array
                                    items: branch_codes.map((String s) {
                                      return DropdownMenuItem(
                                          value: s, child: Text(s));
                                    }).toList(),

                                    //
                                    onChanged: (String? newVal) {
                                      setState(() {
                                        dropdownvalue_branch = newVal!;
                                        if (dropdownvalue_branch == "CSIOT" ||
                                            dropdownvalue_branch == "AIDS" ||
                                            dropdownvalue_branch == "CSDS") {
                                          if (dropdownvalue_semester == 1 ||
                                              dropdownvalue_semester == 3 ||
                                              dropdownvalue_semester == 5 ||
                                              dropdownvalue_semester == 7) {
                                            dropdownvalue_semester = 1;
                                          }
                                          if (dropdownvalue_semester == 2 ||
                                              dropdownvalue_semester == 4 ||
                                              dropdownvalue_semester == 6 ||
                                              dropdownvalue_semester == 8) {
                                            dropdownvalue_semester = 2;
                                          }
                                          sem = new_Arrival(
                                              dropdownvalue_branch,
                                              current_cycle);
                                        } else {
                                          check(current_cycle);
                                        }

                                        enable_section = false;
                                      });
                                    })))),
                  ],
                ),
              ),

              // Cycle Selection
              Padding(
                padding: EdgeInsets.only(top: 20, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Current Cycle:",
                      style: font_details(),
                    ),

                    // options
                    Padding(
                        padding: EdgeInsets.only(left: 50),
                        child: Container(
                            height: 21,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11),
                              color: Colors.white,
                            ),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                    value: current_cycle,
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    // Items from the array
                                    items: ['Even', "Odd"].map((String s) {
                                      return DropdownMenuItem(
                                          value: s, child: Text(s));
                                    }).toList(),
                                    onChanged: (String? newVal) {
                                      current_cycle = newVal!;
                                      setState(() {
                                        check(current_cycle);
                                      });
                                    })))),
                  ],
                ),
              ),

              // Semester Selection
              Padding(
                padding: EdgeInsets.only(top: 20, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Select Semester:",
                      style: font_details(),
                    ),

                    // options
                    Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Container(
                            height: 21,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11),
                              color: Colors.white,
                            ),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                    value: dropdownvalue_semester,
                                    icon: Icon(Icons.keyboard_arrow_down),

                                    // Items from the array
                                    items: sem.map((int s) {
                                      return DropdownMenuItem(
                                          value: s, child: Text("${s}"));
                                    }).toList(),

                                    //
                                    onChanged: (int? newVal) {
                                      setState(() {
                                        dropdownvalue_semester = newVal!;
                                        if (dropdownvalue_branch != "CSIOT" ||
                                            dropdownvalue_branch != "AIDS" ||
                                            dropdownvalue_branch != "CSDS") {
                                          select_sections(dropdownvalue_branch,
                                              current_cycle);
                                        }

                                        //Extracting section
                                        section = sections[
                                            '${dropdownvalue_semester}'];

                                        enable_section = newVal != null;
                                      });
                                    })))),
                  ],
                ),
              ),

              // Section Selection
              Padding(
                padding: EdgeInsets.only(top: 20, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Select Section:",
                      style: font_details(),
                    ),

                    // options
                    Padding(
                        padding: EdgeInsets.only(left: 43),
                        child: Container(
                            height: 21,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11),
                              color: Colors.white,
                            ),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                              value: dropdownvalue_section,
                              icon: Icon(Icons.keyboard_arrow_down),
                              // Items from the array
                              items: section.map((String s) {
                                return DropdownMenuItem(
                                    value: s, child: Text(s));
                              }).toList(),

                              //
                              onChanged: enable_section
                                  ? (String? newVal) {
                                      setState(() {
                                        dropdownvalue_section = newVal!;
                                        enable_Course = newVal != null;
                                      });
                                    }
                                  : null,
                            )))),
                  ],
                ),
              ),

              // // Course Selection
              // Padding(
              //   padding: EdgeInsets.only(top: 20, left: 10),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Text(
              //         "Select Course:",
              //         style: font_details(),
              //       ),

              //       // options
              //       Padding(
              //           padding: EdgeInsets.only(left: 45),
              //           child: Container(
              //               height: 21,
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(11),
              //                 color: Colors.white,
              //               ),
              //               child: DropdownButtonHideUnderline(
              //                   child: DropdownButton(
              //                 value: dropdown_course,
              //                 icon: Icon(Icons.keyboard_arrow_down),
              //                 // Items from the array
              //                 items: cse1.map((String s) {
              //                   return DropdownMenuItem(
              //                     value: s,
              //                     child:
              //                         Text(s, overflow: TextOverflow.ellipsis),
              //                   );
              //                 }).toList(),

              //                 //
              //                 onChanged: enable_Course
              //                     ? (String? newVal) {
              //                         setState(() {
              //                           dropdown_course = newVal!;
              //                         });
              //                       }
              //                     : null,
              //               )))),
              //     ],
              //   ),
              // ),

              // Course Name
              Get_Course_Name(),

              // Course code
              Get_Course_Code(),

              // Classes Held
              Get_Classes_Held(),

              Container(
                height: 10,
              ),

              // Submit
              ElevatedButton(
                  onPressed: () {
                    // Validating Part
                    validate_course_name = course_name.text.isEmpty;
                    validate_course_code = course_code.text.isEmpty;
                    validate_classes_held = classes_held.text.isEmpty;

                    // Apppending
                    if (!validate_classes_held &&
                        !validate_course_code &&
                        !validate_course_name) {
                      Course_Names.add(course_name.text.toString());
                      Course_Code.add(course_code.text.toString());
                      classesHeld
                          .add("Classes Held: ${classes_held.text.toString()}");

                      sections_branch_list.add(
                          "${dropdownvalue_semester}${dropdownvalue_section} | ${dropdownvalue_branch}");
                    }

                    print(Course_Names);
                    print(Course_Code);
                    print(sections_branch_list);
                    print(classesHeld);

                    setState(() {});

                    if (!validate_classes_held &&
                        !validate_course_code &&
                        !validate_course_name) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyApp(),
                          ));
                    }
                    setState(() {});
                  },
                  child: Text("ADD")),
            ],
          ),
        ));
  }
}

// Separate Widgets of Course Details
class Get_Course_Name extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Course Name:",
            style: font_details(),
          ),
          Container(
            margin: EdgeInsets.only(left: 23),
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(radius_12()),
              color: Colors.white60,
            ),
            child: TextField(
              // Extracting course name from the text field
              controller: course_name,

              // Restriction to alphabets
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]+$')),
              ],

              decoration: InputDecoration(
                  hintText: "Enter Course Name..",
                  errorText:
                      validate_course_name ? "Field cannot be empty" : null,
                  // Initial border
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(radius_12()),
                      borderSide: BorderSide(
                        color: Colors.black,
                      )),

                  // After selecting
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(radius_12()),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.purple,
                      ))),
            ),
          ),
        ],
      ),
    );
  }
}

class Get_Course_Code extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Course Code:",
            style: font_details(),
          ),
          Container(
            margin: EdgeInsets.only(left: 27),
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(radius_12()),
              color: Colors.white60,
            ),
            child: TextField(
              // obscureText: flag,
              // obscuringCharacter: "*",

              // Extracting course code
              controller: course_code,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z ]+$'))
              ],

              decoration: InputDecoration(

                  // Password Visibility

                  // suffixIcon: InkWell(
                  //     child: Icon(Icons.remove_red_eye),
                  //     onTap: () {
                  //       if (c % 2 == 0) {
                  //         c++;
                  //         flag = false;
                  //         setState(() {});
                  //       }
                  //       else {
                  //         c++;
                  //         flag = true;
                  //         setState(() {});
                  //       }
                  //     }),
                  hintText: "Enter Course Code..",
                  errorText:
                      validate_course_code ? "Field cannot be empty" : null,
                  // Initial border
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(radius_12()),
                      borderSide: BorderSide(
                        color: Colors.black,
                      )),

                  // Border after selecting
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(radius_12()),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.purple,
                      ))),
            ),
          ),
        ],
      ),
    );
  }
}

class Get_Classes_Held extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Classes Held:",
            style: font_details(),
          ),
          //
          Container(
            margin: EdgeInsets.only(left: 23),
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(radius_12()),
              color: Colors.white60,
            ),
            child: TextField(
              // Extracting course name from the text field
              controller: classes_held,

              // Restriction to alphabets
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,

              decoration: InputDecoration(
                  hintText: "Enter number of classes held..",
                  errorText:
                      validate_classes_held ? "Field cannot be empty" : null,
                  // Initial border
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(radius_12()),
                      borderSide: BorderSide(
                        color: Colors.black,
                      )),

                  // After selecting
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(radius_12()),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.purple,
                      ))),
            ),
          ),
        ],
      ),
    );
  }
}