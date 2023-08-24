import 'package:flutter/material.dart';
import 'package:schoolapp/ApiCalls/RatingController.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateTeachers extends StatefulWidget {
  const RateTeachers({super.key});

  @override
  State<RateTeachers> createState() => _RateTeachersState();
}

class _RateTeachersState extends State<RateTeachers> {
  double _rating = 0;
  void _showCustomDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Add your custom UI here
                Text(
                  'Rate This Teacher',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 10.0),
                RatingBar(
                  initialRating: _rating,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                    full: Icon(Icons.star, color: Colors.amber),
                    half: Icon(Icons.star_half, color: Colors.amber),
                    empty: Icon(Icons.star_border, color: Colors.amber),
                  ),
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Text('Close'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        rateTeachers(_rating, id);
                        Navigator.pop(context); // Close the dialog
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 220) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Rate Our Teachers',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<Employee>>(
        future: fetchTeachers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No data available.');
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // Number of columns
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 1.0,
                  childAspectRatio: 5.5),
              itemCount: snapshot.data!.length - 1,
              itemBuilder: (context, index) {
                final item = snapshot.data![index + 1];
                return Card(
                  elevation: 5.0,
                  child: ListTile(
                    title: Text(
                        'Name :${snapshot.data![index + 1].firstName}${item.lastName}'),
                    subtitle: Text('Postition: ${item.jobPosition}'),
                    trailing: GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'More',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      onTap: () {
                        _showCustomDialog(context, item.id);
                      },
                    ),
                    // Customize the ListTile to display the desired data fields
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
