import 'package:flutter/material.dart';

/// SafeNetworkImage
/// - Shows a progress indicator while loading
/// - Shows a fallback placeholder on error
/// - Accepts optional httpHeaders (useful if you need Authorization)
class SafeNetworkImage extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Map<String, String>? httpHeaders;
  final Widget? placeholder;

  const SafeNetworkImage({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.httpHeaders,
    this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url == null || url!.trim().isEmpty) return _buildPlaceholder();

    return Image.network(
      url!,
      width: width,
      height: height,
      fit: fit,
      headers: httpHeaders,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        final expected = loadingProgress.expectedTotalBytes;
        final value = (expected != null && expected > 0)
            ? loadingProgress.cumulativeBytesLoaded / expected
            : null;
        return Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(value: value),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
    );
  }

  Widget _buildPlaceholder() {
    return placeholder ?? Container(
      width: width,
      height: height,
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: Icon(Icons.broken_image, color: Colors.grey.shade600),
    );
  }
}

