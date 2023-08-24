import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ApplyForTutor extends StatefulWidget {
  const ApplyForTutor({super.key});

  @override
  State<ApplyForTutor> createState() => _ApplyForTutorState();
}

const List<String> list = <String>[
  'Maths',
  'English',
  'Chemistry',
  'Biology',
  'Physics'
];

class _ApplyForTutorState extends State<ApplyForTutor> {
  String dropdownValue = list.first;

  TextEditingController timeinput = TextEditingController();
  //text editing controller for text field

  @override
  void initState() {
    timeinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Apply For Tutor',
          style: TextStyle(color: Colors.white, fontSize: 19),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Registration Form',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 56, 56, 56)),
            ),
            const SizedBox(height: 30),
            const TextField(
              decoration: InputDecoration(
                  hintText: 'First name',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12)),
            ),
            const SizedBox(height: 15),
            const TextField(
              decoration: InputDecoration(
                  hintText: 'Last name',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12)),
            ),
            const SizedBox(height: 15),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 200,
                  child: TextField(
                    controller:
                        timeinput, //editing controller of this TextField
                    decoration: const InputDecoration(
                        icon: Icon(Icons.timer), //icon of text field
                        labelText: "Enter Preffered Time" //label text of field
                        ),
                    readOnly:
                        true, //set it true, so that user will not able to edit text
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );

                      if (pickedTime != null) {
                        print(pickedTime.format(context)); //output 10:51 PM
                        DateTime parsedTime = DateFormat.jm('en_US')
                            .parse(pickedTime.format(context).toString());
                        //converting to DateTime so that we can further format on different pattern.
                        print(parsedTime); //output 1970-01-01 22:53:00.000
                        String formattedTime =
                            DateFormat('HH:mm:ss').format(parsedTime);
                        print(formattedTime); //output 14:59:00
                        //DateFormat() is from intl package, you can format the time on any pattern you need.

                        setState(() {
                          timeinput.text =
                              formattedTime; //set the value of text field.
                        });
                      } else {
                        print("Time is not selected");
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0, top: 10),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Apply Now',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
