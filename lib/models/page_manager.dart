import 'package:flutter/material.dart';

class PageManager extends ChangeNotifier {
  final PageController _pageController;
  final TextEditingController _controller = TextEditingController();

  int _page = 0;
  bool _showButtons = false;

  PageManager(this._pageController) {
    // Escuta mudanças no texto do campo
    _controller.addListener(_updateButtonsVisibility);

    // Escuta mudanças na página atual
    _pageController.addListener(() {
      if (_pageController.hasClients) {
        final p = _pageController.page?.round() ?? _page;
        if (p != _page) {
          _page = p;
          notifyListeners();
        }
      }
    });
  }

  TextEditingController get controller => _controller;
  bool get showButtons => _showButtons;
  int get page => _page;

  void setPage(int value) {
    if (value == _page) return;
    _page = value;

    // Garante que o PageView mude de página
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_pageController.hasClients) {
          _pageController.jumpToPage(value);
        }
      });
    }

    notifyListeners();
  }

  void _updateButtonsVisibility() {
    final shouldShow = _controller.text.trim().isNotEmpty;
    if (shouldShow != _showButtons) {
      _showButtons = shouldShow;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
