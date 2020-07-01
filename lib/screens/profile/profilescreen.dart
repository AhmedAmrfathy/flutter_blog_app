import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/helper/helpermethod.dart';
import 'package:flutterapp/providers/profile/profilescreen_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profiledata = Provider.of<ProfileScreenProvider>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            InkWell(
              onTap: () {
                profiledata.getImage();
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.redAccent)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: profiledata.image == null
                      ? Image.network(
                          'https://www.aljadeed.com/wp-content/plugins/all-in-one-seo-pack-pro/images/default-user-image.png',
                          fit: BoxFit.fill,
                        )
                      : Image.file(
                          profiledata.image,
                          fit: BoxFit.fill,
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: profiledata.textEditingController,
                  decoration: InputDecoration(hintText: 'new user '),
                )),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 100,
              height: 50,
              child: profiledata.isloading
                  ? CircularProgressIndicator(
                      strokeWidth: 5,
                    )
                  : FloatingActionButton(
                      onPressed: () async {
                        profiledata.changestatus();
                        await profiledata.uploadImage();
                        try {
                          await profiledata
                              .savedata(profiledata.textEditingController.text);
                          Navigator.of(context).pop();
                          profiledata.changestatus();

                        } catch (error) {
                     await     HelperMethod.showerrordialog('sorry an error occurd', context);
                     Navigator.of(context).pop();
                     profiledata.changestatus();
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Text('Save data'),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
