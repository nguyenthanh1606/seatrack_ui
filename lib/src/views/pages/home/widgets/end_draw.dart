import 'package:flutter/material.dart';

class EndDrawHome extends StatelessWidget {
  const EndDrawHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              height: 150,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        'Danh sách xe'.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 0.0),
                itemCount: 22,
                itemBuilder: (context, index) {
                  return Ink(
                    color: true ? Colors.white : null,
                    child: ListTile(
                      title: Text("profession.heading"),
                      onTap: () {},
                      leading: index == 0
                          ? Icon(
                              Icons.home,
                            )
                          : Icon(Icons.description),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
