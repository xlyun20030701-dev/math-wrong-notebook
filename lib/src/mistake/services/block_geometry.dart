import 'dart:math' as math;
import 'dart:ui' show Rect, Size;

/// 保存区块的最小归一化边长。
///
/// 选一块 2% 高度/宽度的区域通常已经比手滑选出的“点”要可靠，
/// 也是打印时能看清的最小合理区域。
const double kMinBlockNormalizedSide = 0.02;

/// 图片裁剪允许的最小像素边长（防止把无效选区悄悄生成 1px 图片）。
const int kMinBlockCropPixels = 24;

/// 把“屏幕/图片显示区”上的像素矩形转换为 0~1 归一化矩形。
///
/// [pixelRect] 可以是任意方向（右下拖到左上）或越界的矩形，
/// 内部先取 min/max 再 clamp 到 [displaySize] 内，最后按显示区宽高归一化。
///
/// 保证返回矩形满足：
///   0 <= x < 1, 0 <= y < 1, width >= 0, height >= 0,
///   x + width <= 1, y + height <= 1
Rect normalizeBlockRect(Rect pixelRect, Size displaySize) {
  final areaW = displaySize.width <= 0 ? 1.0 : displaySize.width;
  final areaH = displaySize.height <= 0 ? 1.0 : displaySize.height;

  final left = _clampTo(math.min(pixelRect.left, pixelRect.right), areaW);
  final right = _clampTo(math.max(pixelRect.left, pixelRect.right), areaW);
  final top = _clampTo(math.min(pixelRect.top, pixelRect.bottom), areaH);
  final bottom = _clampTo(math.max(pixelRect.top, pixelRect.bottom), areaH);

  final x = left / areaW;
  final y = top / areaH;
  final width = math.max(0.0, (right - left) / areaW);
  final height = math.max(0.0, (bottom - top) / areaH);
  return Rect.fromLTWH(x, y, width, height);
}

double _clampTo(double v, double maxV) => v.clamp(0.0, maxV).toDouble();

/// 结构性校验：坐标在合法范围且宽度/高度为正。
bool isWellFormedBlockRect(Rect normalized, {double epsilon = 1e-6}) {
  if (normalized.width.isNaN ||
      normalized.height.isNaN ||
      normalized.left.isNaN ||
      normalized.top.isNaN) {
    return false;
  }
  if (normalized.left < -epsilon ||
      normalized.top < -epsilon ||
      normalized.width <= epsilon ||
      normalized.height <= epsilon) {
    return false;
  }
  if (normalized.left >= 1.0 || normalized.top >= 1.0) return false;
  if (normalized.left + normalized.width > 1.0 + epsilon) return false;
  if (normalized.top + normalized.height > 1.0 + epsilon) return false;
  return true;
}

/// 是否是一个“值得保存”的区块：结构合法且不小于最小归一化边长。
bool isValidBlockRect(
  Rect normalized, {
  double minSide = kMinBlockNormalizedSide,
}) {
  if (!isWellFormedBlockRect(normalized)) return false;
  if (normalized.width < minSide) return false;
  if (normalized.height < minSide) return false;
  return true;
}
