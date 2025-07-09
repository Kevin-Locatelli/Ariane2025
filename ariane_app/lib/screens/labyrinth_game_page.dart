import 'package:flutter/material.dart';
import 'package:ariane_app/constants.dart';
import 'dart:collection'; // For Queue
import 'dart:math' as math; // For math.min

enum CellType { empty, wall, start, end, visited, path }

class LabyrinthePage extends StatefulWidget {
  @override
  _LabyrinthePageState createState() => _LabyrinthePageState();
}

class _LabyrinthePageState extends State<LabyrinthePage> {
  bool _isStartPointSelected = false;
  bool _isEndPointSelected = false;
  bool _gameStarted = false;
  bool _isSolving = false; // New: Flag to indicate if algorithm is running
  bool _isDragging = false; // New: Flag to track if dragging is active
  Offset? _lastDraggedCell; // New: To track the last cell dragged over

  String _selectedMode = 'Mur'; // Default mode is now 'Mur'

  final int _gridHeight = 25; // 25 rows
  final int _gridWidth = 12; // 12 columns
  late List<List<CellType>> _grid;
  Offset? _startPoint;
  Offset? _endPoint;

  // New: For pathfinding visualization
  final Set<Offset> _visitedCells = {};
  List<Offset> _pathCells = [];

  @override
  void initState() {
    super.initState();
    _initializeGrid();
  }

  void _initializeGrid() {
    _grid = List.generate(
      _gridHeight,
      (row) => List.generate(_gridWidth, (col) => CellType.empty),
    );
    _startPoint = null;
    _endPoint = null;
    _isStartPointSelected = false;
    _isEndPointSelected = false;
    _gameStarted = false;
    _isSolving = false;
    _visitedCells.clear();
    _pathCells.clear();
  }

  // Helper to get cell coordinates from local position
  Offset? _getCellCoordinates(Offset localPosition, double gridDisplayWidth, double gridDisplayHeight) {
    final double cellWidth = gridDisplayWidth / _gridWidth;
    final double cellHeight = gridDisplayHeight / _gridHeight;

    final int col = (localPosition.dx / cellWidth).floor();
    final int row = (localPosition.dy / cellHeight).floor();

    if (row >= 0 && row < _gridHeight && col >= 0 && col < _gridWidth) {
      return Offset(col.toDouble(), row.toDouble());
    }
    return null;
  }

  void _handlePanStart(int row, int col) {
    if (_isSolving) return;

    if (_selectedMode == 'Mur') {
      setState(() {
        _isDragging = true;
        _lastDraggedCell = Offset(col.toDouble(), row.toDouble());
        // Initial wall placement is now handled by _handleCellTap on onTapUp
      });
    } else {
      // For start/end points, handle as a single tap
      _handleCellTap(row, col);
    }
  }

  void _handlePanUpdate(int row, int col) {
    if (!_isDragging || _isSolving || _selectedMode != 'Mur') return;

    final currentCell = Offset(col.toDouble(), row.toDouble());
    if (currentCell == _lastDraggedCell) return;

    setState(() {
      _lastDraggedCell = currentCell;
      if (_grid[row][col] == CellType.empty) {
        _grid[row][col] = CellType.wall;
      }
    });
  }

  void _handlePanEnd() {
    setState(() {
      _isDragging = false;
      _lastDraggedCell = null;
    });
  }

  void _handleCellTap(int row, int col) {
    if (_isSolving) return; // Prevent interaction while solving

    setState(() {
      final tappedCell = Offset(col.toDouble(), row.toDouble());

      // If tapping on an existing start/end point, clear it first
      if (_startPoint == tappedCell) {
        _grid[row][col] = CellType.empty;
        _startPoint = null;
        _isStartPointSelected = false;
        return;
      }
      if (_endPoint == tappedCell) {
        _grid[row][col] = CellType.empty;
        _endPoint = null;
        _isEndPointSelected = false;
        return;
      }

      if (_selectedMode == 'Point de départ') {
        if (_startPoint != null) {
          _grid[_startPoint!.dy.toInt()][_startPoint!.dx.toInt()] = CellType.empty;
        }
        _grid[row][col] = CellType.start;
        _startPoint = tappedCell;
        _isStartPointSelected = true;
      } else if (_selectedMode == "Point d'arriver") {
        if (_endPoint != null) {
          _grid[_endPoint!.dy.toInt()][_endPoint!.dx.toInt()] = CellType.empty;
        }
        _grid[row][col] = CellType.end;
        _endPoint = tappedCell;
        _isEndPointSelected = true;
      } else if (_selectedMode == 'Mur') { // New: Handle wall toggling
        if (_grid[row][col] == CellType.empty) {
          _grid[row][col] = CellType.wall;
        } else if (_grid[row][col] == CellType.wall) {
          _grid[row][col] = CellType.empty;
        }
      }
    });
  }

  Future<void> _solveLabyrinth() async {
    if (_startPoint == null || _endPoint == null) {
      // Show a message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez sélectionner un point de départ et un point d\'arrivée.')),
      );
      return;
    }

    setState(() {
      _isSolving = true;
      _gameStarted = true;
      _visitedCells.clear();
      _pathCells.clear();
      // Reset visited/path cells on the grid for a new solve
      for (int r = 0; r < _gridHeight; r++) {
        for (int c = 0; c < _gridWidth; c++) {
          if (_grid[r][c] == CellType.visited || _grid[r][c] == CellType.path) {
            _grid[r][c] = CellType.empty;
          }
        }
      }
    });

    final Queue<Offset> queue = Queue<Offset>();
    final Map<Offset, Offset?> parents = {}; // To reconstruct path

    queue.add(_startPoint!);
    _visitedCells.add(_startPoint!);

    bool pathFound = false;

    while (queue.isNotEmpty && !pathFound) {
      final current = queue.removeFirst();

      // Visualize visited cells
      if (current != _startPoint && current != _endPoint) {
        setState(() {
          _grid[current.dy.toInt()][current.dx.toInt()] = CellType.visited;
        });
        await Future.delayed(const Duration(milliseconds: 50)); // Small delay for visualization
      }

      if (current == _endPoint) {
        pathFound = true;
        break;
      }

      // Define neighbors (up, down, left, right)
      final List<Offset> neighbors = [
        Offset(current.dx, current.dy - 1), // Up
        Offset(current.dx, current.dy + 1), // Down
        Offset(current.dx - 1, current.dy), // Left
        Offset(current.dx + 1, current.dy), // Right
      ];

      for (final neighbor in neighbors) {
        final int nRow = neighbor.dy.toInt();
        final int nCol = neighbor.dx.toInt();

        // Check bounds
        if (nRow >= 0 && nRow < _gridHeight && nCol >= 0 && nCol < _gridWidth) {
          // Check if it's a wall or already visited
          if (_grid[nRow][nCol] != CellType.wall && !_visitedCells.contains(neighbor)) {
            _visitedCells.add(neighbor);
            parents[neighbor] = current;
            queue.add(neighbor);
          }
        }
      }
    }

    if (pathFound) {
      // Reconstruct path
      Offset? current = _endPoint;
      while (current != null && current != _startPoint) {
        _pathCells.add(current);
        current = parents[current];
      }
      _pathCells = _pathCells.reversed.toList(); // Path from start to end

      // Visualize path
      for (final cell in _pathCells) {
        if (cell != _startPoint && cell != _endPoint) {
          setState(() {
            _grid[cell.dy.toInt()][cell.dx.toInt()] = CellType.path;
          });
          await Future.delayed(const Duration(milliseconds: 50));
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Chemin trouvé !')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aucun chemin trouvé.')),
      );
    }

    setState(() {
      _isSolving = false;
      _gameStarted = false; // Reset game started state after solving
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: kIconSize),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          'Labyrinthe',
          style: TextStyle(
            color: Colors.black,
            fontSize: kFontSizeMedium,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(kPaddingLarge),
        child: Column(
          children: [
            _buildGameArea(),
            Flexible(
              child: _buildControlButtons(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameArea() {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double cellWidth = constraints.maxWidth / _gridWidth;
          final double cellHeight = constraints.maxHeight / _gridHeight;
          final double cellSize = math.min(cellWidth, cellHeight);

          final double gridDisplayWidth = cellSize * _gridWidth;
          final double gridDisplayHeight = cellSize * _gridHeight;

          return Align(
            alignment: Alignment.topLeft,
            child: SizedBox( // Use SizedBox to constrain the GridView
              width: gridDisplayWidth,
              height: gridDisplayHeight,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _gridWidth,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  childAspectRatio: 1.0, // Cells are square
                ),
                itemCount: _gridHeight * _gridWidth,
                itemBuilder: (context, index) {
                  final row = index ~/ _gridWidth;
                  final col = index % _gridWidth;
                  final cellType = _grid[row][col];

                  Color cellColor = Colors.white; // Initialize with a default color
                  IconData? cellIcon;

                  switch (cellType) {
                    case CellType.empty:
                      cellColor = Colors.white;
                      break;
                    case CellType.wall:
                      cellColor = Colors.black;
                      break;
                    case CellType.start:
                      cellColor = Colors.green;
                      cellIcon = Icons.flag;
                      break;
                    case CellType.end:
                      cellColor = kPrimaryColor;
                      cellIcon = Icons.check_circle;
                      break;
                    case CellType.visited:
                      cellColor = Colors.blue.withOpacity(0.1); // Light blue for visited
                      break;
                    case CellType.path:
                      cellColor = const Color.fromARGB(255, 8, 173, 49); // Darker blue for path
                      break;
                  }

                  return GestureDetector(
                      onTapUp: (details) => _handleCellTap(row, col),
                      onPanStart: (details) => _handlePanStart(row, col),
                      onPanUpdate: (details) => _handlePanUpdate(row, col),
                      onPanEnd: (details) => _handlePanEnd(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: cellColor,
                          border: Border.all(color: Colors.grey[300]!, width: 0.5),
                        ),
                        child: cellIcon != null
                            ? Icon(cellIcon, color: Colors.white, size: kIconSize - 4)
                            : null,
                      ),
                    );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildControlButtons() {
    return Container(
      padding: EdgeInsets.all(kPaddingExtraLarge),
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.circular(kBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: kSpreadRadius,
            blurRadius: kBlurRadius,
            offset: Offset(kOffsetX, kOffsetY),
          ),
        ],
      ),
      child: Wrap(
        spacing: 10.0, // horizontal space between buttons
        runSpacing: 10.0, // vertical space between lines of buttons
        alignment: WrapAlignment.center,
        children: [
          _buildControlButton(
            text: 'Mur',
            isSelected: _selectedMode == 'Mur',
            color: Colors.blueGrey,
            onPressed: _isSolving ? null : () {
              setState(() {
                _selectedMode = 'Mur';
              });
            },
          ),
          _buildControlButton(
            text: 'Point de départ',
            isSelected: _selectedMode == 'Point de départ',
            isPointSet: _startPoint != null,
            color: Colors.green,
            onPressed: _isSolving ? null : () {
              setState(() {
                _selectedMode = 'Point de départ';
              });
            },
          ),
          _buildControlButton(
            text: "Point d'arriver",
            isSelected: _selectedMode == "Point d'arriver",
            isPointSet: _endPoint != null,
            color: kPrimaryColor,
            onPressed: _isSolving ? null : () {
              setState(() {
                _selectedMode = "Point d'arriver";
              });
            },
          ),
          _buildControlButton(
            text: 'Start',
            isSelected: false,
            color: Colors.blue,
            onPressed: (_isStartPointSelected && _isEndPointSelected && !_isSolving)
                ? _solveLabyrinth
                : null,
          ),
          _buildControlButton(
            text: 'Reset',
            isSelected: false,
            color: Colors.grey,
            onPressed: _isSolving ? null : () {
              setState(() {
                _initializeGrid();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required String text,
    required bool isSelected,
    required Color color,
    required VoidCallback? onPressed,
    bool isPointSet = false,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: kPaddingLarge, vertical: kPaddingMedium),
        decoration: BoxDecoration(
          color: isSelected || isPointSet ? color : kCardColor,
          borderRadius: BorderRadius.circular(kPaddingExtraLarge),
          border: Border.all(
            color: color,
            width: 2,
          ),
          boxShadow: isSelected || isPointSet
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    spreadRadius: kSpreadRadius,
                    blurRadius: kSizedBoxHeightSmall,
                    offset: Offset(kOffsetX, kOffsetY),
                  ),
                ]
              : [],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected || isPointSet ? kCardColor : color,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}