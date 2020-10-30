import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class SkillChart extends StatefulWidget {
  @override
  _SkillChartState createState() => _SkillChartState();
}

class _SkillChartState extends State<SkillChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.all(0),
      child: Echarts(
        option: '''
    {
    backgroundColor: "#1D2129",
    
    radar: [
        {
            indicator: [
                { text: 'Jungle', max: 10 },
                { text: 'Support 3', max: 10 },
                { text: 'Support 2', max: 10 },
                { text: 'Support', max: 10 },
                { text: 'AD', max: 10 },
                { text: 'Top', max: 10 },
                { text: 'Mid', max: 10 }
            ],
            center: ['50%', '50%'],
            radius: 40,
            startAngle: 90,
            splitNumber: 7,
            name: {
                formatter: '{value}',
                textStyle: {
                    color: '#74768B'
                }
            },
            splitArea: {
                areaStyle: {
                    color: ['rgba(114, 172, 209, 0.2)',
                        'rgba(114, 172, 209, 0.4)', 'rgba(114, 172, 209, 0.6)',
                        'rgba(114, 172, 209, 0.8)', 'rgba(114, 172, 209, 1)'],
                    shadowColor: 'rgba(0, 0, 0, 0.3)',
                    shadowBlur: 10
                }
            },
            axisLine: {
                lineStyle: {
                    color: '#292B37'
                }
            },
            splitLine: {
                lineStyle: {
                    color: '#292B37'
                }
            }
        },
        
    ],
    series: [
        {
            name: 'Skill',
            type: 'radar',
            emphasis: {
                lineStyle: {
                    width: 10
                }
            },
            data: [
                {
                    value: [5, 7, 7, 10, 3, 6, 7],
                    name: 'Skill',
                    areaStyle: {
                        color: '#6F475D'
                    }
                }
            ]
        },

    ]
}
  ''',
      ),
      width: 100,
      height: 200,
    );
  }
}
