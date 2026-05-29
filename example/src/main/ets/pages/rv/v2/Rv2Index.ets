import { TitleBar } from "@abner/bar"
import { GridView } from "@abner/refresh_v2"
import { RouterPath, startPage } from "@abner/router"

@RouterPath("example_Rv2Index")
@ComponentV2
export struct Rv2Index {
  private mGridData: string[] = ["任意组件刷新", "List组件刷新", "Grid组件刷新",
    "WaterFlow组件刷新", "自定义刷新头尾", "自动下拉刷新",
    "无阻尼效果", "最大阻尼", "加载数据不回弹", "显示暂无数据", "固定暂无数据", "刷新不禁止拖动",
    "懒加载封装使用", "沉浸式", "自适应高度(顶部)", "自适应高度(底部)", "自动加载数据"]
  private mRouterData: string[] = [
    "example_Rv2RefreshUpAndDownPage", "example_Rv2ListUpAndDownPage", "example_Rv2GridUpAndDownPage",
    "example_Rv2WaterFlowUpAndDownPage", "example_Rv2RefreshHeaderAndFooterPage",
    "example_Rv2AutoRefreshPage", "example_Rv2NoScrollSpringPage", "example_Rv2MaxScrollSpringPage",
    "example_Rv2LoadDataSpringBackPage",
    "example_Rv2FooterNothingPage", "example_Rv2FixedFooterPage", "example_Rv2RefreshScrollPage",
    "example_Rv2LazyDataOperationPage", "example_Rv2RefreshImmersivePage"
    , "example_Rv2AdaptiveHeightPage", "example_Rv2MultiViewPage", "example_Rv2AutoListUpAndDownPage"
  ]

  build() {
    Column() {
      TitleBar({ title: "RefreshView(V2装饰器)" })
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