import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../component/modal_bottom_sheet_container.dart';
import '../../../component/theme/color.dart';
import '../../../component/theme/style.dart';
import '../../../core/util/flushbar.dart';
import '../../../local/database_manager.dart';
import '../../../local/entity/month_entity.dart';
import '../../month/viewmodel/month_viewmodel.dart';

class MonthBottomSheet extends StatefulWidget {
  final MonthViewmodel viewModel;

  const MonthBottomSheet({
    super.key,
    required this.viewModel,
  });

  @override
  State<MonthBottomSheet> createState() => _MonthBottomSheetState();
}

class _MonthBottomSheetState extends State<MonthBottomSheet> {
  final TextEditingController _amountController = TextEditingController();
  final NumberFormat _formatter = NumberFormat.decimalPattern();

  @override
  void initState() {
    super.initState();
    final selected = widget.viewModel.selectedMonth;
    if (widget.viewModel.isEditing && selected != null) {
      _amountController.text = _formatter.format(selected.amount);
    }
  }

  void _onSubmit() async {
    final raw = _amountController.text.replaceAll(',', '');
    final amount = int.tryParse(raw);

    if (amount == null) {
      FlushbarUtil.show(context, "유효한 금액을 입력해주세요.");
      return;
    }

    widget.viewModel.setIsLoading(true);

    try {
      final now = DateTime.now();
      final db = await DatabaseManager.getDatabase();

      final selectedMonth = widget.viewModel.selectedMonth;

      if (selectedMonth == null || selectedMonth.id == null) {
        final newMonth = MonthEntity(
          id: null,
          amount: amount,
          date: DateTime(now.year, now.month, 1),
        );
        await db.monthDao.insertMonthEntity(newMonth);
        widget.viewModel.getMonthEntities();
        widget.viewModel.setEditingMonth(newMonth);
      } else {
        final updated = MonthEntity(
          id: selectedMonth.id!,
          amount: amount,
          date: selectedMonth.date,
        );
        await db.monthDao.updateMonthEntity(updated);
        widget.viewModel.getMonthEntities();
        widget.viewModel.setEditingMonth(updated);
      }

      if (!mounted) return;

      Navigator.of(context).pop();

      Future.delayed(Duration(milliseconds: 100), () {
        if (!mounted) return;
        FlushbarUtil.show(
          context,
          "이번달 예산이 저장되었습니다.",
          color: HourColors.green,
        );
      });
    } catch (e, st) {
      print('Error in _onSubmit: $e\n$st');
      if (mounted) {
        FlushbarUtil.show(context, "저장 중 오류가 발생했습니다.");
      }
    } finally {
      widget.viewModel.setIsLoading(false);
    }
  }

  void _onAmountChanged(String value) {
    final raw = value.replaceAll(',', '');
    final parsed = int.tryParse(raw);
    if (parsed == null) return;

    final formatted = _formatter.format(parsed);
    if (formatted != value) {
      _amountController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
  }

  Widget _buildTitle() => Text(
    "이번달 예산 설정",
    style: HourStyles.title1.copyWith(color: HourColors.staticWhite),
  );

  Widget _buildAmountInput() => TextField(
    controller: _amountController,
    keyboardType: const TextInputType.numberWithOptions(decimal: false),
    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    decoration: InputDecoration(
      prefixText: '₩ ',
      prefixStyle: HourStyles.label1.copyWith(color: HourColors.staticWhite),
      hintText: '금액을 입력해주세요',
      hintStyle: HourStyles.label1.copyWith(color: HourColors.gray500),
      border: InputBorder.none,
    ),
    style: HourStyles.body2.copyWith(color: HourColors.staticWhite),
    onChanged: _onAmountChanged,
  );

  Widget _buildSaveButton() {
    final isLoading = widget.viewModel.isLoading;

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: HourColors.orange500),
      );
    }
    return ElevatedButton(
      onPressed: _onSubmit,
      style: ElevatedButton.styleFrom(
        backgroundColor: HourColors.primary300,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        "저장하기",
        style: HourStyles.label1.copyWith(
            color: HourColors.staticWhite
        ),
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.35,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return ModalBottomSheetContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              controller: scrollController,
              children: [
                const SizedBox(height: 12),
                _buildTitle(),
                const SizedBox(height: 16),
                _buildAmountInput(),
                const SizedBox(height: 24),
                _buildSaveButton(),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }
}