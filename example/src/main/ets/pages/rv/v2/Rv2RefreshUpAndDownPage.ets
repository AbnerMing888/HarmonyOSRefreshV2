import { TitleBar } from '@abner/bar';
import { RefreshController, RefreshView } from '@abner/refresh_v2';
import { RouterPath } from '@abner/router';

/**
 * AUTHOR:AbnerMing
 * DATE:2025/10/25
 * INTRODUCE:任意组件下拉上拉
 * */
@RouterPath("example_Rv2RefreshUpAndDownPage")
@ComponentV2
export struct Rv2RefreshUpAndDownPage {
  controller: RefreshController = new RefreshController()

  @Builder
  itemLayout() {
    Column() {
      Text("【我是任意组件】")
        .fontColor(Color.White)
    }.width("100%")
    .height("100%")
    .backgroundColor($r("app.color.tab_select_color"))
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Column() {
      TitleBar({
        title: "(V2)【任意组件刷新】"
      })

      RefreshView({
        itemLayout: this.itemLayout,
        controller: this.controller,
        onRefresh: () => {
          //下拉刷新
          setTimeout(() => {
            //模拟耗时
            this.controller.finishRefresh()
          }, 2000)
        },
        onLoadMore: () => {
          //加载更多
          setTimeout(() => {
            //模拟耗时
            this.controller.finishLoadMore()
          }, 2000)
        }
      })

    }
    .height('100%')
    .width('100%')
  }
}