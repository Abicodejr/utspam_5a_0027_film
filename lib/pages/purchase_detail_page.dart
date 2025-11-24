import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../database/database_helper.dart';
import '../models/transaction.dart';
import 'edit_purchase_page.dart';

class PurchaseDetailPage extends StatefulWidget {
  final int transactionId;

  const PurchaseDetailPage({super.key, required this.transactionId});

  @override
  State<PurchaseDetailPage> createState() => _PurchaseDetailPageState();
}

class _PurchaseDetailPageState extends State<PurchaseDetailPage> {
  Transaction? _transaction;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTransaction();
  }

  Future<void> _loadTransaction() async {
    setState(() => _isLoading = true);

    try {
      final data = await DatabaseHelper.instance.getTransactionById(
        widget.transactionId,
      );
      if (data != null) {
        setState(() {
          _transaction = Transaction.fromMap(data);
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Transaction not found')),
          );
          Navigator.pop(context);
        }
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load transaction: $e')),
        );
      }
    }
  }

  Future<void> _cancelTransaction() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text(
          'CANCEL TRANSACTION',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        content: const Text(
          'Are you sure you want to cancel this transaction? This action cannot be undone.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'NO',
              style: TextStyle(color: Colors.white70, letterSpacing: 1),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'YES, CANCEL',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await DatabaseHelper.instance.deleteTransaction(widget.transactionId);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Transaction cancelled')),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Failed to cancel: $e')));
        }
      }
    }
  }

  String _maskCardNumber(String cardNumber) {
    if (cardNumber.length <= 4) return cardNumber;
    final lastFour = cardNumber.substring(cardNumber.length - 4);
    return '**** **** **** $lastFour';
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'PURCHASE DETAIL',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : _transaction == null
          ? const Center(
              child: Text(
                'Transaction not found',
                style: TextStyle(color: Colors.white70),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white24, width: 1),
                        color: Colors.white.withOpacity(0.02),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white24,
                                width: 1,
                              ),
                              color: Colors.white.withOpacity(0.05),
                            ),
                            child: Center(
                              child: Text(
                                _transaction!.filmPoster,
                                style: const TextStyle(fontSize: 60),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            _transaction!.filmTitle.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _transaction!.filmGenre,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildDetailRow('SCHEDULE', _transaction!.schedule),
                    const SizedBox(height: 16),
                    _buildDetailRow('BUYER NAME', _transaction!.buyerName),
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      'QUANTITY',
                      '${_transaction!.quantity} ticket(s)',
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      'PURCHASE DATE',
                      _transaction!.purchaseDate,
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      'PAYMENT METHOD',
                      _transaction!.paymentMethod,
                    ),
                    if (_transaction!.cardNumber != null) ...[
                      const SizedBox(height: 16),
                      _buildDetailRow(
                        'CARD NUMBER',
                        _maskCardNumber(_transaction!.cardNumber!),
                      ),
                    ],
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      'STATUS',
                      _transaction!.status.toUpperCase(),
                      valueColor: _transaction!.status == 'completed'
                          ? Colors.white
                          : Colors.red,
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        color: Colors.white.withOpacity(0.05),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'TOTAL PRICE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            currencyFormat.format(_transaction!.totalPrice),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_transaction!.status == 'completed') ...[
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditPurchasePage(
                                  transaction: _transaction!,
                                ),
                              ),
                            );
                            _loadTransaction();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: const RoundedRectangleBorder(),
                            elevation: 0,
                          ),
                          child: const Text(
                            'EDIT TRANSACTION',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: OutlinedButton(
                        onPressed: _cancelTransaction,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white, width: 2),
                          shape: const RoundedRectangleBorder(),
                        ),
                        child: const Text(
                          'CANCEL TRANSACTION',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white24, width: 1),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white.withOpacity(0.02),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                color: valueColor ?? Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
