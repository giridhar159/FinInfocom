import 'package:flutter/material.dart';
import 'package:infocom_task/apiServices/homeApi.dart';
import 'package:infocom_task/constants/colorConstant.dart';

class DogImagesScreen extends StatefulWidget {
  const DogImagesScreen({Key? key});

  @override
  State<DogImagesScreen> createState() => _DogImagesScreenState();
}

class _DogImagesScreenState extends State<DogImagesScreen> {
  bool _isLoading = false;

  var dogImg;
  fetchDogImages() async {
    setState(() {
      _isLoading = true;
    });
    var res = await HomeApi().dogImagesApi(context);
    if (res != null && res['status'] == 'success') {
      setState(() {
        dogImg = res['message'];
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      print(res['status']);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    fetchDogImages();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dog Images'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: [
            ElevatedButton.icon(
              // onPressed: _isLoading ? null : fetchDogImages(),
              onPressed: () {
                fetchDogImages();
              },
              style: ElevatedButton.styleFrom(
                  primary: tPrimaryColor, // background
                  onPrimary: tWhite,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5)),
              icon: _isLoading
                  ? Container(
                      width: 24,
                      height: 24,
                      padding: const EdgeInsets.all(2.0),
                      child: const CircularProgressIndicator(
                        color: tWhite,
                        strokeWidth: 3,
                      ),
                    )
                  : const Icon(Icons.refresh),
              label: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text('Refersh'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            dogImg == null
                ? Container()
                : Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: double.infinity,
                    child: Image.network(dogImg, fit: BoxFit.cover),
                  ),
          ],
        ),
      ),
    );
  }
}
