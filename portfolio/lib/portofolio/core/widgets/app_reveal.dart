import 'package:flutter/material.dart';

import '../accessibility/accessibility_context.dart';
import '../theme/app_tokens.dart';

/// Reveals content once it enters the viewport, mirroring `script.js`.
///
/// The animation is driven by the nearest scrollable and runs only once. It is
/// disabled automatically when the platform requests reduced motion.
class AppReveal extends StatefulWidget {
  const AppReveal({super.key, required this.child, this.triggerFraction = .88});

  final Widget child;
  final double triggerFraction;

  @override
  State<AppReveal> createState() => _AppRevealState();
}

class _AppRevealState extends State<AppReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _offset;
  ScrollPosition? _position;
  bool _revealed = false;
  bool _checkScheduled = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: AppMotion.reveal);
    final curved = CurvedAnimation(
      parent: _controller,
      curve: AppMotion.revealCurve,
    );
    _opacity = curved;
    _offset = Tween<Offset>(
      begin: const Offset(0, AppMotion.revealOffsetFraction),
      end: Offset.zero,
    ).animate(curved);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final nextPosition = Scrollable.maybeOf(context)?.position;
    if (_position != nextPosition) {
      _position?.removeListener(_scheduleVisibilityCheck);
      _position = nextPosition;
      _position?.addListener(_scheduleVisibilityCheck);
    }
    _scheduleVisibilityCheck();
  }

  @override
  void didUpdateWidget(covariant AppReveal oldWidget) {
    super.didUpdateWidget(oldWidget);
    _scheduleVisibilityCheck();
  }

  void _scheduleVisibilityCheck() {
    if (_revealed || _checkScheduled || !mounted) return;
    _checkScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkScheduled = false;
      _revealIfVisible();
    });
  }

  void _revealIfVisible() {
    if (_revealed || !mounted) return;
    final renderObject = context.findRenderObject();
    if (renderObject is! RenderBox ||
        !renderObject.attached ||
        !renderObject.hasSize) {
      return;
    }

    final top = renderObject.localToGlobal(Offset.zero).dy;
    final bottom = top + renderObject.size.height;
    final viewportHeight = MediaQuery.sizeOf(context).height;
    final trigger = viewportHeight * widget.triggerFraction.clamp(0.0, 1.0);
    if (top > trigger || bottom < 0) return;

    _revealed = true;
    if (context.prefersReducedMotion) {
      _controller.value = 1;
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _position?.removeListener(_scheduleVisibilityCheck);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
    opacity: _opacity,
    child: SlideTransition(position: _offset, child: widget.child),
  );
}
