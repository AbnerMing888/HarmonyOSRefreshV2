import { TitleBar } from "@abner/bar"
import { GridView } from "@abner/refresh_v2"
import { RouterPath, startPage } from "@abner/router"

@RouterPath("example_LitheV2Index")
@ComponentV2
export struct LitheV2Index {
  private mGridData: string[] = ["任意组件刷新", "List组件刷新加载", "Grid组件刷新加载",
    "WaterFlow组件刷新加载", "自定义刷新头尾", "自动下拉刷新",
    "无阻尼效果", "最大阻尼效果", "加载数据不回弹", "显示暂无数据", "固定暂无数据", "刷新不禁止拖动", "三个点刷新头",
    "懒加载封装使用", "沉浸式", "Web组件使用", "自适应高度", "多视图", "自动加载数据"]
  private mRouterData: string[] = [
    "example_LitheV2RefreshUpAndDownPage",
    "example_LitheV2ListUpAndDownPage",
    "example_LitheV2GridUpAndDownPage",
    "example_LitheV2WaterFlowUpAndDownPage",
    "example_LitheV2RefreshHeaderAndFooterPage",
    "example_LitheV2AutoRefreshPage",
    "example_LitheV2NoScrollSpringPage",
    "example_LitheV2ListMaxSpringPage",
    "example_LitheV2LoadDataSpringBackPage",
    "example_LitheV2FooterNothingPage",
    "example_LitheV2FixedFooterPage",
    "example_LitheV2RefreshScrollPage",
    "example_LitheV2RefreshPointPage",
    "example_LitheV2LazyDataOperationPage",
    "example_LitheV2RefreshImmersivePage",
    "example_LitheV2WebViewPage",
    "example_LitheV2AdaptiveHeightPage",
    "example_LitheV2MultiViewPage",
    "example_LitheV2AutoListUpAndDownPage"
  ]

  build() {
    Column() {
      TitleBar({ title: "LitheView(V2装饰器)" })
      GridView({
        items: this.mGridData,
        itemLayout: (item: Object, index: number) => {
          this.itemLayout(item as string, index)
        },
        gridAttribute: (attr) => {
          attr.columnsGap = 10
          attr.rowsGap = 10
          attr.padding = { left: 20, right: 20, bottom: 20 }
        }
      })
    }
    .height('100%')
    .width('100%')
  }

  @Builder
  itemLayout(item: string, index: number) {
    Text(item)
      .width("100%")
      .height(50)
      .textAlign(TextAlign.Center)
      .fontColor($r("app.color.tab_select_color"))
      .fontSize(14)
      .border({ width: 1, color: $r("app.color.tab_select_color"), radius: 5 })
      .onClick(() => {
        startPage(this.mRouterData[index])
      })
  }
}