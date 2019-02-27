import 'package:flutter/material.dart';

class QuestionText extends StatefulWidget {
  final String _question;
  final int _questionNumber;

  QuestionText(this._question, this._questionNumber);

  @override
  State<StatefulWidget> createState() => QuestionTextState();
}

class QuestionTextState extends State<QuestionText>
    with SingleTickerProviderStateMixin {
  Animation<double> _fontSizeAnimation;
  AnimationController _fontSizeAnimationController;

  @override
  void initState() {
    super.initState();
    _fontSizeAnimationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _fontSizeAnimation = CurvedAnimation(
        parent: _fontSizeAnimationController, curve: Curves.bounceOut);
    _fontSizeAnimation.addListener(() => this.setState(() {}));
    _fontSizeAnimationController.forward();
  }

  @override
  void dispose() {
    _fontSizeAnimationController.dispose();
    super.dispose();
  }


  // 每次更新问题后, 问题 widget 也要有动画.
  @override
  void didUpdateWidget(QuestionText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget._question != widget._question) {
      _fontSizeAnimationController.reset();
      _fontSizeAnimationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Center(
          child: Text(
            "Statement " +
                widget._questionNumber.toString() +
                " : " +
                widget._question,
            style: TextStyle(fontSize: _fontSizeAnimation.value * 15),
          ),
        ),
      ),
    );
  }
}
