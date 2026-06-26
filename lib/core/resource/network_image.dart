import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constansts/image_manager.dart';

class SvgCache {
  static final HttpClient _client = HttpClient()..connectionTimeout = const Duration(seconds: 5);
  static final Map<String, String> _cache = {};
  static final Map<String, bool> _failedUrls = {};

  static String? getCachedString(String url) {
    return _cache[url];
  }

  static Future<String?> getSvgString(String url) async {
    if (_failedUrls[url] == true) return null;
    if (_cache.containsKey(url)) return _cache[url];

    try {
      final request = await _client.getUrl(Uri.parse(url)).timeout(const Duration(seconds: 5));
      final response = await request.close();
      if (response.statusCode != 200) {
        _failedUrls[url] = true;
        return null;
      }
      final bytes = await response.fold<List<int>>([], (p, e) => p..addAll(e));
      final bodyString = utf8.decode(bytes).trim();
      if (bodyString.startsWith('<html') ||
          bodyString.startsWith('<!DOCTYPE') ||
          !bodyString.contains('<svg')) {
        _failedUrls[url] = true;
        return null;
      }
      _cache[url] = bodyString;
      return bodyString;
    } catch (e) {
      _failedUrls[url] = true;
      return null;
    }
  }
}

class SafeSvgWidget extends StatefulWidget {
  final String url;
  final double height;
  final double width;
  final BoxFit fit;
  final Color? color;
  final Widget errorWidget;

  const SafeSvgWidget({
    super.key,
    required this.url,
    required this.height,
    required this.width,
    required this.fit,
    this.color,
    required this.errorWidget,
  });

  @override
  State<SafeSvgWidget> createState() => _SafeSvgWidgetState();
}

class _SafeSvgWidgetState extends State<SafeSvgWidget> {
  String? _svgString;
  bool _isLoading = true;
  String? _loadedUrl;

  @override
  void initState() {
    super.initState();
    _loadSvg();
  }

  @override
  void didUpdateWidget(SafeSvgWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      _loadSvg();
    }
  }

  Future<void> _loadSvg() async {
    final targetUrl = widget.url;
    _loadedUrl = targetUrl;

    // Check cache synchronously
    final cached = SvgCache.getCachedString(targetUrl);
    if (cached != null) {
      if (mounted) {
        setState(() {
          _svgString = cached;
          _isLoading = false;
        });
      }
      return;
    }

    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    final result = await SvgCache.getSvgString(targetUrl);
    if (mounted && _loadedUrl == targetUrl) {
      setState(() {
        _svgString = result;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return SizedBox(
        height: widget.height,
        width: widget.width,
        child: const Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    if (_svgString != null) {
      try {
        return SvgPicture.string(
          _svgString!,
          height: widget.height,
          width: widget.width,
          fit: widget.fit,
          colorFilter: widget.color != null
              ? ColorFilter.mode(widget.color!, BlendMode.srcIn)
              : null,
        );
      } catch (_) {
        return widget.errorWidget;
      }
    }

    return widget.errorWidget;
  }
}

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final BoxFit fit;
  final double? borderRadius;
  final String errorAsset;
  final Color? color;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.width,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.errorAsset = ImageManager.logoImg,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    Widget buildErrorWidget() {
      return Image.asset(
        errorAsset,
        height: height,
        width: width,
        fit: fit,
        color: color,
      );
    }

    if (imageUrl.isEmpty) {
      Widget placeholder = buildErrorWidget();
      if (borderRadius != null) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius!),
          child: placeholder,
        );
      }
      return placeholder;
    }

    if (imageUrl.toLowerCase().contains('.svg')) {
      Widget svgWidget = SafeSvgWidget(
        url: imageUrl,
        height: height,
        width: width,
        fit: fit,
        color: color,
        errorWidget: buildErrorWidget(),
      );

      if (borderRadius != null) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius!),
          child: svgWidget,
        );
      }

      return svgWidget;
    }

    Widget imageWidget = Image.network(
      imageUrl,
      height: height,
      width: width,
      fit: fit,
      color: color,
      errorBuilder: (context, error, stackTrace) => buildErrorWidget(),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return SizedBox(
          height: height,
          width: width,
          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        );
      },
    );

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius!),
        child: imageWidget,
      );
    }

    return imageWidget;
  }
}
