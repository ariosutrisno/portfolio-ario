import 'package:flutter/material.dart';

/// Calm navy monochrome palette with neutral white and black typography.
///
/// The short class name is retained because it keeps feature composition
/// readable. New colors must be registered here first; feature widgets should
/// never declare raw hexadecimal values or use `Colors.*` directly.
abstract final class C {
  // The only brand hue used by the interface.
  static const garudaNavy = Color(0xFF002561); // Pantone 288 C

  // Accessible surfaces derived only from navy.
  static const background = garudaNavy;
  static const backgroundSoft = Color(0xFF062B5C);
  static const panel = Color(0xFF0A3264);
  static const panel2 = Color(0xFF001B48);
  static const text = Color(0xFFF4F6F8);
  static const muted = Color(0xFFCDD3DA);
  static const line = Color(0x33FFFFFF);
  static const lineStrong = Color(0x66FFFFFF);
  static const accent = text;
  static const accent2 = pureWhite;
  static const accent3 = Color(0xFFAEB5BD);

  // Flat dark surfaces used by diagrams and content cards.
  static const mobileMenu = panel2;
  static const contrastInk = Color(0xFF111111);
  static const darkText = Color(0xFF111111);
  static const artEnd = Color(0xFF001F50);
  static const aiSurface = Color(0xFF001D4B);
  static const architectureSurface = Color(0xFF082E60);
  static const projectSurface = Color(0xFF062B5C);
  static const artStart = Color(0xFF001F50);
  static const aboutSurface = Color(0xFF001D4B);
  static const tagSurface = Color(0xFF123B6A);
  static const nodeSurface = Color(0xFF163F6E);
  static const progressTrack = Color(0xFF214873);

  // Text, stroke, and status shades from all website sections.
  static const darkAccentText = Color(0xFF242424);
  static const darkLabel = Color(0xFF333333);
  static const darkGreen = Color(0xFF111111);
  static const resumeBody = Color(0xFF292929);
  static const resumeMuted = Color(0xFF4A4A4A);
  static const lightText = Color(0xFF292929);
  static const deepMuted = Color(0xFFAEB5BD);
  static const connector = pureWhite;
  static const timelineDot = pureWhite;
  static const flightLabel = Color(0xFFB8BEC5);
  static const coreLabel = Color(0xFFC1C6CC);
  static const journeyLabel = Color(0xFFC1C6CC);
  static const footerText = Color(0xFFB8BEC5);
  static const subtleText = Color(0xFFB8BEC5);
  static const aiScoreText = Color(0xFFC1C6CC);
  static const lightIndex = Color(0xFF555555);
  static const caseMetric = Color(0xFFC1C6CC);
  static const heroMuted = Color(0xFFC1C6CC);
  static const activityText = Color(0xFFCDD3DA);
  static const aiRowText = Color(0xFFCDD3DA);
  static const backLink = Color(0xFFD5D9DE);
  static const aboutText = Color(0xFFD5D9DE);
  static const caseBody = Color(0xFFD9DDE1);
  static const leadershipText = Color(0xFFD9DDE1);
  static const caseLead = Color(0xFFE0E3E6);
  static const leadText = Color(0xFFE2E5E8);
  static const coreMeta = Color(0xFFE2E5E8);
  static const tickerText = Color(0xFFE2E5E8);
  static const statusMuted = Color(0xFFE5E7E9);
  static const navText = Color(0xFFEAECED);
  static const lightLine = Color(0xFFD1D1D1);
  static const tagText = Color(0xFFEAECED);
  static const resumeTagLine = Color(0xFFC9C9C9);
  static const ghostText = Color(0xFFF0F1F2);
  static const footerStrong = Color(0xFFF0F1F2);
  static const resumeBorder = Color(0xFFD0D0D0);
  static const resumeRule = Color(0xFFE1E1E1);
  static const aboutLead = Color(0xFFF7F7F7);
  static const lightSurface = Color(0xFFF5F6F7);
  static const resumeSurface = Color(0xFFF2F3F4);
  static const pureWhite = Color(0xFFFFFFFF);
  static const resumeInk = Color(0xFF111111);
  static const resumeTitle = Color(0xFF111111);

  // Alpha colors preserve the original rgba values without local magic values.
  static const white018 = Color(0x05FFFFFF);
  static const white02 = Color(0x05FFFFFF);
  static const white025 = Color(0x06FFFFFF);
  static const white045 = Color(0x0BFFFFFF);
  static const white06 = Color(0x0FFFFFFF);
  static const white08 = Color(0x14FFFFFF);
  static const white09 = Color(0x17FFFFFF);
  static const white095 = Color(0x18FFFFFF);
  static const white16 = Color(0x29FFFFFF);
  static const white25 = Color(0x40FFFFFF);
  static const black08 = Color(0x14000000);
  static const black10 = Color(0x1A000000);
  static const black14 = Color(0x24000000);
  static const black30 = Color(0x4D000000);
  static const black34 = Color(0x57000000);
  static const black35 = Color(0x59000000);
  static const headerGlass = Color(0xF2002561);
  static const dialogGlass = Color(0xF5001B48);
  static const panelGlass = Color(0xEB0A3264);
  static const panel75 = Color(0xBF0A3264);
  static const panel97 = Color(0xF70A3264);
  static const accentGlow035 = Color(0x09FFFFFF);
  static const accentGlow07 = Color(0x12FFFFFF);
  static const accentGlow10 = Color(0x1AFFFFFF);
  static const accentGlow15 = Color(0x26FFFFFF);
  static const accentGlow23 = Color(0x3BFFFFFF);
  static const accentGlow55 = Color(0x8CFFFFFF);
  static const blueGlow09 = Color(0x17FFFFFF);
  static const blueGlow13 = Color(0x21FFFFFF);
  static const blueGlow18 = Color(0x2EFFFFFF);

  // Semantic aliases used throughout the current feature layer.
  static const ink = background;
  static const white = text;
  static const lime = accent;
  static const blue = accent2;
  static const orange = accent3;
  static const backgroundGlow = blueGlow13;
  static const blackShadow = black34;
  static const cardShadow = black14;
  static const hoverShadow = Color(0x33FFFFFF);
  static const leadershipStart = blueGlow09;
  static const leadershipEnd = accentGlow035;
}
