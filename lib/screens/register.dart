import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

TextEditingController dateinput = TextEditingController();

const List<String> list = <String>['Male', 'Female'];

class _RegisterState extends State<Register> {
  String dropdownValue = list.first;
  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Register',
          style: TextStyle(color: Colors.white, fontSize: 19),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Registration Form',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 56, 56, 56)),
            ),
            SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                  hintText: 'First name',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12)),
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Last name',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12)),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150,
                  child: TextField(
                    controller:
                        dateinput, //editing controller of this TextField
                    decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today), //icon of text field
                        labelText: " Birth Date",
                        labelStyle:
                            TextStyle(fontSize: 12) //label text of field
                        ),
                    readOnly:
                        true, //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(
                              2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat.yMMMMd('en_US').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                        setState(() {
                          dateinput.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right:15.0,top: 10),
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
                )
              ],
            ),
           const  SizedBox(height: 20,),
            TextField(
              maxLines: 7,
              decoration: InputDecoration(
                hintText: 'Write Something about YourSelf',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                
                hintStyle: TextStyle(fontSize: 12)
                
                

              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10)),
                     child: Padding(
                       padding: const EdgeInsets.all(10.0),
                       child: Text(
                         'Apply Now',
                         style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Colors.white),
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
