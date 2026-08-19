import 'package:flutter/material.dart';

/// Modern Dark Luxury palette with eye-friendly anti-glare typography,
/// luminous cyan & indigo accents, and rich obsidian/slate surfaces.
///
/// The short class name is retained because it keeps feature composition
/// readable. New colors must be registered here first; feature widgets should
/// never declare raw hexadecimal values or use `Colors.*` directly.
abstract final class C {
  // Brand identity reference.
  static const garudaNavy = Color(0xFF002561);

  // Modern Dark Luxury base surfaces (Deep Obsidian & Slate).
  static const background = Color(0xFF0B0F19);
  static const backgroundSoft = Color(0xFF111827);
  static const panel = Color(0xFF161F30);
  static const panel2 = Color(0xFF0F172A);

  // Ergonomic anti-glare typography (Soft Slate whites & grays).
  static const text = Color(0xFFF8FAFC);
  static const muted = Color(0xFF94A3B8);
  static const deepMuted = Color(0xFF64748B);
  static const line = Color(0x1FFFFFFF);
  static const lineStrong = Color(0x38FFFFFF);

  // Luminous modern accents.
  static const accent = Color(0xFF38BDF8); // Electric Cyan
  static const accent2 = Color(0xFF818CF8); // Soft Indigo / Violet
  static const accent3 = Color(0xFF34D399); // Luminous Mint / Emerald

  // Rich layered surfaces used by diagrams, cards, and sections.
  static const mobileMenu = panel2;
  static const contrastInk = Color(0xFF0B0F19);
  static const darkText = Color(0xFF0B0F19);
  static const artStart = Color(0xFF1E293B);
  static const artEnd = Color(0xFF0F172A);
  static const aiSurface = Color(0xFF131D31);
  static const architectureSurface = Color(0xFF16233B);
  static const projectSurface = Color(0xFF131D31);
  static const aboutSurface = Color(0xFF111A2E);
  static const tagSurface = Color(0xFF1E293B);
  static const nodeSurface = Color(0xFF1E2B45);
  static const progressTrack = Color(0xFF1E293B);

  // Semantic text, stroke, and status shades.
  static const darkAccentText = Color(0xFF1E293B);
  static const darkLabel = Color(0xFF334155);
  static const darkGreen = Color(0xFF0F766E);
  static const resumeBody = Color(0xFF334155);
  static const resumeMuted = Color(0xFF64748B);
  static const lightText = Color(0xFF334155);
  static const connector = Color(0xFF38BDF8);
  static const timelineDot = Color(0xFF38BDF8);
  static const flightLabel = Color(0xFF94A3B8);
  static const coreLabel = Color(0xFF94A3B8);
  static const journeyLabel = Color(0xFF94A3B8);
  static const footerText = Color(0xFF94A3B8);
  static const subtleText = Color(0xFF94A3B8);
  static const aiScoreText = Color(0xFF94A3B8);
  static const lightIndex = Color(0xFF64748B);
  static const caseMetric = Color(0xFF94A3B8);
  static const heroMuted = Color(0xFF94A3B8);
  static const activityText = Color(0xFFCBD5E1);
  static const aiRowText = Color(0xFFCBD5E1);
  static const backLink = Color(0xFFCBD5E1);
  static const aboutText = Color(0xFFCBD5E1);
  static const caseBody = Color(0xFFCBD5E1);
  static const leadershipText = Color(0xFFCBD5E1);
  static const caseLead = Color(0xFFE2E8F0);
  static const leadText = Color(0xFFE2E8F0);
  static const coreMeta = Color(0xFFE2E8F0);
  static const tickerText = Color(0xFFE2E8F0);
  static const statusMuted = Color(0xFFE2E8F0);
  static const navText = Color(0xFFF1F5F9);
  static const lightLine = Color(0xFFE2E8F0);
  static const tagText = Color(0xFFF1F5F9);
  static const resumeTagLine = Color(0xFFCBD5E1);
  static const ghostText = Color(0xFFF8FAFC);
  static const footerStrong = Color(0xFFF8FAFC);
  static const resumeBorder = Color(0xFFE2E8F0);
  static const resumeRule = Color(0xFFE2E8F0);
  static const aboutLead = Color(0xFFF8FAFC);
  static const lightSurface = Color(0xFFF8FAFC);
  static const resumeSurface = Color(0xFFF8FAFC);
  static const pureWhite = Color(0xFFFFFFFF);
  static const resumeInk = Color(0xFF0F172A);
  static const resumeTitle = Color(0xFF0F172A);

  // Alpha and translucent glass layers.
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
  static const headerGlass = Color(0xEE0B0F19);
  static const dialogGlass = Color(0xF20F172A);
  static const panelGlass = Color(0xCC161F30);
  static const panel75 = Color(0xBF161F30);
  static const panel97 = Color(0xF7161F30);
  static const accentGlow035 = Color(0x0938BDF8);
  static const accentGlow07 = Color(0x1238BDF8);
  static const accentGlow10 = Color(0x1A38BDF8);
  static const accentGlow15 = Color(0x2638BDF8);
  static const accentGlow23 = Color(0x3B38BDF8);
  static const accentGlow55 = Color(0x8C38BDF8);
  static const blueGlow09 = Color(0x17818CF8);
  static const blueGlow13 = Color(0x21818CF8);
  static const blueGlow18 = Color(0x2E818CF8);

  // Semantic aliases used throughout feature widgets.
  static const ink = background;
  static const white = text;
  static const lime = accent;
  static const blue = accent2;
  static const orange = Color(0xFFF59E0B);
  static const backgroundGlow = blueGlow13;
  static const blackShadow = black34;
  static const cardShadow = Color(0x40000000);
  static const hoverShadow = Color(0x3338BDF8);
  static const leadershipStart = blueGlow09;
  static const leadershipEnd = accentGlow035;
}

