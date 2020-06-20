import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readyuser/models/order.dart';
import 'package:readyuser/services/database.dart';
import 'package:readyuser/shared/constants.dart';

class WriteReview extends StatefulWidget {
  Order order;
  WriteReview({this.order});
  @override
  _WriteReviewState createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double star;
  String review;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Order Details'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.brown[100],
        child: ListView(
          children: <Widget>[
            SizedBox(height: 40.0),
            RatingBar(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.pink[400],
              ),
              onRatingUpdate: (rating) {
                print(rating);
                star = rating;
              },
            ),

            SizedBox(height: 30.0),
            Container(
              height: 10*24.0,
              margin: EdgeInsets.all(12),
              child: TextFormField(
                maxLines: 10,
                decoration: textInputDecoration.copyWith(hintText: 'Enter your review here(optional)'),

                onChanged: (val) {
                  setState(() => review = val);
                },
              ),
            ),

            RaisedButton(
              color: Colors.pink[400],
              child: Text(
                "Submit Review",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                final snackBar = SnackBar(
                  content: Text('Review Submitted!'),
                );
                DatabaseService(uid: userUid).updateReview(widget.order, star, review);
                _scaffoldKey.currentState.showSnackBar(snackBar);
              },
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
