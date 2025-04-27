import 'package:flutter/material.dart';

extension WiidgetExtension on Widget {
  Widget giveHPadding({double? padding}) => Padding(
        padding: EdgeInsets.symmetric(horizontal: padding ?? 0),
        child: this,
      );
  Widget giveVPadding({double? padding}) => Padding(
        padding: EdgeInsets.symmetric(vertical: padding ?? 0),
        child: this,
      );

  Widget giveBPadding({double? padding}) => Padding(
        padding: EdgeInsets.only(bottom: padding ?? 0),
        child: this,
      );
  Widget giveTPadding({double? padding}) => Padding(
        padding: EdgeInsets.only(top: padding ?? 0),
        child: this,
      );
  Widget giveRPadding({double? padding}) => Padding(
        padding: EdgeInsets.only(right: padding ?? 0),
        child: this,
      );
  Widget giveLPadding({double? padding}) => Padding(
        padding: EdgeInsets.only(left: padding ?? 0),
        child: this,
      );
}
