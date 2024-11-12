import 'package:flutter/material.dart';

class AnimatedGradientButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final bool isButtonDisabled;
  const AnimatedGradientButton({super.key, required this.buttonText, required this.onPressed, this.isButtonDisabled = false});

  @override
  _AnimatedGradientButtonState createState() => _AnimatedGradientButtonState();
}

class VoidCallBack {
}

class _AnimatedGradientButtonState extends State<AnimatedGradientButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1, milliseconds: 350),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.repeat(); // Restart the animation to create a continuous flow
        }
      });

    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: widget.isButtonDisabled
              ? LinearGradient(colors: [Colors.grey.shade500, Colors.grey.shade500])
              : LinearGradient(
                  colors: const [
                    Color(0xFFFFA726),
                    Color(0xFFFFD466), 
                  ],
              stops: [
                _controller.value,                      
                _controller.value + 0.2 < 1.0 
                  ? _controller.value + 0.3 
                  : 1.0,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: TextButton(
            onPressed: widget.isButtonDisabled? null : widget.onPressed,
            child: Text(
              widget.buttonText,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)
            ),
          ),
        );
      },
    );
  }
}
