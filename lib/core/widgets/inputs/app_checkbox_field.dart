import 'package:coach_app/core/theme/app_spacing.dart';
import 'package:coach_app/core/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class AppCheckboxField extends FormField<bool> {
  AppCheckboxField({
    required String label,
    super.validator,
    super.initialValue = false,
    super.key,
  }) : super(
         builder: (field) {
           final context = field.context;
           final value = field.value ?? false;
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               InkWell(
                 borderRadius: AppRadius.button,
                 onTap: () => field.didChange(!value),
                 child: Row(
                   children: [
                     Checkbox(
                       value: value,
                       onChanged: (checked) => field.didChange(checked),
                       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                       visualDensity: VisualDensity.compact,
                     ),
                     const SizedBox(width: AppSpacing.xs),
                     Expanded(
                       child: Text(label, style: context.textStyles.body),
                     ),
                   ],
                 ),
               ),
               if (field.hasError)
                 Padding(
                   padding: const EdgeInsets.only(top: AppSpacing.xxs),
                   child: Text(
                     field.errorText!,
                     style: context.textStyles.bodySmall.copyWith(
                       color: context.colors.error,
                     ),
                   ),
                 ),
             ],
           );
         },
       );
}
