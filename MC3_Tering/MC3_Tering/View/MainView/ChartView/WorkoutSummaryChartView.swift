//
//  WorkoutSummaryChartView.swift
//  MC3_Tering
//
//  Created by 김영빈 on 2023/08/02.
//

import Charts
import SwiftUI

//MARK: - 기록 탭뷰 하단 운동시간,칼로리 요약 차트
struct WorkoutSummaryChartView: View {
    var descriptionLabel: String = "7일간"
    var timeAverage: Double
    var caloryAverage: Double
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: .infinity, minHeight: 277)
                .background(Color.theme.teDarkGray)
                .cornerRadius(13)
                .padding(.top, 14)
            VStack(spacing: 0) {
                Text("지난 \(descriptionLabel)간 운동시간과 소모한 칼로리는\n각 평균 \(String(format: "%.2f", timeAverage))시간, \(String(format: "%.2f", caloryAverage))칼로리 입니다.")
                    .font(.custom("Inter-SemiBold", size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.theme.teWhite)

                Rectangle()
                    .frame(height: 0.5)
                    .padding(.top, 10)
                    .foregroundColor(Color.theme.teWhite)

                
                Chart {
                    ForEach(weekPerSwingDataType) { eachType in
                        ForEach(eachType.data) { element in
                            BarMark(
                                x: .value("Week Day", element.weekday),
                                y: .value("Count", element.count),
                                stacking: .unstacked // 바 차트 겹쳐서 보기 위한 파라미터
                            )
                            .cornerRadius(5)
                            .foregroundStyle(by: .value("Swing Type", eachType.swingDataType))
                        }
                    }
                    RuleMark(
                        y:.value("Workout Time Average", timeAverage)
                    )
                    .foregroundStyle(Color("TennisGreen"))
                    .lineStyle(StrokeStyle(dash: [2.5]))
                    .annotation(position: .leading, alignment: .leading) {
                        HStack(alignment: .bottom, spacing: 0) {
                            Text("\(String(format: "%.2f", timeAverage))")
                                .font(.custom("Inter-SemiBold", size: 32))
                            Text("시간")
                                .font(.custom("Inter-SemiBold", size: 12))
                        }
                        .foregroundColor(Color("TennisSkyBlue"))
                    }
                    
                    RuleMark(
                        y: .value("Burned Calory Average", caloryAverage)
                    )
                    .foregroundStyle(Color("TennisSkyBlue"))
                    .lineStyle(StrokeStyle(dash: [2.5]))
                    .annotation(position: .leading, alignment: .leading) {
                        HStack(alignment: .bottom, spacing: 0) {
                            Text("\(String(format: "%.2f", caloryAverage))")
                                .font(.custom("Inter-SemiBold", size: 32))
                            Text("kcal")
                                .font(.custom("Inter-SemiBold", size: 12))
                        }
                        .foregroundColor(Color("TennisWhite"))
                    }
                }
                .chartForegroundStyleScale([
                    "전체 스윙 횟수": .linearGradient(colors: [Color("TennisGreen"), Color("TennisBlack")], startPoint: .init(x: 0.5, y: 0.0), endPoint: .init(x: 0.5, y: 0.8)),
                    "퍼펙트 스윙 횟수": .linearGradient(colors: [Color("TennisSkyBlue"), Color("TennisBlack")], startPoint: .init(x: 0.5, y: 0), endPoint: .init(x: 0.5, y: 0.9))
                ])
                .chartXAxis(.hidden)
                .chartYAxis(.hidden)
                .frame(height: 160)
                .padding(.top, 30)
                .padding(.leading, 70)
            }
            .padding(EdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 15))
        }
        .padding(.leading, 17)
        .padding(.trailing, 17)
    }
}

//struct WorkoutSummaryChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkoutSummaryChartView()
//    }
//}
