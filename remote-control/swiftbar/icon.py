#!/usr/bin/env python3
"""Generate the menu bar icons embedded in claude-rc.10s.sh.

Prints shell assignments of base64 template PNGs (black on transparent, @2x,
144 DPI so macOS sizes them in points):

  ICON_ON   Clawd with signal arcs: at least one server running
  ICON_OFF  Clawd alone: no server running

Usage: icon.py [--preview DIR]   (--preview also writes enlarged PNGs to DIR)
"""

import base64
import math
import struct
import sys
import zlib

SCALE = 2  # pixels per point
WIDTH_PT, HEIGHT_PT = 23, 18

# Clawd, one character per point. Rows are offset by CRAB_TOP.
CRAB = [
    "..############..",
    "..############..",
    "..############..",
    "..##.######.##..",
    "..##.######.##..",
    "################",
    "################",
    "..############..",
    "..############..",
    "..############..",
    "...#.#....#.#...",
    "...#.#....#.#...",
    "...#.#....#.#...",
]
CRAB_TOP = 2

# Signal arcs to the right of the crab, in points.
ARC_CENTER = (15.0, 8.0)
ARC_RADII = (3.6, 6.6)
ARC_STROKE = 1.5
ARC_HALF_ANGLE = math.radians(48)


def render(with_arcs):
    w, h = WIDTH_PT * SCALE, HEIGHT_PT * SCALE
    alpha = [[0.0] * w for _ in range(h)]

    for row, line in enumerate(CRAB):
        for col, cell in enumerate(line):
            if cell != "#":
                continue

            for dy in range(SCALE):
                for dx in range(SCALE):
                    alpha[(CRAB_TOP + row) * SCALE + dy][col * SCALE + dx] = 1.0

    if with_arcs:
        # 4x4 supersampling for smooth arcs.
        n = 4
        cx, cy = ARC_CENTER

        for y in range(h):
            for x in range(w):
                hits = 0

                for sy in range(n):
                    for sx in range(n):
                        px = (x + (sx + 0.5) / n) / SCALE - cx
                        py = (y + (sy + 0.5) / n) / SCALE - cy
                        r = math.hypot(px, py)

                        if px <= 0 or abs(math.atan2(py, px)) > ARC_HALF_ANGLE:
                            continue

                        if any(abs(r - radius) <= ARC_STROKE / 2 for radius in ARC_RADII):
                            hits += 1

                alpha[y][x] = max(alpha[y][x], hits / (n * n))

    return w, h, alpha


def png(w, h, alpha, scale=1, background=None):
    rows = []

    for y in range(h * scale):
        row = bytearray([0])

        for x in range(w * scale):
            a = alpha[y // scale][x // scale]

            if background is None:
                row += bytes([0, 0, 0, round(a * 255)])
            else:
                v = round(background * (1 - a))
                row += bytes([v, v, v, 255])

        rows.append(bytes(row))

    def chunk(kind, data):
        body = kind + data
        return struct.pack(">I", len(data)) + body + struct.pack(">I", zlib.crc32(body))

    ppm = round(72 * SCALE / 0.0254)  # pixels per metre at 144 DPI

    return (
        b"\x89PNG\r\n\x1a\n"
        + chunk(b"IHDR", struct.pack(">IIBBBBB", w * scale, h * scale, 8, 6, 0, 0, 0))
        + chunk(b"pHYs", struct.pack(">IIB", ppm, ppm, 1))
        + chunk(b"IDAT", zlib.compress(b"".join(rows), 9))
        + chunk(b"IEND", b"")
    )


def main():
    preview_dir = None

    if len(sys.argv) == 3 and sys.argv[1] == "--preview":
        preview_dir = sys.argv[2]

    for name, with_arcs in (("ICON_ON", True), ("ICON_OFF", False)):
        w, h, alpha = render(with_arcs)
        print(f"{name}='{base64.b64encode(png(w, h, alpha)).decode()}'")

        if preview_dir:
            with open(f"{preview_dir}/{name.lower()}.png", "wb") as f:
                f.write(png(w, h, alpha, scale=8, background=255))


if __name__ == "__main__":
    main()
