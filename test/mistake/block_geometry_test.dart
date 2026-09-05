import 'dart:ui' show Rect, Size;

import 'package:flutter_test/flutter_test.dart';
import 'package:smart_wrong_notebook/src/mistake/services/block_geometry.dart';

void main() {
  const area = Size(1000, 1400);
  const epsilon = 1e-9;

  group('normalizeBlockRect', () {
    test('左上区域', () {
      final r = normalizeBlockRect(const Rect.fromLTRB(0, 0, 300, 200), area);
      expect(r.left, closeTo(0.0, epsilon));
      expect(r.top, closeTo(0.0, epsilon));
      expect(r.width, closeTo(0.3, epsilon));
      expect(r.height, closeTo(200 / 1400, epsilon));
      expect(isWellFormedBlockRect(r), isTrue);
    });

    test('图片中央区域', () {
      final r =
          normalizeBlockRect(const Rect.fromLTRB(400, 500, 700, 900), area);
      expect(r.left, closeTo(0.4, epsilon));
      expect(r.top, closeTo(500 / 1400, epsilon));
      expect(r.width, closeTo(0.3, epsilon));
      expect(r.height, closeTo(400 / 1400, epsilon));
      expect(r.left + r.width, closeTo(0.7, epsilon));
      expect(isWellFormedBlockRect(r), isTrue);
    });

    test('右下区域（贴边，保证 x+width<=1）', () {
      final r =
          normalizeBlockRect(const Rect.fromLTRB(700, 1200, 1000, 1400), area);
      expect(r.left, closeTo(0.7, epsilon));
      expect(r.width, closeTo(0.3, epsilon));
      expect(r.left + r.width, closeTo(1.0, epsilon));
      expect(r.top + r.height, closeTo(1.0, epsilon));
      expect(isWellFormedBlockRect(r), isTrue);
      expect(r.left, lessThan(1.0));
      expect(r.top, lessThan(1.0));
    });

    test('反向拖动（右下拖到左上）', () {
      final r =
          normalizeBlockRect(const Rect.fromLTRB(900, 1300, 200, 300), area);
      expect(r.width, closeTo(0.7, epsilon));
      expect(r.height, closeTo(1000 / 1400, epsilon));
      expect(r.left, closeTo(0.2, epsilon));
      expect(r.top, closeTo(300 / 1400, epsilon));
      expect(isWellFormedBlockRect(r), isTrue);
    });

    test('超出边界拖动被 clamp 到图片范围内', () {
      final r =
          normalizeBlockRect(const Rect.fromLTRB(-100, -80, 1200, 1500), area);
      expect(r.left, closeTo(0.0, epsilon));
      expect(r.top, closeTo(0.0, epsilon));
      expect(r.width, closeTo(1.0, epsilon));
      expect(r.height, closeTo(1.0, epsilon));
      expect(isWellFormedBlockRect(r), isTrue);
    });
  });

  group('validity', () {
    test('合法矩形可通过结构校验', () {
      const r = Rect.fromLTWH(0.1, 0.2, 0.3, 0.4);
      expect(isWellFormedBlockRect(r), isTrue);
      expect(isValidBlockRect(r), isTrue);
    });

    test('零面积/退化矩形被拒绝', () {
      expect(
          isWellFormedBlockRect(const Rect.fromLTWH(0.1, 0.2, 0, 0.4)), isFalse);
      expect(
          isWellFormedBlockRect(const Rect.fromLTWH(0.1, 0.2, 0.3, 0)), isFalse);
      expect(
          isWellFormedBlockRect(const Rect.fromLTWH(0.1, 0.2, -1, 0.4)), isFalse);
    });

    test('越界矩形被拒绝', () {
      expect(
          isWellFormedBlockRect(const Rect.fromLTWH(0.9, 0.2, 0.2, 0.4)), isFalse);
      expect(
          isWellFormedBlockRect(const Rect.fromLTWH(0.1, 0.9, 0.3, 0.2)), isFalse);
      expect(isWellFormedBlockRect(const Rect.fromLTWH(-0.1, 0.2, 0.3, 0.4)),
          isFalse);
    });

    test('过小选区被 isValidBlockRect 拒绝', () {
      const tiny = Rect.fromLTWH(0.1, 0.1, 0.001, 0.3);
      expect(isWellFormedBlockRect(tiny), isTrue);
      expect(isValidBlockRect(tiny), isFalse);
    });
  });

  group('fromRotatedToOriginal', () {
    test('k=0 或 4 为恒等', () {
      const r = Rect.fromLTWH(0.2, 0.3, 0.4, 0.5);
      final a = fromRotatedToOriginal(r, 0);
      final b = fromRotatedToOriginal(r, 4);
      expect(a.left, closeTo(0.2, epsilon));
      expect(a.top, closeTo(0.3, epsilon));
      expect(a.width, closeTo(0.4, epsilon));
      expect(a.height, closeTo(0.5, epsilon));
      expect(b.width, closeTo(0.4, epsilon));
    });

    test('旋转后左侧竖条 ⇔ 原图下半横条', () {
      // 顺时针旋转 1 次后占据左侧竖条 => 原图底部横条
      final orig = fromRotatedToOriginal(
          const Rect.fromLTWH(0, 0, 0.5, 1.0), 1);
      expect(orig.left, closeTo(0.0, epsilon));
      expect(orig.top, closeTo(0.5, epsilon));
      expect(orig.width, closeTo(1.0, epsilon));
      expect(orig.height, closeTo(0.5, epsilon));
    });

    test('旋转 4 次往返回到原矩形', () {
      const r = Rect.fromLTWH(0.1, 0.2, 0.3, 0.4);
      final r1 = fromRotatedToOriginal(r, 1);
      final r3 = fromRotatedToOriginal(r1, 3);
      expect(r3.left, closeTo(0.1, epsilon));
      expect(r3.top, closeTo(0.2, epsilon));
      expect(r3.width, closeTo(0.3, epsilon));
      expect(r3.height, closeTo(0.4, epsilon));
    });
  });
}

