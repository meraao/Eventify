import 'package:flutter/material.dart';


const Color kScaffoldBackground = Color(0xFF2C2C2C);
const Color kDarkGreen = Color(0xFF3A6B4C);
const Color kMediumGreen = Color(0xFF6A9B7A);
const Color kLightGreen = Color(0xFF9DC8A8);
const Color kTextGreen = Color(0xFFA8D5B4);
const Color kButtonGreen = Color(0xFF4A7C59);
const Color kTextColor = Colors.white;

class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  bool _isPasswordObscured = true; // To track password visibility

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    // Add listeners to rebuild on text change
    _usernameController.addListener(_onTextChange);
    _passwordController.addListener(_onTextChange);
  }

  void _onTextChange() {
    setState(() {
      // This forces a rebuild, which will update the clear button's visibility
    });
  }

  @override
  void dispose() {
    // Remove listeners to avoid memory leaks
    _usernameController.removeListener(_onTextChange);
    _passwordController.removeListener(_onTextChange);
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with waves
            _buildHeader(),
            // Login form
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome Text
                  Text.rich(
                    TextSpan(
                      text: 'Welcome to ',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: kTextColor,
                      ),
                      children: [
                        TextSpan(
                          text: 'Eventify!',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: kTextGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Log In Text
                  const Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: kTextColor,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Username Field
                  _buildTextField(
                    controller: _usernameController,
                    label: 'Username',
                  ),
                  const SizedBox(height: 20),
                  // Password Field
                  _buildTextField(
                    controller: _passwordController,
                    label: 'Password',
                    isPassword: true,
                  ),
                  const SizedBox(height: 40),
                  // Log In Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final username = _usernameController.text;
                        final password = _passwordController.text;
                        print('Login attempt: $username / $password');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kButtonGreen,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kTextColor,
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
  }

  /// Builds the wavy header
  Widget _buildHeader() {
    return Container(
      height: 250, // Height for the waves area
      color: kScaffoldBackground, // Base color
      child: Stack(
        children: [
          // We stack 3 waves, each slightly offset and with a different color
          ClipPath(
            clipper: WaveClipper(waveHeight: 180, controlPointYOffset: 20),
            child: Container(color: kLightGreen.withOpacity(0.8)),
          ),
          ClipPath(
            clipper: WaveClipper(waveHeight: 160, controlPointYOffset: 10),
            child: Container(color: kMediumGreen.withOpacity(0.9)),
          ),
          ClipPath(
            clipper: WaveClipper(waveHeight: 140, controlPointYOffset: 0),
            child: Container(color: kDarkGreen),
          ),
        ],
      ),
    );
  }

  /// Helper widget for creating styled TextFormFields
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword
          ? _isPasswordObscured
          : false, // Only obscure if it's a password and toggled
      style: const TextStyle(color: kTextColor),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: kTextColor),
        // Suffix icon logic updated
        suffixIcon: isPassword
            ? IconButton(
                // This is the password field, show visibility toggle
                icon: Icon(
                  _isPasswordObscured ? Icons.visibility_off : Icons.visibility,
                  color: kTextColor,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordObscured = !_isPasswordObscured;
                  });
                },
              )
            : (controller.text.isEmpty
                ? null // This is the username field, show clear button only if not empty
                : IconButton(
                    icon: const Icon(Icons.cancel_outlined, color: kTextColor),
                    onPressed: () => controller.clear(),
                  )),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: kTextColor, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: kTextGreen, width: 2),
        ),
      ),
    );
  }
}

/// CustomClipper for creating the wave effect
class WaveClipper extends CustomClipper<Path> {
  final double waveHeight;
  final double controlPointYOffset;

  WaveClipper({this.waveHeight = 160.0, this.controlPointYOffset = 0});

  @override
  Path getClip(Size size) {
    // This creates the wave path
    // We use quadratic Bezier curves for a smooth wave
    final path = Path();
    path.lineTo(0, waveHeight - 40); // Start point

    // First wave
    final firstControlPoint = Offset(
      size.width / 4,
      waveHeight - 40 + controlPointYOffset,
    );
    final firstEndPoint = Offset(size.width / 2.2, waveHeight - 20);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    // Second wave
    final secondControlPoint = Offset(
      size.width - (size.width / 3.5),
      waveHeight - 80 - controlPointYOffset,
    );
    final secondEndPoint = Offset(size.width, waveHeight - 60);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    // Close the path
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false; // No need to reclip
  }
}
