class SeatPlacement {
  final dynamic seat; // expects project BusSeats instances
  final int row;
  final int col;
  final int spanRows;
  final int spanCols;

  SeatPlacement({
    required this.seat,
    required this.row,
    required this.col,
    required this.spanRows,
    required this.spanCols,
  });
}

class SeatLayoutResult {
  final int rows;
  final int cols;
  final List<List<String?>> grid;
  final List<SeatPlacement> placements;
  final List<String> errors;

  SeatLayoutResult({
    required this.rows,
    required this.cols,
    required this.grid,
    required this.placements,
    required this.errors,
  });
}

class SeatLayoutEngine {
  /// Computes a grid and placements from a list of bus-seat objects.
  /// The engine expects each seat object to expose: row, column, length, width,
  /// name or berth (for id), and available. If [transpose] is true the
  /// resulting layout will be transposed (rows<->cols).
  static SeatLayoutResult computeLayout(List<dynamic> seats,
      {bool transpose = false}) {
    int maxRow = 0;
    int maxCol = 0;
    for (final s in seats) {
      final r = (s.row ?? 0) as int;
      final c = (s.column ?? 0) as int;
      // Note: in this project's BusSeats model `length` represents the
      // horizontal span (columns) and `width` represents the vertical span
      // (rows). So spanRows should use width and spanCols should use length.
      final len = (s.length ?? 1) as int; // horizontal span (cols)
      final wid = (s.width ?? 1) as int; // vertical span (rows)
      final spanRows = wid;
      final spanCols = len;
      maxRow = maxRow < r + spanRows ? r + spanRows : maxRow;
      maxCol = maxCol < c + spanCols ? c + spanCols : maxCol;
    }
    if (maxRow == 0) maxRow = 1;
    if (maxCol == 0) maxCol = 1;

    final grid =
        List.generate(maxRow, (_) => List<String?>.filled(maxCol, null));
    final placements = <SeatPlacement>[];
    final errors = <String>[];

    for (final seat in seats) {
      final row = (seat.row ?? 0) as int;
      final col = (seat.column ?? 0) as int;
      final len = (seat.length ?? 1) as int; // horizontal span (cols)
      final wid = (seat.width ?? 1) as int; // vertical span (rows)
      final spanRows = wid;
      final spanCols = len;
      final id = ((seat.name ?? seat.berth ?? '')).toString();

      // bounds check using corrected spans
      if (row < 0 ||
          col < 0 ||
          row + spanRows > maxRow ||
          col + spanCols > maxCol) {
        errors.add('Seat $id out of bounds');
        continue;
      }
      bool overlap = false;
      for (int r = row; r < row + spanRows; r++) {
        for (int c = col; c < col + spanCols; c++) {
          if (grid[r][c] != null) {
            overlap = true;
            break;
          }
        }
        if (overlap) break;
      }
      if (overlap) {
        errors.add('Overlap for $id');
        continue;
      }

      // place start
      grid[row][col] = id;
      // mark placeholders
      for (int r = row; r < row + spanRows; r++) {
        for (int c = col; c < col + spanCols; c++) {
          if (r == row && c == col) continue;
          grid[r][c] = '_ph_$id';
        }
      }

      placements.add(SeatPlacement(
        seat: seat,
        row: row,
        col: col,
        spanRows: spanRows,
        spanCols: spanCols,
      ));
    }

    final result = SeatLayoutResult(
        rows: maxRow,
        cols: maxCol,
        grid: grid,
        placements: placements,
        errors: errors);

    if (!transpose) return result;

    // Transpose grid and placements
    final transposedRows = maxCol;
    final transposedCols = maxRow;
    final transGrid = List.generate(
        transposedRows, (_) => List<String?>.filled(transposedCols, null));
    final transPlacements = <SeatPlacement>[];

    // transpose grid values
    for (int r = 0; r < maxRow; r++) {
      for (int c = 0; c < maxCol; c++) {
        final v = grid[r][c];
        if (c < transposedRows && r < transposedCols) transGrid[c][r] = v;
      }
    }

    for (final p in placements) {
      transPlacements.add(SeatPlacement(
        seat: p.seat,
        row: p.col,
        col: p.row,
        spanRows: p.spanCols,
        spanCols: p.spanRows,
      ));
    }

    return SeatLayoutResult(
        rows: transposedRows,
        cols: transposedCols,
        grid: transGrid,
        placements: transPlacements,
        errors: errors);
  }
}
