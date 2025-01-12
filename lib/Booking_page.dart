import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {

  late String selectedDate;
  late String selectedTime;
  String guest="For 2";
  late String res_name,res_location;

  final TextEditingController special_request = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set the initial date to the current date
    selectedDate = _formatDate(DateTime.now());
    selectedTime = _formatTime(TimeOfDay.now());
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedDate = _formatDate(picked);
        print(selectedDate);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = _formatTime(picked);
      });
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('EEEE, MMMM d, yyyy').format(date);
  }


  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final formattedTime = DateFormat.jm().format(DateTime(now.year, now.month, now.day, time.hour, time.minute));
    return formattedTime;
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose an option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildOption('For 2'),
              _buildOption('For 4'),
              _buildOption('For 6'),
              _buildOption('For 8'),
              _buildOption('For 10'),
              _buildOption('For 12'),
            ],
          ),
        );
      },
    );
  }

  void _show_detail_check()
  {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Booking Confirmation',textAlign: TextAlign.center,),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text("Check the details you have provided",textAlign: TextAlign.center,style: TextStyle(
                fontSize: 18,
                color: Colors.black
              ),),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, "/Booking_slip",arguments: {
                      'Date':selectedDate,
                      'Time':selectedTime,
                      'Guest':guest,
                      'Special Request':special_request.text.trim(),
                      'Restaurant Name':res_name,
                      'Restaurant Location':res_location
                    });
                    const snackBar = SnackBar(
                      content: Text('Your Table has been Reserved'),
                      duration: Duration(seconds: 2),
                      elevation: 5,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      overlayColor: Colors.grey[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fixedSize: const Size(200, 50),
                      maximumSize: const Size(200, 50),
                      minimumSize: const Size(100, 25)
                  ),
                  child:const Text("Confirm",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  bool checkIf24HoursAhead(String dateString, String timeString) {
    try {
      // Clean the date and time strings to remove non-breaking spaces
      String cleanDateString = dateString.replaceAll('\u202F', ' ').trim();
      String cleanTimeString = timeString.replaceAll('\u202F', ' ').trim();

      // Combine the date and time into a single string
      String combinedDateTimeString = "$cleanDateString $cleanTimeString";

      // Parse the combined date and time string
      DateTime parsedDateTime = DateFormat("EEEE, MMMM d, yyyy h:mm a").parse(combinedDateTimeString);

      // Get the current date and time
      DateTime now = DateTime.now();

      // Calculate the difference in hours
      Duration difference = parsedDateTime.difference(now);

      // Return true if 24 hours ahead or more
      return difference.inHours >= 24;
    } catch (e) {
      debugPrint("Error parsing date and time: $e");
      return false;
    }
  }




  Widget _buildOption(String option) {
    return GestureDetector(
      child: SizedBox(
        width: 500,
        height: 50,
        child: Card(
          child: Material(
            color: Colors.transparent, // This ensures the card's original color is maintained
            child: InkWell(
              onTap: () {
                setState(() {
                  guest = option;
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              splashColor: Colors.red.withOpacity(0.3), // Overlay color when pressed
              highlightColor: Colors.red.withOpacity(0.1), // Highlight color when tapped
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(option),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {


    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    res_name = arguments['res_name'];
    res_location = arguments['res_location'];


    return WillPopScope(
      onWillPop: () async{
        const snackBar = SnackBar(
            content: Text('Booking process has been canceled'),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return true;
    },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Food"),
          automaticallyImplyLeading: true,
          backgroundColor: Colors.red,
          titleSpacing: 50,
          titleTextStyle: const TextStyle(
              fontSize: 25,
              color: Colors.black
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Select a date and time",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Date",
                    style: TextStyle(
                    fontSize: 20
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    child: Text(
                      '${selectedDate.split(',')[0]}, ${selectedDate.split(',')[1]}', // Remove the year part
                      style: const TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Time",
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _selectTime(context);
                    },
                    child: Text(
                      selectedTime,
                      style: const TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("How many people?",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Guests",
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                      Text(guest,
                        style: const TextStyle(
                            fontSize: 20
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      _showDialog();
                    },
                    child: const Text(
                      "Edit",
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Special Request",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Special Request",
                style: TextStyle(
                    fontSize: 15
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: SizedBox(
                  height: 240,  // Set the height to 250 pixels
                  child: TextField(
                    controller: special_request,
                    decoration: const InputDecoration(
                      hintText: "Add Special Request",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0), // Adjust padding for better alignment
                    ),
                    keyboardType: TextInputType.text,
                    maxLines: 6,
                    enableSuggestions: true,
                    enableIMEPersonalizedLearning: true,
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      bool is24HoursAhead = checkIf24HoursAhead(selectedDate, selectedTime);

                      print(special_request.text);
                      //print(selectedDate+"\n"+selectedTime);

                      if (is24HoursAhead) {
                        _show_detail_check();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Reservations must be made at least 24 hours in advance."),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      overlayColor: Colors.grey[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fixedSize: const Size(200, 50),
                      maximumSize: const Size(200, 50),
                      minimumSize: const Size(100, 25)
                  ),
                  child:const Text("Confirm",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}