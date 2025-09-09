import 'package:flutter/material.dart';

class PageManager extends ChangeNotifier {
  final PageController _pageController;
  final TextEditingController _controller = TextEditingController();
  int _page = 0;
  bool _showButtons = false;
  PageManager(this._pageController) {
    _controller.addListener(_updateButtonsVisibility);

    _pageController.addListener(() {
      if (!_pageController.hasClients) return;
      final p = _pageController.page?.round() ?? _page;
      if (p != _page) {
        _page = p;
        notifyListeners();
      }
    });
  }

  TextEditingController get controller => _controller;
  bool get showButtons => _showButtons;
  int get page => _page;

  void setPage(int value) {
    if (value == _page) return;
    _page = value;

    if (_pageController.hasClients) {
      _pageController.animateToPage(
        value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // agenda para rodar depois que o PageView estiver montado
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
