part of 'shared.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> list;
  final dynamic value;
  final String label;

  final void Function(T value)? onSelectPicker;
  const CustomDropdown({
    super.key,
    required this.list,
    required this.value,
    required this.label,
    this.onSelectPicker,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: label,
              border: InputBorder.none,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                  style: Theme.of(context).textTheme.bodyText1,
                  isExpanded: true,
                  isDense: true,
                  value: value,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: list,
                  onChanged: (newVal) {
                    if (newVal != null && onSelectPicker != null) {
                      onSelectPicker!(newVal);
                    }
                  }),
            ),
          ),
        ),
      ],
    );
  }
}
