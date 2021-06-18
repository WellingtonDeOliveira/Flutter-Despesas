import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class ListTotal extends StatelessWidget {
  final List<Transaction> listTotal;

  ListTotal(this.listTotal);

  List<Map<String, Object>> get somaTransactions {
    return List.generate(1, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double mesSoma = 0.0;
      double anoSoma = 0.0;
      double totalSoma = 0.0;

      for (var i = 0; i < listTotal.length; i++) {
        bool sameMonth = listTotal[i].date.month == weekDay.month;
        bool sameYear = listTotal[i].date.year == weekDay.year;

        if (sameMonth && sameYear) {
          mesSoma += listTotal[i].value;
        }
        if (sameYear) {
          anoSoma += listTotal[i].value;
        }
        totalSoma += listTotal[i].value;
      }

      return {
        'value1': mesSoma,
        'value2': anoSoma,
        'value3': totalSoma,
      };
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return listTotal.isEmpty
        ? Card(
            elevation: 1,
            margin: EdgeInsets.all(10),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Sem Gastos Registrados!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              )
            ]))
        : Card(
            elevation: 1,
            margin: EdgeInsets.all(10),
            child: FittedBox(
              alignment: Alignment.centerLeft,
              child: Column(
                children: somaTransactions.map((tr) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total gasto no mês: R\$ ${tr['value1']}',
                        style: TextStyle(
                            color: Colors.purple[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Text(
                        'Total gasto no ano: R\$ ${tr['value2']}',
                        style: TextStyle(
                            color: Colors.purple[400],
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      Text(
                        'Soma total de todas as suas despesas: R\$ ${tr['value3']}',
                        style: TextStyle(
                          color: Colors.purple[300],
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          );
  }
}
