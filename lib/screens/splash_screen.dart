import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/SplashScreen';

  final VoidCallback? onComplete;

  const SplashScreen({super.key, this.onComplete});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _splitController;
  late AnimationController _cartController;
  late Animation<double> _leftAnim;
  late Animation<double> _rightAnim;

  @override
  void initState() {
    super.initState();

    // Animation controllers
    _splitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _cartController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // حركة النصفين (يمين / شمال)
    _leftAnim = Tween<double>(begin: 0, end: -1).animate(
      CurvedAnimation(parent: _splitController, curve: Curves.easeInOutCubic),
    );
    _rightAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _splitController, curve: Curves.easeInOutCubic),
    );

    // بعد ثانيتين يبدأ الانقسام
    Timer(const Duration(seconds: 2), () {
      _splitController.forward();
    });

    // بعد 2.9 ثانية يفتح شاشة Onboarding
    Timer(const Duration(milliseconds: 2900), () {
      if (widget.onComplete != null) {
        widget.onComplete!();
      } else {
        Navigator.of(context).pushReplacementNamed('/OnboardingScreen');
      }
    });
  }

  @override
  void dispose() {
    _splitController.dispose();
    _cartController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // اللون الأبيض الأساسي (يظهر بعد الانقسام)
          Container(color: Colors.white),

          // نصفين متحركين (يمين وشمال)
          AnimatedBuilder(
            animation: _splitController,
            builder: (context, child) {
              return Stack(
                children: [
                  // Left half
                  Transform.translate(
                    offset: Offset(_leftAnim.value * (screen.width / 2), 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: screen.width / 2,
                        height: screen.height,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.deepOrange, Colors.orangeAccent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Right half
                  Transform.translate(
                    offset: Offset(_rightAnim.value * (screen.width / 2), 0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: screen.width / 2,
                        height: screen.height,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.deepOrange, Colors.orangeAccent],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // المحتوى الأوسط (الابتسامة والعنوان)
          Center(
            child: FadeTransition(
              opacity: Tween<double>(begin: 1, end: 0).animate(
                CurvedAnimation(
                  parent: _splitController,
                  curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // عربة التسوق المبتسمة
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _cartController,
                        builder: (context, child) {
                          final rotate =
                              math.sin(_cartController.value * math.pi) * 10;
                          return Transform.rotate(
                            angle: rotate * math.pi / 180,
                            child: child,
                          );
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.3),
                                blurRadius: 25,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                            size: 60,
                          ),
                        ),
                      ),
                      CustomPaint(
                        size: const Size(120, 120),
                        painter: SmilePainter(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    "Marketly",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  const Text(
                    "Your Shopping Companion",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // النقاط المتحركة
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (i) {
                      return AnimatedBuilder(
                        animation: _cartController,
                        builder: (context, child) {
                          final scale = 1 +
                              math.sin((_cartController.value * 2 * math.pi) +
                                  (i * 0.6)) *
                                  0.3;
                          return Transform.scale(
                            scale: scale,
                            child: Container(
                              margin:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.white
                                    .withOpacity(0.6 + i * 0.2),
                                shape: BoxShape.circle,
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SmilePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final eyePaint = Paint()..color = Colors.white;

    // Eyes
    canvas.drawCircle(Offset(size.width * 0.38, size.height * 0.38), 3, eyePaint);
    canvas.drawCircle(Offset(size.width * 0.62, size.height * 0.38), 3, eyePaint);

    // Smile
    final path = Path()
      ..moveTo(size.width * 0.35, size.height * 0.48)
      ..quadraticBezierTo(
          size.width * 0.5, size.height * 0.6, size.width * 0.65, size.height * 0.48);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
