import 'package:flutter/material.dart';
import '../widgets/cat.dart';
import 'dart:math';

class Home extends StatefulWidget 
{
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin
{
  late Animation<double> catAnimation;
  late AnimationController catController;

  late Animation<double> boxAnimation;
  late AnimationController boxController;

  @override
  void initState() 
  {
    super.initState();

    catController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this
    );

    catAnimation = Tween(begin: -35.0, end: -80.0)
      .animate(
        CurvedAnimation(
          parent: catController,
          curve: Curves.easeIn
        ),
      );
    
    boxController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this
    );

    boxAnimation = Tween(begin: pi * 0.6, end: pi * 0.65)
      .animate(
        CurvedAnimation(
          parent: boxController, 
          curve: Curves.easeInOut
        ),
      );

    boxController.addStatusListener(
      (status) {
        if(status == AnimationStatus.completed) 
        {
          boxController.reverse();
        }
        else if (status == AnimationStatus.dismissed) 
        {
          boxController.forward();
        }
      }
    );

    boxController.forward();
  }

  onTap() 
  {
    if(catController.status == AnimationStatus.completed)
    {
      catController.reverse();
      boxController.forward();
    }
    else if (catController.status == AnimationStatus.dismissed) 
    {
      boxController.stop();
      catController.forward();
    }
    // else if (catController.status == AnimationStatus.forward) 
    // {
    //   catController.reverse();
    // }
    // else if (catController.status == AnimationStatus.reverse) 
    // {
    //   catController.forward();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat in Box'),
      ),
      body: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              buildCatAnimation(catAnimation),
              buildCatBox(),
              buildLeftFlap(boxAnimation),
              buildRightFlap(boxAnimation),
          ]),
        ),
      ),
    );
  }
}

Widget buildCatAnimation(catAnimation) 
{
  return AnimatedBuilder(
    animation: catAnimation, 
    builder: (context, child) 
    {
      return Positioned(
        top: catAnimation.value,
        left: 0,
        right: 0,
        child: child!,
      );
    },
    child: const Cat(),
    );
}

Widget buildCatBox() 
{
  return Container(
    width: 200,
    height: 200,
    color: Colors.brown,
  );
}

Widget buildLeftFlap(boxAnimation) 
{
  return Positioned(
    left: 10,
    top: 4.5,
    child: AnimatedBuilder(
      animation: boxAnimation,
      builder: (context, child) 
      {
        return Transform.rotate(
          angle: boxAnimation.value,
          alignment: Alignment.topLeft,
          child: child,
        );
      },
      child: Container(
        width: 100,
        height: 10,
        color: Colors.brown,
      ),
    ),
  );
}

Widget buildRightFlap(boxAnimation) 
{
  return Positioned(
    right: 10,
    top: 4.5,
    child: AnimatedBuilder(
      animation: boxAnimation,
      builder: (context, child) 
      {
        return Transform.rotate(
          angle: -boxAnimation.value,
          alignment: Alignment.topRight,
          child: child,
        );
      },
      child: Container(
        width: 100,
        height: 10,
        color: Colors.brown,
      ),
    ),
  );
}