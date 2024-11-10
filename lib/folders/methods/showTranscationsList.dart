// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:transcation_history/lib.dart';

void showTransactionsBottomSheet(
    BuildContext context, List<Transaction> transactions) {
  int totalAmountSpentOrCredited = calculateTotalAmount(transactions);
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (transactions.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      " Total : $totalAmountSpentOrCredited $currency : (${totalAmountSpentOrCredited > 0 ? "debited" : "credited"}) ( ${formatDayMonth(transactions.first.date)} )"),
                  CloseButton(
                    color: Colors.red.shade300,
                  ),
                ],
              ),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return TransactionTile(
                      index: index, transaction: transactions[index]);
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}

class TransactionTile extends StatelessWidget {
  final int index;
  final Transaction transaction;
  const TransactionTile({
    super.key,
    required this.index,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      tileColor: Colors.black.withOpacity(0.8), // Dark background for dark mode
      title: Text(
        "Transaction ${index + 1}",
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Lighter color for dark mode
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4.0),
          Text(
            "Amount: $currency ${transaction.amount.toStringAsFixed(0)}",
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: Colors.green.shade400, // Lighter green for dark mode
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            "Category: ${transaction.category}",
            style: const TextStyle(
              fontSize: 13.0,
              color: Colors.white70, // Lighter grey for dark mode
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            "Subcategory: ${transaction.subcategory}",
            style: const TextStyle(
              fontSize: 13.0,
              color: Colors.white54, // Even lighter grey for dark mode
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            "Type: ${transaction.type}",
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
              color: transaction.type == TransactionType.debit
                  ? Colors.green.shade400 // Lighter red for dark mode
                  : Colors.red.shade400, // Lighter green for dark mode
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            "Time: ${formatTimeAMPM(transaction.date)}",
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.white60, // Lighter grey for dark mode
            ),
          ),
        ],
      ),
    );
  }
}
