import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/location/locationzone/location_zone_model.dart';
import 'package:workdey_frontend/core/providers/location/location_provider.dart';

class ZoneSelector extends ConsumerStatefulWidget {
  final Function(LocationZone) onZoneSelected;
  final LocationZone? initialZone;
  final String label;
  final String hint;

  const ZoneSelector({
    super.key,
    required this.onZoneSelected,
    this.initialZone,
    this.label = 'Select Zone',
    this.hint = 'Search for your area...',
  });

  @override
  ConsumerState<ZoneSelector> createState() => _ZoneSelectorState();
}

class _ZoneSelectorState extends ConsumerState<ZoneSelector> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  LocationZone? _selectedZone;

  @override
  void initState() {
    super.initState();
    _selectedZone = widget.initialZone;
    if (_selectedZone != null) {
      _controller.text = _selectedZone!.fullName ?? '${_selectedZone!.name}, ${_selectedZone!.city}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final zoneSearchState = ref.watch(zoneSearchProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        
        // Search TextField
        TextFormField(
          controller: _controller,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: const Icon(Icons.location_on),
            suffixIcon: _selectedZone != null
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: _clearSelection,
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onChanged: (query) {
            if (query.isEmpty) {
              ref.read(zoneSearchProvider.notifier).clearSearch();
            } else {
              ref.read(zoneSearchProvider.notifier).searchZones(query);
            }
          },
        ),
        
        // Search Results
        if (zoneSearchState.query.isNotEmpty && _focusNode.hasFocus)
          Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: _buildSearchResults(zoneSearchState),
          ),
      ],
    );
  }

  Widget _buildSearchResults(ZoneSearchState state) {
    if (state.isLoading) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.error != null) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Error: ${state.error}',
          style: TextStyle(color: Colors.red[600]),
        ),
      );
    }

    if (state.zones.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('No zones found'),
      );
    }

    return Column(
      children: [
        // Popular zones first
        ...state.zones.where((z) => z.isPopular).map(_buildZoneItem),
        if (state.zones.any((z) => z.isPopular) && state.zones.any((z) => !z.isPopular))
          const Divider(),
        // Other zones
        ...state.zones.where((z) => !z.isPopular).map(_buildZoneItem),
      ],
    );
  }

  Widget _buildZoneItem(LocationZone zone) {
    return ListTile(
      leading: Icon(
        zone.isPopular ? Icons.star : Icons.location_city,
        color: zone.isPopular ? Colors.amber : Colors.grey,
      ),
      title: Text(zone.name),
      subtitle: Text(zone.city + (zone.district?.isNotEmpty == true ? ', ${zone.district}' : '')),
      trailing: zone.isPopular 
          ? const Chip(
              label: Text('Popular', style: TextStyle(fontSize: 10)),
              backgroundColor: Colors.amber,
            )
          : null,
      onTap: () => _selectZone(zone),
    );
  }

  void _selectZone(LocationZone zone) {
    setState(() {
      _selectedZone = zone;
      _controller.text = zone.fullName ?? '${zone.name}, ${zone.city}';
    });
    _focusNode.unfocus();
    ref.read(zoneSearchProvider.notifier).clearSearch();
    widget.onZoneSelected(zone);
  }

  void _clearSelection() {
    setState(() {
      _selectedZone = null;
      _controller.clear();
    });
    ref.read(zoneSearchProvider.notifier).clearSearch();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}