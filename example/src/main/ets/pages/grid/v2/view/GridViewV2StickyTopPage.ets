import { GridView, RefreshController } from '@abner/refresh_v2'
import { RouterPath } from '@abner/router'
import { ListItemV2View } from '../../../../view/ListItemV2View'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/7/16
 * INTRODUCE:网格吸顶页面 案例
 * */

@RouterPath("example_GridViewV2StickyTopPage")
@ComponentV2
export struct GridViewV2StickyTopPage {
  build() {
    Scroll() {
      Column() {
        Text("头View")
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

  }

  /*
  * Author:AbnerMing
  * Describe:这里仅仅是测试，实际应以业务需求为主，可以是任意得组件视图
  */
  @Builder
  testLayout(type: number) {
    StickyGridView({ pageType: type })
  }
}

/*
* Author:AbnerMing
* Describe:吸顶列表
*/
@ComponentV2
struct StickyGridView {
  @Param pageType: number = 0
  controller: RefreshController = new RefreshController() //刷新控制器
  @Local arr1: number[] = [] //实际情况当以tab指示器对应得数据为主，这里仅仅是测试
  @Local arr2: number[] = []

  aboutToAppear() {
    for (let i = 0; i < 50; i++) {
      this.arr1.push(i)
    }
    for (let i = 0; i < 50; i++) {
      this.arr2.push(i)
    }
  }

  @Builder
  itemLayout(_: Object, index: number) {
    ListItemV2View({ index: index })
  }

  build() {
    GridView({
      items: this.pageType == 0 ? this.arr1 : this.arr2,
      itemLayout: this.itemLayout,
      controller: this.controller,
      gridNestedScroll: {
        scrollForward: NestedScrollMode.PARENT_FIRST,
        scrollBackward: NestedScrollMode.SELF_FIRST
      }
    })
  }
}