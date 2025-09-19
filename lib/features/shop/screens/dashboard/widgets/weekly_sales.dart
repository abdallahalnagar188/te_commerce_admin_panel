import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:te_commerce_admin_panel/common/widgets/icons/t_circular_icon.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../controllers/dashboard/dashboard_controller.dart';



class TWeeklySalesGraph extends StatelessWidget {
  const TWeeklySalesGraph({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());

    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TCircularIcon(icon: Iconsax.graph,backgroundColor: Colors.brown.withOpacity(0.1),color: Colors.brown,size: TSizes.md,),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Text(
                'Weekly Sales',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          // Graph
          Obx(
    ()=> controller.weeklySales.isNotEmpty? SizedBox(
              height: 400,
              child: BarChart(BarChartData(
                 titlesData: buildFlTitlesData(controller.weeklySales),
                  borderData: FlBorderData(
                      show: true,
                      border: const Border(
                          top: BorderSide.none,
                          right: BorderSide.none)),
                  gridData: FlGridData(
                      show: true,
                      drawHorizontalLine: true,
                      drawVerticalLine: true,
                      horizontalInterval: 200),
                  barGroups: controller.weeklySales
                      .asMap()
                      .entries
                      .map((entry) => BarChartGroupData(
                      x: entry.key,
                      barRods: [
                        BarChartRodData(
                            toY: entry.value,
                            width: 30,
                            color: TColors.primary,
                            borderRadius: BorderRadius.circular(TSizes.sm)
                        )
                      ]))
                      .toList(),
                  groupsSpace: TSizes.spaceBtwItems,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(getTooltipColor: (_)=> TColors.secondary),
                    touchCallback: TDeviceUtils.isDesktopScreen(context) ? (barTouchEvent,barTouchResponse){} :null,
                  )
              )),
            ): const SizedBox(height: 400,child: Center(child: CircularProgressIndicator()),),
          )
        ],
      ),
    );
  }

  FlTitlesData buildFlTitlesData(List<double> weeklySales) {
    double maxOrder = weeklySales.reduce((a,b) => a > b ? a : b).toDouble();
    double stepHeight = (maxOrder /10).ceilToDouble();
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
            final index = value.toInt() % days.length;
            final day = days[index];

            return SideTitleWidget(
              axisSide: AxisSide.bottom,
              space: 0, // spacing from chart
              child: Text(
                day,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
      ),
      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true,interval: stepHeight<= 0? 500:stepHeight,reservedSize: 50)),
      rightTitles:  AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles:  AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }
}