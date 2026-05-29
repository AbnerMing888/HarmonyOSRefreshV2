import { TitleBar } from "@abner/bar"
import { RouterPath, startPage } from "@abner/router"

@RouterPath("example_FlowV2Index")
@Component
export struct FlowV2Index {
  /**
   *AUTHOR:AbnerMing
   *INTRODUCE:GridView组件名字数组
   */
  private flowNameArray = [
    "普通数据模式", "懒加载数据模式", "自适应高度(顶部)", "自适应高度(底部)", "下拉刷新", "上拉加载",
    "刷新&加载(普通数据)", "刷新&加载(懒加载数据)", "无阻尼", "最大阻尼", "阻尼系数", "上拉加载不回弹",
    "底部暂无数据", "底部暂无数据固定", "添加头组件", "添加尾组件", "头和尾都有组件", "自定义刷新头加载尾",
    "页面吸顶(普通)", "页面吸顶(刷新&加载)", "页面顶部吸顶刷新", "固定标题栏吸顶", "任意布局吸顶",
    "结合Tabs使用", "自动刷新", "位置定位", "禁止后带阻尼", "自动加载数据"
  ]
  /**
   *AUTHOR:AbnerMing
   *INTRODUCE:GridView组件路由数组
   */
  private flowViewPathArray = [
    "example_FlowViewV2Page",
    "example_FlowViewV2LazyPage",
    "example_FlowViewV2AdaptiveTopPage",
    "example_FlowViewV2AdaptiveBottomPage",
    "example_FlowViewV2RefreshPage",
    "example_FlowViewV2LoadMorePage",
    "example_FlowViewV2RefreshAndLoadMorePage",
    "example_FlowViewV2LazyRefreshAndLoadMorePage",
    "example_FlowViewV2NoSpringPage",
    "example_FlowViewV2MaxSpringPage",
    "example_FlowViewV2SpringRatioPage",
    "example_FlowViewV2NoReboundPage",
    "example_FlowViewV2NoDataPage",
    "example_FlowViewV2FixedBottomPage", //底部暂无数据固定
    "example_FlowViewV2HeaderPage",
    "example_FlowViewV2FooterPage",
    "example_FlowViewV2HeaderAndFooterPage",
    "example_FlowViewV2RefreshHeaderAndFooterPage",
    "example_FlowViewV2StickyTopPage",
    "example_FlowViewV2StickyRLTopPage",
    "example_FlowViewV2TopActionBarPage",//顶部吸顶
    "example_FlowViewV2StickyTopActionBarPage",
    "example_FlowViewV2ArbitrarilyStickyTopPage",
    "example_FlowViewV2TabsPage",
    "example_FlowViewV2AutoRefreshPage",
    "example_FlowViewV2PositioningPage",//定位
    "example_FlowViewV2EnableSpringPage",
    "example_FlowViewV2AutoLoadMorePage"
  ]
  /**
   *AUTHOR:AbnerMing
   *INTRODUCE:GridLayout组件路由数组
   */
  private flowLayoutPathArray = [
    "example_FlowLayoutV2Page",
    "example_FlowLayoutV2LazyPage",
    "example_FlowLayoutV2AdaptiveTopPage",
    "example_FlowLayoutV2AdaptiveBottomPage",
    "example_FlowLayoutV2RefreshPage",
    "example_FlowLayoutV2LoadMorePage",
    "example_FlowLayoutV2RefreshAndLoadMorePage",
    "example_FlowLayoutV2LazyRefreshAndLoadMorePage",
    "example_FlowLayoutV2NoSpringPage",
    "example_FlowLayoutV2MaxSpringPage",
    "example_FlowLayoutV2SpringRatioPage",
    "example_FlowLayoutV2NoReboundPage",
    "example_FlowLayoutV2NoDataPage",
    "example_FlowLayoutV2FixedBottomPage", //底部暂无数据固定
    "example_FlowLayoutV2HeaderPage",
    "example_FlowLayoutV2FooterPage",
    "example_FlowLayoutV2HeaderAndFooterPage", //头和尾
    "example_FlowLayoutV2RefreshHeaderAndFooterPage",
    "example_FlowLayoutV2StickyTopPage",
    "example_FlowLayoutV2StickyRLTopPage",
    "example_FlowLayoutV2TopActionBarPage",//顶部吸顶
    "example_FlowViewV2StickyTopActionBarPage",
    "example_FlowViewV2ArbitrarilyStickyTopPage",
    "example_FlowLayoutV2TabsPage",//结合tabs
    "example_FlowLayoutV2AutoRefreshPage",
    "example_FlowLayoutV2PositioningPage",//定位
    "example_FlowLayoutV2EnableSpringPage",
    "example_FlowLayoutV2AutoLoadMorePage"
  ]
  private gridInfo =
    "瀑布流组件是针对系统WaterFlow组件进行封装，支持刷新加载等多种功能，目的是简化代码，目前存在两个组件，一个是StaggeredGridView，一个是WaterFlowLayout，其功能一样，大家可以选择使用。"
  @State gridMessage: string = "StaggeredGridView"
  @State private isWaterFlowLayout: boolean = false

  build() {
    Column() {
      TitleBar({
        title: "(V2)WaterFlow瀑布流组件"
      })

      Text(this.gridInfo)
        .fontColor($r("app.color.tab_normal_color"))
        .fontSize(13)
        .padding({ left: 20, right: 20 })
        .margin({ top: 10, bottom: 20 })

      this.SwichMenu()

      Grid() {
        ForEach(this.flowNameArray, (item: string, index: number) => {
          GridItem() {
            Text(item)
              .height(50)
              .width("100%")
              .fontSize(14)
              .fontColor($r("app.color.tab_select_color"))
              .textAlign(TextAlign.Center)
              .border({ color: $r("app.color.tab_select_color"), width: 1, radius: 5 })
              .onClick(() => {
                if (this.isWaterFlowLayout) {
                  startPage(this.flowLayoutPathArray[index])
                } else {
                  startPage(this.flowViewPathArray[index])
                }
              })
          }
        })
      }
      .width("100%")
      .height("100%")
      .layoutWeight(1)
      .columnsTemplate("1fr 1fr")
      .columnsGap(10)
      .rowsGap(10)
      .padding({ left: 20, right: 20, bottom: 20 })
      .scrollBar(BarState.Off)
    }
    .height('100%')
    .width('100%')
  }

  @Builder
  SwichMenu() {
    Stack() {
      Column()
        .width("50%")
        .height("100%")
        .backgroundColor($r("app.color.tab_select_color"))
        .borderRadius(50)
        .offset({ x: this.isWaterFlowLayout ? "50%" : 0 })
        .animation({ duration: 300 })

      Row() {
        Text("StaggeredGridView")
          .fontSize(14)
          .layoutWeight(1)
          .height("100%")
          .textAlign(TextAlign.Center)
          .fontColor(this.isWaterFlowLayout ? $r("app.color.tab_select_color") : Color.White)
          .onClick(() => {
            this.isWaterFlowLayout = false
          })

        Text("WaterFlowLayout")
          .layoutWeight(1)
          .fontSize(14)
          .height("100%")
          .textAlign(TextAlign.Center)
          .fontColor(this.isWaterFlowLayout ? Color.White : $r("app.color.tab_select_color"))
          .onClick(() => {
            this.isWaterFlowLayout = true
          })
      }.height("100%")
    }
    .width(300)
    .height(40)
    .border({ width: 1, color: $r("app.color.tab_select_color") })
    .borderRadius(40)
    .margin({ top: 10, bottom: 20 })
    .alignContent(Alignment.TopStart)
  }
}