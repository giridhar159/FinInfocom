import 'package:flutter/material.dart';
import 'package:infocom_task/apiServices/homeApi.dart';
import 'package:infocom_task/constants/colorConstant.dart';
import 'package:infocom_task/globalFunctions/globalFunctions.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var profileDetails;
  fetchProfile() async {
    var res = await HomeApi().profileApi(context);
    if (res != null) {
      setState(() {
        profileDetails = res['results'];
      });
    } else {
      print('Something went wrong');
    }
  }

  @override
  void initState() {
    fetchProfile();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile screen'),
      ),
      body: profileDetails == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: profileDetails.length,
              itemBuilder: (context, index) {
                var profileDetail = profileDetails[index];
                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Card(
                    color: tWhite.withOpacity(0.5),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(profileDetail['picture']
                                ['medium']), // Replace with actual image
                          ),
                          SizedBox(height: 20),
                          Text(
                            profileDetail['name']['title'] +
                                profileDetail['name']['first'] +
                                profileDetail['name']['last'],
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            profileDetail['location']['street']['number']
                                    .toString() +
                                profileDetail['location']['street']['name'] +
                                profileDetail['location']['city'] +
                                profileDetail['location']['state'] +
                                profileDetail['location']['country'] +
                                ' ,' +
                                profileDetail['location']['postcode'].toString(),
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          SizedBox(height: 20),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(fontSize: 18, color: Colors.black),
                              children: [
                                TextSpan(
                                  text: 'Email: ',
                                ),
                                TextSpan(
                                  text: profileDetail['email'].toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(fontSize: 18, color: Colors.black),
                              children: [
                                TextSpan(
                                  text: 'Date of Birth: ',
                                ),
                                TextSpan(
                                  text: GlobalFunction.dateFormate(
                                      profileDetail['dob']['date'].toString()),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(fontSize: 18, color: Colors.black),
                              children: [
                                TextSpan(
                                  text:
                                      'Number of Days Passed Since Registered: ',
                                ),
                                TextSpan(
                                  text: getDaysSinceRegistered(DateTime.parse(
                                              profileDetail['registered']['date']
                                                  .toString()))
                                          .toString() +
                                      ' days',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
    );
  }

  int getDaysSinceRegistered(registrationDate) {
    final currentDate = DateTime.now();
    final daysPassed = currentDate.difference(registrationDate).inDays;
    return daysPassed;
  }
}
