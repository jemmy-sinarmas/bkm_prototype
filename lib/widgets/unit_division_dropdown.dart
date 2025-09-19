import 'package:flutter/material.dart';

class UnitDivisionDropdown extends StatefulWidget {
  final String? selectedUnit;
  final String? selectedDivision;
  final Function(String?) onUnitChanged;
  final Function(String?) onDivisionChanged;
  final bool enabled;

  const UnitDivisionDropdown({
    super.key,
    this.selectedUnit,
    this.selectedDivision,
    required this.onUnitChanged,
    required this.onDivisionChanged,
    this.enabled = true,
  });

  @override
  State<UnitDivisionDropdown> createState() => _UnitDivisionDropdownState();
}

class _UnitDivisionDropdownState extends State<UnitDivisionDropdown> {
  final List<String> units = ['LIBE'];
  final Map<String, List<String>> divisionsByUnit = {
    'LIBE': ['01', '02', '03', '04', '06', '07'],
  };
  
  List<String> get divisions => divisionsByUnit[widget.selectedUnit] ?? [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          initialValue: units.contains(widget.selectedUnit) ? widget.selectedUnit : null,
          decoration: const InputDecoration(labelText: 'Unit Kerja'),
          items: units.map((unit) => DropdownMenuItem(value: unit, child: Text(unit))).toList(),
          onChanged: widget.enabled ? (value) {
            widget.onUnitChanged(value);
            widget.onDivisionChanged(null);
            setState(() {});
          } : null,
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          initialValue: divisions.contains(widget.selectedDivision) ? widget.selectedDivision : null,
          decoration: const InputDecoration(labelText: 'Divisi'),
          items: divisions.map((div) => DropdownMenuItem(value: div, child: Text(div))).toList(),
          onChanged: widget.enabled && widget.selectedUnit != null ? widget.onDivisionChanged : null,
        ),
      ],
    );
  }
}