import 'package:flutter/material.dart';

class FilteredPlantationDropdown extends StatefulWidget {
  final String unitKerja;
  final String divisi;
  final String? selectedComplex;
  final String? selectedBlock;
  final Function(String?) onComplexChanged;
  final Function(String?) onBlockChanged;
  final bool enabled;

  const FilteredPlantationDropdown({
    super.key,
    required this.unitKerja,
    required this.divisi,
    this.selectedComplex,
    this.selectedBlock,
    required this.onComplexChanged,
    required this.onBlockChanged,
    this.enabled = true,
  });

  @override
  State<FilteredPlantationDropdown> createState() => _FilteredPlantationDropdownState();
}

class _FilteredPlantationDropdownState extends State<FilteredPlantationDropdown> {
  final Map<String, List<String>> complexesByDivision = {
    '01': ['192016D24', '192016D25', '192017D26', '192018D26', '192018D44', '192019D39', '192021D48', '192086D02', '192086D03', '192087D01'],
    '02': ['192015G27', '192015G28', '192016D29', '192017D30', '192019D40', '192021D44', '192086D06', '192086G04', '192086G05', '192086S46', '192089D07'],
    '03': ['192013D33', '192016D32', '192017D31', '192019D41', '192086D09', '192089D08'],
    '04': ['192016D34', '192016D35', '192016D36', '192016D37', '192019D42', '192086D11', '192086D12', '192086D13', '192089D14'],
    '06': ['192012G40', '192013G38', '192014G39', '192016D38', '192016G35', '192019D43'],
    '07': ['192012B41', '192013B42', '192014B43', '192087S47'],
  };
  
  final Map<String, List<String>> blocksByComplex = {
    '192016D24': ['A-34', 'A-35', 'A-36', 'A-37', 'A-38', 'A-39', 'B-36'],
    '192016D25': ['A-40', 'A-41', 'A-42', 'B-37', 'B-38', 'B-39', 'B-40', 'B-41', 'B-42'],
    '192017D26': ['C-37', 'C-38', 'C-39', 'C-40', 'C-41', 'C-42', 'D-38', 'D-42'],
    '192018D26': ['D-39', 'D-40', 'D-41'],
    '192018D44': ['D-39', 'D-40', 'D-41'],
    '192019D39': ['A-61', 'A-62', 'A-63', 'A-64', 'A-65', 'A-66', 'A-67', 'A-68', 'A-69', 'B-66', 'C-66', 'D-66'],
    '192021D48': ['D-70'],
    '192086D02': ['A-08', 'A-09', 'A-10', 'B-05', 'B-06', 'B-07', 'B-08', 'B-09', 'B-10'],
    '192086D03': ['C-05', 'C-06', 'C-07', 'C-08', 'C-09', 'C-10', 'D-06', 'D-07', 'D-08', 'D-09', 'D-10'],
    '192087D01': ['A-02', 'A-03', 'A-04', 'A-05', 'A-06', 'A-07', 'B-04'],
    '192015G27': ['D-43', 'D-44', 'D-45', 'D-46', 'D-47', 'D-48', 'D-49'],
    '192015G28': ['A-43', 'B-43', 'B-44', 'C-43', 'C-44', 'C-45', 'C-46'],
    '192016D29': ['B-45', 'B-46', 'B-47', 'B-48', 'B-49', 'C-47', 'C-48', 'C-49'],
    '192017D30': ['A-45', 'A-46', 'A-47', 'A-48'],
    '192019D40': ['A-70', 'A-71', 'A-72', 'A-73', 'A-74'],
    '192021D44': ['D-69'],
    '192086D06': ['B-13', 'B-14', 'B-15', 'B-16', 'B-17', 'C-15', 'C-16', 'C-17'],
    '192086G04': ['D-15', 'D-16'],
    '192086G05': ['A-11', 'B-12', 'C-13', 'C-14'],
    '192086S46': ['D-16'],
    '192089D07': ['A-13', 'A-14', 'A-15', 'A-16', 'A-17'],
    '192013D33': ['C-50', 'C-51', 'C-52', 'D-50', 'D-51', 'D-52', 'D-53', 'D-54', 'D-55', 'D-56'],
    '192016D32': ['B-50', 'B-51', 'B-52', 'B-53', 'B-54', 'B-55', 'B-56', 'C-53', 'C-54', 'C-55', 'C-56'],
    '192017D31': ['A-50', 'A-51', 'A-52', 'A-53', 'A-54', 'A-55', 'A-56'],
    '192019D41': ['A-75', 'A-76', 'A-77', 'A-78', 'A-79', 'A-80', 'A-81'],
    '192086D09': ['B-18', 'B-19', 'B-20', 'B-21', 'B-22', 'B-23', 'B-24', 'C-21', 'C-22', 'C-23', 'C-24'],
    '192089D08': ['A-18', 'A-19', 'A-20', 'A-21', 'A-22', 'A-23', 'A-24'],
    '192016D34': ['D-57', 'D-58', 'D-59', 'D-60', 'D-61', 'D-62', 'D-63'],
    '192016D35': ['C-57', 'C-58', 'C-59', 'C-60', 'C-61', 'C-62', 'C-63'],
    '192016D36': ['A-57', 'A-58', 'A-59', 'B-57', 'B-58', 'B-59', 'B-60', 'B-61', 'B-62'],
    '192016D37': ['C-64', 'C-65', 'D-64', 'D-65'],
    '192019D42': ['A-82', 'A-83', 'A-84', 'B-67', 'B-68', 'B-69', 'C-67', 'D-67'],
    '192086D11': ['D-25', 'D-26', 'D-27', 'D-28', 'D-29', 'D-30', 'D-31'],
    '192086D12': ['C-25', 'C-26', 'C-27', 'C-28', 'C-29', 'C-30', 'C-31'],
    '192086D13': ['A-25', 'A-26', 'A-27', 'B-25', 'B-26', 'B-27', 'B-28', 'B-31', 'B-32'],
    '192089D14': ['C-32', 'C-33', 'D-32', 'D-33'],
    '192012G40': ['E-49', 'E-50', 'E-51', 'E-52', 'E-53', 'E-54', 'E-55', 'E-56', 'E-57'],
    '192013G38': ['G-49', 'G-50', 'G-51', 'G-52', 'G-53', 'G-54', 'G-55', 'G-56', 'G-57'],
    '192014G39': ['F-49', 'F-50', 'F-51', 'F-52', 'F-53', 'F-54', 'F-55', 'F-56', 'F-57'],
    '192016D38': ['F-58', 'F-59', 'F-60', 'F-61', 'F-62', 'F-63', 'F-64'],
    '192016G35': ['E-58', 'E-59', 'E-60', 'E-61', 'E-62', 'E-63', 'E-64', 'E-65'],
    '192019D43': ['D-68'],
    '192012B41': ['E-39', 'E-40', 'E-41', 'E-42', 'E-43', 'E-44', 'E-45', 'E-46', 'E-47', 'E-48'],
    '192013B42': ['F-42', 'F-44', 'F-45', 'F-46', 'F-47', 'F-48', 'G-42', 'G-43', 'G-45', 'G-46', 'G-47', 'G-48'],
    '192014B43': ['F-40', 'F-41', 'G-39', 'G-40', 'G-41'],
    '192087S47': ['E-15'],
  };
  
  List<String> get complexes => complexesByDivision[widget.divisi] ?? [];
  List<String> get blocks => widget.selectedComplex != null ? (blocksByComplex[widget.selectedComplex!] ?? []) : [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          initialValue: complexes.contains(widget.selectedComplex) ? widget.selectedComplex : null,
          decoration: const InputDecoration(labelText: 'Complex'),
          items: complexes.map((comp) => DropdownMenuItem(value: comp, child: Text(comp))).toList(),
          onChanged: widget.enabled ? (value) {
            widget.onComplexChanged(value);
            widget.onBlockChanged(null);
            setState(() {});
          } : null,
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          initialValue: blocks.contains(widget.selectedBlock) ? widget.selectedBlock : null,
          decoration: const InputDecoration(labelText: 'No Blok'),
          items: blocks.map((block) => DropdownMenuItem(value: block, child: Text(block))).toList(),
          onChanged: widget.enabled && widget.selectedComplex != null ? widget.onBlockChanged : null,
        ),
      ],
    );
  }
}