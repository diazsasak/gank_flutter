import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:gank_flutter/modules/account/view/echart.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SkillChart(),
          Text(
            'BOOST UP YOUR PROFILE TO GROW YOUR AUDIENCE',
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(fontStyle: FontStyle.italic, fontSize: 12.0),
          ),
          SizedBox(height: 10),
          Text(
            'INCOMPLETE PROFILE',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: Colors.red,
                  fontSize: 8.0,
                ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.person, color: Colors.white),
                SizedBox(width: 5),
                Text(
                  'Tell us about yourself, add a bio',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.play_circle_outline_outlined, color: Colors.white),
                SizedBox(width: 5),
                Text(
                  'Add your streaming accounts',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
