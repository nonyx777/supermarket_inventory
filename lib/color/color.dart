import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supermarket_inventory/View/Profile/change_notifier.dart';

const blueBlack = Color(0xFF14213D);
const orangeAccent = Color(0xFFFCA311);
const greyishWhite = Color(0xFFE5E5E5);
const pureWhite = Colors.white;
Color grey200 = Colors.grey.shade200;
Color grey300 = Colors.grey.shade300;
Color grey400 = Colors.grey.shade400;
Color grey500 = Colors.grey.shade500;
Color grey700 = Colors.grey.shade700;
const productTileColor = Color.fromARGB(255, 229, 229, 229);
const productTileButtonColor = Color.fromARGB(255, 252, 248, 248);
const pureBlack = Colors.black;
const dangerRed = Colors.red;

const TextStyle kHelveticaStyle = TextStyle(
  fontFamily: 'Helvetica',
);

const String kHelveticaFontFamily = 'Helvetica';

const TextStyle kMLightStyle = TextStyle(
  fontFamily: kHelveticaFontFamily,
  fontWeight: FontWeight.w300,
  fontStyle: FontStyle.normal,
  fontSize: 12.0,
);

const TextStyle kMRegularStyle = TextStyle(
  fontFamily: kHelveticaFontFamily,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
  fontSize: 15.0,
);

const TextStyle kMSemiBoldStyle = TextStyle(
  fontFamily: kHelveticaFontFamily,
  fontWeight: FontWeight.w600,
  fontStyle: FontStyle.normal,
  fontSize: 16.0,
);

const TextStyle kMBoldStyle = TextStyle(
  fontFamily: kHelveticaFontFamily,
  fontWeight: FontWeight.bold,
  fontStyle: FontStyle.normal,
  fontSize: 20.0,
);

class MyTheme {
  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: Colors.white,
        secondary: Color(0xFFFCA311),
      ),
      scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.black,
        backgroundColor: const Color(0xFFFCA311),
        centerTitle: true,
        titleTextStyle: GoogleFonts.nunitoSans(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.openSans(
          fontSize: 26.0,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        bodyMedium: GoogleFonts.openSans(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        bodySmall: GoogleFonts.openSans(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        displayLarge: GoogleFonts.openSans(
          fontSize: 46.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        displayMedium: GoogleFonts.openSans(
          fontSize: 25.0,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        displaySmall: GoogleFonts.openSans(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        labelSmall: GoogleFonts.openSans(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        labelMedium: GoogleFonts.openSans(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF14213D),
        secondary: Color(0xFFE5E5E5),
      ),
      scaffoldBackgroundColor: const Color(0xFF14213D),
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF14213D),
        centerTitle: true,
        titleTextStyle: GoogleFonts.nunitoSans(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.openSans(
          fontSize: 26.0,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        bodyMedium: GoogleFonts.openSans(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        bodySmall: GoogleFonts.openSans(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        displayLarge: GoogleFonts.openSans(
          fontSize: 46.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        displayMedium: GoogleFonts.openSans(
          fontSize: 25.0,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        displaySmall: GoogleFonts.openSans(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        labelSmall: GoogleFonts.openSans(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        labelMedium: GoogleFonts.openSans(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  static AppTheme currentTheme = AppTheme.light;

  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
  );

  static ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
  );
}
