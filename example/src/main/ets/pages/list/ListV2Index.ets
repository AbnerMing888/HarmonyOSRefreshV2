import { TitleBar } from "@abner/bar";
import { RouterPath, startPage } from "@abner/router"


@RouterPath("example_ListV2Index")
@Component
export struct ListV2Index {
  /**
   *AUTHOR:AbnerMing
   *INTRODUCE:List组件名字数组
   */
  private listNameArray = [
    "普通数据模式", "懒加载数据模式", "自适应高度(顶部)", "自适应高度(底部)", "下拉刷新", "上拉加载",
    "刷新&加载(普通数据)", "刷新&加载(懒加载数据)", "无阻尼", "最大阻尼", "阻尼系数", "上拉加载不回弹",
    "底部暂无数据", "底部暂无数据固定", "添加头组件", "添加尾组件", "头和尾都有组件", "自定义刷新头加载尾", "侧滑按钮",
    "侧滑直接删除", "列表分组&吸顶",
    "分组吸顶(带分组索引)", "列表分组不吸顶", "页面吸顶(普通)", "页面吸顶(刷新&加载)", "页面顶部吸顶刷新",
    "任意布局吸顶", "结合Tabs使用", "自动刷新",
    "位置定位", "禁止后带阻尼", "自动加载数据", "普通加载数据操作", "懒加载数据操作", "缺省页"
  ]
  /**
   *AUTHOR:AbnerMing
   *INTRODUCE:ListView组件路由数组
   */
  private listViewPathArray = [
    "example_ListViewV2Page", //普通数据模式
    "example_ListViewV2LazyPage", //懒加载数据模式
    "example_ListViewV2AdaptivePage", //自适应高度顶部
    "example_ListViewV2AdaptivePage2", //自适应高度底部
    "example_ListViewV2RefreshPage", //下拉刷新
    "example_ListViewV2LoadMorePage", //上拉加载
    "example_ListViewV2UpAndDownPage", //普通的列表下拉刷新和上拉加载
    "example_ListViewV2UpAndDownLazyPage", //懒加载的列表下拉刷新和上拉加载
    "example_ListViewV2NoSpringPage", //无阻尼
    "example_ListViewV2MaxSpringPage", //最大阻尼
    "example_ListViewV2SpringRatioPage", //设置阻尼系数
    "example_ListViewV2NoReboundPage", //上拉加载不回弹
    "example_ListViewV2NoDataPage", //底部暂无数据
    "example_ListViewV2FixedBottomLoadPage", //底部加载无数据固定
    "example_ListViewV2HeaderPage", //带有头的ListView
    "example_ListViewV2FooterPage", //带有尾的ListView
    "example_ListViewV2HeaderAndFooterPage", //带有头尾的ListView
    "example_ListViewV2RefreshHeaderFooterPage", //自定义刷新头加载尾
    "example_ListViewV2SwipeActionPage", //侧滑按钮
    "example_ListViewV2SlideDeletePage", //侧滑删除
    "example_ListViewV2ItemGroupPage", //列表分组&吸顶
    "example_ListViewV2ItemGroupIndexPage", //列表分组吸顶,布局带有分组索引
    "example_ListViewV2ItemGroupNoStickyPage", //列表分组不吸顶
    "example_ListViewV2StickyTopPage", //列表页面吸顶
    "example_ListViewV2StickyRLTopPage", //列表页面刷新吸顶
    "example_ListViewV2StickLayoutPage", //列表顶部吸顶刷新
    "example_ListViewV2ArbitrarilyStickyTopPage", //任意布局吸顶刷新
    "example_ListViewV2TabsPage", //结合Tabs使用
    "example_ListViewV2AutoRefreshPage", //自动刷新
    "example_ListViewV2PositioningPage", //位置定位
    "example_ListViewV2EnableSpringPage", //刷新加载禁止后带阻尼
    "example_ListViewV2AutoLoadMorePage", //滑动到底部，自动加载更多
    "example_ListViewV2DataOperationPage",
    "example_ListViewV2LazyDataOperationPage",
    "example_ListViewV2ErrorOrEmptyPage"//缺省页
  ]
  /**
   *AUTHOR:AbnerMing
   *INTRODUCE:ListView组件路由数组
   */
  private listLayoutPathArray = [
    "example_ListLayoutV2Page",
    "example_ListLayoutV2LazyPage",
    "example_ListLayoutV2AdaptivePage",
    "example_ListLayoutV2AdaptivePage2",
    "example_ListLayoutV2RefreshPage",
    "example_ListLayoutV2LoadMorePage",
    "example_ListLayoutV2UpAndDownPage",
    "example_ListLayoutV2LazyUpAndDownPage",
    "example_ListLayoutV2NoSpringPage", //无阻尼
    "example_ListLayoutV2MaxSpringPage", //最大阻尼
    "example_ListLayoutV2SpringRatioPage",
    "example_ListLayoutV2NoReboundPage", //上拉加载不回弹
    "example_ListLayoutV2FixedBottomLoadPage", //底部暂无数据
    "example_ListLayoutV2FixedFooterPage", //底部暂无数据固定
    "example_ListLayoutV2HeaderPage", //添加头组件
    "example_ListLayoutV2FooterPage", //添加尾组件
    "example_ListLayoutV2HeaderAndFooterPage", //头和尾都有
    "example_ListLayoutV2RefreshHeaderFooterPage", //自定义刷新头加载尾
    "example_ListLayoutV2SwipeActionPage",
    "example_ListLayoutV2SlideDeletePage", //侧滑直接删除
    "example_ListLayoutV2ItemGroupPage", //列表分组吸顶
    "example_ListLayoutV2ItemGroupIndexPage",
    "example_ListLayoutV2ItemGroupNoStickyPage", //列表分组不吸顶
    "example_ListLayoutV2StickyTopPage",
    "example_ListLayoutV2StickyTopRefreshPage", //刷新
    "example_ListLayoutV2StickPage", //页面顶部吸顶刷新
    "example_ListLayoutV2ArbitrarilyStickyTopPage", //任意的布局吸顶
    "example_ListLayoutV2TabsPage",
    "example_ListLayoutV2AutoRefreshPage", //自动刷新
    "example_ListLayoutV2PositioningPage", //位置定位
    "example_ListLayoutV2EnableSpringPage", //禁止后支持阻尼
    "example_ListLayoutV2AutoLoadMorePage",//自动加载更多数据
    "example_ListLayoutV2DataOperationPage",
    "example_ListLayoutV2LazyDataOperationPage",
    "example_ListLayoutV2ErrorOrEmptyPage"
  ]
  private listInfo =
    "列表组件是针对系统List组件进行封装，支持刷新加载等多种功能，目的是简化代码，目前存在两个组件，一个是ListView，一个是ListLayout，其功能一样，大家可以选择使用。"
  @State private isListLayout: boolean = false

  build() {
    Column() {
      TitleBar({
        title: "(V2)List列表组件"
      })
      Text(this.listInfo)
        .fontColor($r("app.color.tab_normal_color"))
        .fontSize(13)
        .padding({ left: 20, right: 20 })
        .margin({ top: 10, bottom: 20 })

      this.SwichMenu()

      Grid() {
        ForEach(this.listNameArray, (item: string, index: number) => {
          GridItem() {
            Text(item)
              .height(50)
              .width("100%")
              .fontSize(14)
              .fontColor($r("app.color.tab_select_color"))
              .textAlign(TextAlign.Center)
              .border({ color: $r("app.color.tab_select_color"), width: 1, radius: 5 })
              .onClick(() => {
                if (this.isListLayout) {
                  startPage(this.listLayoutPathArray[index])
                } else {
                  startPage(this.listViewPathArray[index])
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
        .offset({ x: this.isListLayout ? "50%" : 0 })
        .animation({ duration: 300 })

      Row() {
        Text("ListView")
          .fontSize(14)
          .layoutWeight(1)
          .height("100%")
          .textAlign(TextAlign.Center)
          .fontColor(this.isListLayout ? $r("app.color.tab_select_color") : Color.White)
          .onClick(() => {
            this.isListLayout = false
          })

        Text("ListLayout")
          .layoutWeight(1)
          .fontSize(14)
          .height("100%")
          .textAlign(TextAlign.Center)
          .fontColor(this.isListLayout ? Color.White : $r("app.color.tab_select_color"))
          .onClick(() => {
            this.isListLayout = true
          })
      }.height("100%")
    }
    .width(200)
    .height(40)
    .border({ width: 1, color: $r("app.color.tab_select_color") })
    .borderRadius(40)
    .margin({ top: 10, bottom: 20 })
    .alignContent(Alignment.TopStart)
  }
}