// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:transcation_history/folders/constants/sizes.dart';
import 'package:transcation_history/folders/widgets/DayGridBox.dart';
import 'package:transcation_history/lib.dart';

class ColorAnimatingBox extends StatefulWidget {
  final bool portait;
  final double portBoxSize;
  final double margin;
  final int totalIndex;
  const ColorAnimatingBox({
    Key? key,
    required this.portait,
    required this.portBoxSize,
    required this.margin,
    required this.totalIndex,
  }) : super(key: key);
  @override
  _ColorAnimatingBoxState createState() => _ColorAnimatingBoxState();
}

class _ColorAnimatingBoxState extends State<ColorAnimatingBox>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 500 + widget.totalIndex * 50),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: Colors.green.shade100,
      end: Colors.green,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Container(
          margin: EdgeInsets.all(widget.portait ? widget.margin : 8),
          width: widget.portait ? widget.portBoxSize : 50,
          height: widget.portait ? widget.portBoxSize : 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: _colorAnimation.value,
          ),
        );
      },
    );
  }
}
