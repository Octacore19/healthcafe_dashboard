import 'package:flutter/material.dart';

typedef TransitionAnimationBuilder = Widget Function(
  BuildContext,
  Animation<double>,
  Animation<double>,
  Widget,
);

abstract class AppPage<P> extends Page<P> {
  const AppPage({
    ValueKey? key,
    required this.args,
    this.transitionDuration = 400,
    this.reverseTransitionDuration = 400,
    this.fullscreenDialog = false,
    this.animationBuilder,
  }) : super(key: key);

  final Map<String, dynamic> args;

  final int transitionDuration, reverseTransitionDuration;

  final TransitionAnimationBuilder? animationBuilder;

  final bool fullscreenDialog;

  Widget build(BuildContext context);

  @override
  Route<P> createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      fullscreenDialog: fullscreenDialog,
      transitionDuration: Duration(milliseconds: transitionDuration),
      reverseTransitionDuration:
          Duration(milliseconds: reverseTransitionDuration),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        if (animationBuilder != null) {
          return animationBuilder!.call(
            context,
            animation,
            secondaryAnimation,
            child,
          );
        }
        return _defaultAnimationBuilder(
          context,
          animation,
          secondaryAnimation,
          child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) => build(context),
    );
  }

  ///provide a default Transition for the app (you can delete it if you want, flutter already has one)
  Widget _defaultAnimationBuilder(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.elasticIn;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }
}
