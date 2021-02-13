import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jodi/helperfunctions/data.dart';
import 'package:jodi/helperfunctions/utils.dart';
import 'package:jodi/styleguide/colors.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              _buildTopBar(context),
              Expanded(
                child: MainBottomContainer(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    const paddingTopBottomPercetage = 0.5;
    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 56 * paddingTopBottomPercetage,
        bottom: 40 * paddingTopBottomPercetage,
      ),
      child: Row(
        children: [
          Container(
            height: 20,
            width: 20,
            child: Icon(Icons.person),
          ),
          SizedBox(width: 60),
          Text(
            'Start Swiping',
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor),
          ),
          SizedBox(width: 60),
          Container(
            height: 20,
            width: 20,
            child: Icon(Icons.chat),
          ),
        ],
      ),
    );
  }
}

class MainBottomContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: constraints.maxHeight * .2,
                color: Colors.white.withOpacity(.1),
              ),
            ),
            Container(
              height: constraints.maxHeight * .8,
              child: SwipeCardsView(),
            ),
            SizedBox(height: 100),
            Center(
              child: Row(
                children: <Widget>[
                  RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 21),
                    onPressed: () {},
                    child: Text(
                      'SKIP',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.pinkAccent,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    onPressed: () {},
                    child: Text(
                      'MATCH',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.pinkAccent,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

List<User> userList = [
  User(image: AssetImage('assets/images/anne.jpeg')),
  User(image: AssetImage('assets/images/lana.jpg')),
  User(image: AssetImage('assets/images/rena.jpg')),
];

final swipeCardsViewStateKey = GlobalKey<_SwipeCardsViewState>();

class SwipeCardsView extends StatefulWidget {
  @override
  _SwipeCardsViewState createState() => _SwipeCardsViewState();
}

class _SwipeCardsViewState extends State<SwipeCardsView> {
  List<Widget> widgetList = [];
  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return LayoutBuilder(
      builder: (context, constraints) {
        var maxheight = constraints.maxHeight;
        var maxwidth = constraints.maxWidth;

        return Stack(
          children: widgetList = buildCardList(
            maxwidth,
            maxheight,
            screenwidth,
            screenheight,
            reloadUI,
          ),
        );
      },
    );
  }

  reloadUI() {
    setState(() {});
  }

  List<Widget> buildCardList(double maxwidth, double maxheight,
      double screenwidth, double screenheight, Function() reloadUI) {
    widgetList = [];
    for (var i = 0; i < userList.length; i++) {
      widgetList.add(ProfileCard(
        key: UniqueKey(),
        i: i,
        user: userList[i],
        previousProfile: widgetList.length > 1 ? widgetList[i - 1] : null,
        maxheight: maxheight,
        maxwidth: maxwidth,
        screenheight: screenheight,
        screenwidth: screenwidth,
        reloadUI: reloadUI,
      ));
    }

    return widgetList;
  }
}

class ProfileCard extends StatefulWidget {
  final screenwidth;
  final screenheight;
  final maxheight;
  final maxwidth;

  final i;
  final ProfileCard previousProfile;
  final User user;
  final reloadUI;

  _ProfileCardState state;

  ProfileCard({
    Key key,
    this.i,
    this.previousProfile,
    this.user,
    this.screenwidth,
    this.screenheight,
    this.maxheight,
    this.maxwidth,
    this.reloadUI,
  }) : super(key: key);

  @override
  _ProfileCardState createState() => this.state = _ProfileCardState();

  void refresh() {
    this.state.refresh();
  }
}

bool isPreviousNowOnForeground = false;

class _ProfileCardState extends State<ProfileCard> {
  double posX = 0, posY = 0;
  Direction dragDirection = Direction.NONE;

  var boundToSwipe = .25;
  var ratioX = 0.8;
  var ratioY = 0.8;
  bool isMoving = false;

  double scale = .95;
  double angleDegree = 0;
  double isDraggingFrom = 0;
  Offset initialPosition;
  Offset oldPositionForDirection = Offset.zero;

  @override
  Widget build(BuildContext context) {
    var centerOffset = Offset(widget.maxwidth / 2, widget.maxheight / 2);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GestureDetector(
        onPanStart: (details) {
          _onPanStart(details);
        },
        onPanEnd: (details) {
          _onPanEnd();
        },
        onPanCancel: () {
          _onPanCancel();
        },
        onPanUpdate: (details) {
          _onPanUpdate(details);
        },
        child: AnimatedContainer(
          transform: Matrix4.identity()
            ..translate(
              posX,
              posY,
              0,
            )
            ..rotateDegrees(angleDegree, origin: centerOffset)
            ..scaleWithOrigin(
                widget.i == userList.length - 1 ||
                        (widget.i == userList.length - 2 &&
                            isPreviousNowOnForeground)
                    ? 1
                    : (95 + (5 * ratioX.abs().clamp(0.0, 1.0))),
                origin: centerOffset),
          duration: Duration(milliseconds: isMoving ? 0 : 300),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  blurRadius: 4.0,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                ),
              ],
              borderRadius: BorderRadius.circular(20),
              image:
                  DecorationImage(fit: BoxFit.cover, image: widget.user.image)),
        ),
      ),
    );
  }

  void _onPanStart(DragStartDetails details) {
    isMoving = true;

    isDraggingFrom = details.localPosition.dy > (widget.maxheight / 2) ? -1 : 1;
    initialPosition = details.localPosition;
  }

  void _onPanEnd() {
    var hasSwiped = false;
    var boundToSwipe = .25;

    if (ratioX > boundToSwipe && dragDirection == Direction.RIGHT) {
      hasSwiped = true;
      posX = 2 * widget.screenwidth;
    } else if (ratioX < -boundToSwipe && dragDirection == Direction.LEFT) {
      hasSwiped = true;
      posX = -2 * widget.screenwidth;
    } else if (ratioY < -boundToSwipe && dragDirection == Direction.UP) {
      hasSwiped = true;
      posY = -widget.screenheight;
    } else {
      _onPanCancel();
    }

    if (hasSwiped) {
      setState(() {
        isPreviousNowOnForeground = true;
        isMoving = false;
      });

      widget.previousProfile.refresh();

      Future.delayed(Duration(milliseconds: 200), () {
        userList.removeAt(userList.length - 1);
        userList.insert(
            0,
            User(
                image: NetworkImage(
                    "https://picsum.photos/200/300?random=${Random().nextInt(10000)}")));
        resetValues();
        this.widget.reloadUI();
      });
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      posX += details.delta.dx;
      posY += details.delta.dy;

      var directionX = offsetDelta(details.localPosition).dx < 0 ? -1 : 1;
      ratioX = offsetDelta(details.localPosition).dx / widget.screenwidth;
      ratioY = offsetDelta(details.localPosition).dy / widget.screenwidth;

      angleDegree = isDraggingFrom * directionX * ratioX.abs() * 45;
    });

    widget.previousProfile?.refresh();

    _computeDragDirection(details);
  }

  _computeDragDirection(DragUpdateDetails details) {
    Offset localPosition = details.localPosition;

    if (localPosition.dy < oldPositionForDirection.dy) {
      dragDirection = Direction.UP;
    } else if (localPosition.dy > oldPositionForDirection.dy) {
      dragDirection = Direction.DOWN;
    }

    if (localPosition.dy < oldPositionForDirection.dy) {
      if (dragDirection == Direction.UP) {
        if ((localPosition.dx - oldPositionForDirection.dx).abs() >
            (localPosition.dy - oldPositionForDirection.dy).abs()) {
          dragDirection = Direction.LEFT;
        }
      }
    } else if (dragDirection == Direction.DOWN) {
      if ((localPosition.dx - oldPositionForDirection.dx).abs() >
          (localPosition.dy - oldPositionForDirection.dy).abs()) {
        dragDirection = Direction.RIGHT;
      }
    }
  }

  void _onPanCancel() {
    setState(() {
      resetValues();
    });
  }

  resetValues() {
    posX = 0;
    posY = 0;
    isMoving = false;
    ratioX = 0;
    angleDegree = 0;
    ratioY = 0;
    dragDirection = Direction.NONE;
    oldPositionForDirection = Offset.zero;
  }

  Offset offsetDelta(Offset currentPosition) {
    return currentPosition - initialPosition;
  }

  refresh() {
    setState(() {});
  }
}

enum Direction { HOME, LEFT, RIGHT, UP, DOWN, NONE }
