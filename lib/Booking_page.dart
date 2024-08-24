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
    return DateFormat('EEEE, MMMM d').format(date);
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
          title: Text('Choose an option'),
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
          title: Text('Booking Confirmation',textAlign: TextAlign.center,),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Check the details you have provided",textAlign: TextAlign.center,style: TextStyle(
                fontSize: 18,
                color: Colors.black
              ),),
              SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, "/Booking_slip");
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
    return WillPopScope(
      onWillPop: () async{
        final snackBar = SnackBar(
            content: Text('Booking process has been canceled'),
          duration: Duration(seconds: 2),
        );
        await ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Date",
                    style: TextStyle(
                    fontSize: 20
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    child: Text(
                      selectedDate,
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Time",
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
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              const Text("How many people?",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Guests",
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                      Text(guest,
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      _showDialog();
                    },
                    child: Text(
                      "Edit",
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              const Text("Special Request",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Special Request",
                style: TextStyle(
                    fontSize: 15
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Container(
                  height: 240,  // Set the height to 250 pixels
                  child: TextField(
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
                    keyboardType: TextInputType.visiblePassword,
                    maxLines: 6,
                    enableSuggestions: true,
                    enableIMEPersonalizedLearning: true,
                    onSubmitted: (text) {},
                    onChanged: (text) {},
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: (){
                    _show_detail_check();
                   // Navigator.pushNamed(context, "/Booking");
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
