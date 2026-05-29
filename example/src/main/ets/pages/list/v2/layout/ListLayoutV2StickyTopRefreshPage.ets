import { ListLayout, RefreshController,
  RefreshPositionEnum } from "@abner/refresh_v2"
import { RouterPath } from "@abner/router"
import { ListItemV2View } from "../../../../view/ListItemV2View"

/**
 *AUTHOR:AbnerMing
 *DATE:2026/4/23
 *INTRODUCE:页面吸顶案例二  带有刷新和加载
 */
@RouterPath("example_ListLayoutV2StickyTopRefreshPage")
@ComponentV2
export struct ListLayoutV2StickyTopRefreshPage {
  @Local listPosition: RefreshPositionEnum = RefreshPositionEnum.TOP
  @Local isEnableScrollInteraction: boolean = true

  build() {
    Scroll() {
      Column() {
        Text("顶部View")
          .fontColor(Color.White)
          .width("100%")
          .height("40%")
          .backgroundColor($r("app.color.tab_select_color"))
          .textAlign(TextAlign.Center)

        Tabs({ barPosition: BarPosition.Start }) {
          TabContent() {
            this.testLayout(0)
          }.tabBar("Tab1")

          TabContent() {
            this.testLayout(1)
          }.tabBar("Tab2")
        }
        .vertical(false)
        .height("100%")
      }.width("100%")
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .onReachStart(() => {
      this.listPosition = RefreshPositionEnum.TOP
    })
    .onReachEnd(() => {
      this.listPosition = RefreshPositionEnum.BOTTOM
    })
    .onScrollFrameBegin((offset: number, _: ScrollState) => {
      if ((this.listPosition == RefreshPositionEnum.TOP && offset <= 0) || (
        this.listPosition == RefreshPositionEnum.BOTTOM && offset >= 0
      )
      ) {
        return { offsetRemain: 0 }
      }
      //不在底部
      this.listPosition = RefreshPositionEnum.CENTER
      return { offsetRemain: offset }
    })
    .enableScrollInteraction(this.isEnableScrollInteraction)

  }

  /*
  * Author:AbnerMing
  * Describe:这里仅仅是测试，实际应以业务需求为主，可以是任意得组件视图
  */
  @Builder
  testLayout(type: number) {
    StickyListView({
      pageType: type, listPosition: this.listPosition,
      onLoadMore: (isLoad) => {
        this.isEnableScrollInteraction = isLoad
      }
    })
  }
}

/*
* Author:AbnerMing
* Describe:吸顶列表
*/
@ComponentV2
struct StickyListView {
  @Param pageType: number = 0
  controller: RefreshController = new RefreshController() //刷新控制器
  @Local arr1: number[] = [] //实际情况当以tab指示器对应得数据为主，这里仅仅是测试
  @Local arr2: number[] = []
  @Param listPosition: RefreshPositionEnum = RefreshPositionEnum.TOP
  @Param onLoadMore?: (isLoad:boolean) => void = undefined

  aboutToAppear() {
    for (let i = 0; i < 20; i++) {
      this.arr1.push(i)
    }
    for (let i = 0; i < 20; i++) {
      this.arr2.push(i)
    }
  }

  @Builder
  itemLayout(_: Object, index: number) {
    ListItemV2View({index:index})
  }

  build() {
    ListLayout({
      items: this.pageType == 0 ? this.arr1 : this.arr2,
      itemLayout: this.itemLayout,
      controller: this.controller,
      refreshStickyPosition: this.listPosition,
      isRefreshSticky: true,
      isAutoLoadMoreData: true, //底部自动加载数据
      onRefresh: () => {
        //下拉刷新 模拟耗时
        setTimeout(() => {
          this.controller.finishRefresh()
        }, 3000)
      },
      onLoadMore: () => {
        // 上拉加载 模拟耗时
        if (this.onLoadMore != undefined) {
          this.onLoadMore(false)
        }
        setTimeout(() => {
          for (let i = 0; i < 20; i++) {
            this.arr1.push(i)
          }
          this.controller.finishLoadMore()
          if (this.onLoadMore != undefined) {
            this.onLoadMore(true)
          }
        }, 3000)
      }
    })
  }
}