import 'package:flutter/material.dart';
// import 'package:psits_app/core/theme/app_theme.dart';
class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  int _selectedTab = 0;
  final List<String> _tabs = ['Pending', 'Completed', 'History'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments'),
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.all(16),
            child: Row(
              children: [
                for (int i = 0; i < _tabs.length; i++)
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = i),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _selectedTab == i 
                              ? Theme.of(context).colorScheme.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _tabs[i],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _selectedTab == i 
                                ? Colors.white 
                                : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Payment List
          Expanded(
            child: IndexedStack(
              index: _selectedTab,
              children: [
                // Pending Payments
                _buildPaymentList(true),
                // Completed Payments
                _buildPaymentList(false),
                // Payment History
                _buildPaymentHistory(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentList(bool isPending) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: isPending ? 3 : 2, // Mock data
      itemBuilder: (context, index) {
        return PaymentListItem(
          title: 'Payment ${index + 1}',
          amount: '₱${(index + 1) * 500}.00',
          deadline: 'Dec ${20 + index}, 2024',
          status: isPending ? 'pending' : 'completed',
          onPay: isPending ? () {
            // Process payment
            _showPaymentDialog(context);
          } : null,
        );
      },
    );
  }

  Widget _buildPaymentHistory() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 4, // Mock data
      itemBuilder: (context, index) {
        return PaymentHistoryItem(
          title: 'Historical Payment ${index + 1}',
          amount: '₱${(index + 1) * 300}.00',
          date: 'Nov ${15 + index}, 2024',
          status: index % 3 == 0 ? 'completed' : 
                  index % 3 == 1 ? 'failed' : 'pending',
        );
      },
    );
  }

  void _showPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Process Payment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Select payment method:'),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text('Credit/Debit Card'),
              onTap: () {
                Navigator.pop(context);
                // Process card payment
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_balance),
              title: const Text('Bank Transfer'),
              onTap: () {
                Navigator.pop(context);
                // Process bank transfer
              },
            ),
            ListTile(
              leading: const Icon(Icons.money),
              title: const Text('Cash'),
              onTap: () {
                Navigator.pop(context);
                // Process cash payment
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}

class PaymentListItem extends StatelessWidget {
  final String title;
  final String amount;
  final String deadline;
  final String status;
  final VoidCallback? onPay;

  const PaymentListItem({
    super.key,
    required this.title,
    required this.amount,
    required this.deadline,
    required this.status,
    this.onPay,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'completed':
        return Colors.green;
      case 'failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(status).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _getStatusColor(status)),
                  ),
                  child: Text(
                    status.toUpperCase(),
                    style: TextStyle(
                      color: _getStatusColor(status),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            Text(
              'Amount: $amount',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            
            Text(
              'Deadline: $deadline',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            
            if (onPay != null) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPay,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Pay Now'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class PaymentHistoryItem extends StatelessWidget {
  final String title;
  final String amount;
  final String date;
  final String status;

  const PaymentHistoryItem({
    super.key,
    required this.title,
    required this.amount,
    required this.date,
    required this.status,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'completed':
        return Icons.check_circle;
      case 'pending':
        return Icons.pending;
      case 'failed':
        return Icons.error;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(
          _getStatusIcon(status),
          color: _getStatusColor(status),
        ),
        title: Text(title),
        subtitle: Text(date),
        trailing: Text(
          amount,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _getStatusColor(status),
          ),
        ),
      ),
    );
  }
}