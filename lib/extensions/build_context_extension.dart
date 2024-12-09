import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension TextThemeExtension on TextTheme {
  // Display
  // Large
  TextStyle? get displayLargeNormal =>
      displayLarge?.copyWith(fontWeight: FontWeight.normal);
  TextStyle? get displayLargeBold =>
      displayLarge?.copyWith(fontWeight: FontWeight.bold);

  // Medium
  TextStyle? get displayMediumNormal =>
      displayMedium?.copyWith(fontWeight: FontWeight.normal);
  TextStyle? get displayMediumBold =>
      displayMedium?.copyWith(fontWeight: FontWeight.bold);

  // Small
  TextStyle? get displaySmallNormal =>
      displaySmall?.copyWith(fontWeight: FontWeight.normal);
  TextStyle? get displaySmallBold =>
      displaySmall?.copyWith(fontWeight: FontWeight.bold);

  // Headline
  // Large
  TextStyle? get headlineLargeNormal =>
      headlineLarge?.copyWith(fontWeight: FontWeight.normal);
  TextStyle? get headlineLargeBold =>
      headlineLarge?.copyWith(fontWeight: FontWeight.bold);

  // Medium
  TextStyle? get headlineMediumNormal =>
      headlineMedium?.copyWith(fontWeight: FontWeight.normal);
  TextStyle? get headlineMediumBold =>
      headlineMedium?.copyWith(fontWeight: FontWeight.bold);

  // Small
  TextStyle? get headlineSmallNormal =>
      headlineSmall?.copyWith(fontWeight: FontWeight.normal);
  TextStyle? get headlineSmallBold =>
      headlineSmall?.copyWith(fontWeight: FontWeight.bold);

  // Title
  // Large
  TextStyle? get titleLargeNormal =>
      titleLarge?.copyWith(fontWeight: FontWeight.normal);
  TextStyle? get titleLargeBold =>
      titleLarge?.copyWith(fontWeight: FontWeight.bold);

  // Medium
  TextStyle? get titleMediumNormal =>
      titleMedium?.copyWith(fontWeight: FontWeight.normal);
  TextStyle? get titleMediumBold =>
      titleMedium?.copyWith(fontWeight: FontWeight.bold);

  // Small
  TextStyle? get titleSmallNormal =>
      titleSmall?.copyWith(fontWeight: FontWeight.normal);
  TextStyle? get titleSmallBold =>
      titleSmall?.copyWith(fontWeight: FontWeight.bold);

  // Body
  // Large
  TextStyle? get bodyLargeNormal =>
      bodyLarge?.copyWith(fontWeight: FontWeight.normal);
  TextStyle? get bodyLargeBold =>
      bodyLarge?.copyWith(fontWeight: FontWeight.bold);

  // Medium
  TextStyle? get bodyMediumNormal =>
      bodyMedium?.copyWith(fontWeight: FontWeight.normal);
  TextStyle? get bodyMediumBold =>
      bodyMedium?.copyWith(fontWeight: FontWeight.bold);

  // Small
  TextStyle? get bodySmallNormal =>
      bodySmall?.copyWith(fontWeight: FontWeight.normal);
  TextStyle? get bodySmallBold =>
      bodySmall?.copyWith(fontWeight: FontWeight.bold);

  // Label
  // Large
  TextStyle? get labelLargeNormal =>
      labelLarge?.copyWith(fontWeight: FontWeight.normal);
  TextStyle? get labelLargeBold =>
      labelLarge?.copyWith(fontWeight: FontWeight.bold);

  // Medium
  TextStyle? get labelMediumNormal =>
      labelMedium?.copyWith(fontWeight: FontWeight.normal);
  TextStyle? get labelMediumBold =>
      labelMedium?.copyWith(fontWeight: FontWeight.bold);

  // Small
  TextStyle? get labelSmallNormal =>
      labelSmall?.copyWith(fontWeight: FontWeight.normal);
  TextStyle? get labelSmallBold =>
      labelSmall?.copyWith(fontWeight: FontWeight.bold);
}
