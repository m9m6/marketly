import 'package:flutter/material.dart';
import 'dart:math' as math;

class OnboardingScreen extends StatefulWidget {
  static const String routeName = '/OnboardingScreen';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  late AnimationController _bgAnimController;

  final List<Map<String, String>> slides = [
    {
      'title': 'Fast Shopping',
      'desc':
      'Browse thousands of products and get them delivered quickly and safely.',
      'image':
      'https://images.unsplash.com/photo-1758526213756-9aecbea6bcfc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=1080',
    },
    {
      'title': 'Discover Categories',
      'desc':
      'Explore curated collections across fashion, electronics, home, and more.',
      'image':
      'https://images.unsplash.com/photo-1743385779347-1549dabf1320?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=1080',
    },
    {
      'title': 'Secure Checkout',
      'desc':
      'Shop with confidence using our secure payment system and easy account management.',
      'image':
      'https://images.unsplash.com/photo-1758611974022-ca3182694951?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=1080',
    },
  ];

  @override
  void initState() {
    super.initState();
    _bgAnimController =
    AnimationController(vsync: this, duration: const Duration(seconds: 8))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _bgAnimController.dispose();
    super.dispose();
  }

  void _goToNext() {
    if (_currentPage < slides.length - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic);
    } else {
      Navigator.pushReplacementNamed(context, '/LoginScreen');
    }
  }

  void _skip() {
    Navigator.pushReplacementNamed(context, '/LoginScreen');
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _bgAnimController,
        builder: (context, _) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.orange.withOpacity(
                      0.2 + 0.2 * math.sin(_bgAnimController.value * math.pi)),
                  Colors.deepOrangeAccent.withOpacity(
                      0.2 + 0.2 * math.cos(_bgAnimController.value * math.pi)),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Content Area
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() => _currentPage = index);
                      },
                      itemCount: slides.length,
                      itemBuilder: (context, index) {
                        final slide = slides[index];
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          transitionBuilder: (child, anim) =>
                              SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0.2, 0),
                                  end: Offset.zero,
                                ).animate(CurvedAnimation(
                                    parent: anim, curve: Curves.easeOut)),
                                child: FadeTransition(
                                  opacity: anim,
                                  child: child,
                                ),
                              ),
                          child: Padding(
                            key: ValueKey(index),
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Image
                                AnimatedScale(
                                  scale: _currentPage == index ? 1.0 : 0.9,
                                  duration: const Duration(milliseconds: 500),
                                  child: Container(
                                    height: screen.width * 0.8,
                                    width: screen.width * 0.8,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.orange.withOpacity(0.3),
                                          blurRadius: 20,
                                          spreadRadius: 5,
                                        )
                                      ],
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: Stack(
                                      children: [
                                        Image.network(
                                          slide['image']!,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.black.withOpacity(0.3),
                                                Colors.transparent
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 40),

                                // Title
                                Text(
                                  slide['title']!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Description
                                Text(
                                  slide['desc']!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.black54,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      slides.length,
                          (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 20),
                        height: 8,
                        width: _currentPage == index ? 32 : 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? Colors.deepOrange
                              : Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  // Buttons
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Row(
                      children: [
                        if (_currentPage < slides.length - 1)
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _skip,
                              style: OutlinedButton.styleFrom(
                                padding:
                                const EdgeInsets.symmetric(vertical: 14),
                                side: const BorderSide(
                                    color: Colors.deepOrange, width: 1.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text(
                                'Skip',
                                style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        if (_currentPage < slides.length - 1)
                          const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _goToNext,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              padding:
                              const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 4,
                            ),
                            child: Text(
                              _currentPage == slides.length - 1
                                  ? 'Get Started'
                                  : 'Next',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
