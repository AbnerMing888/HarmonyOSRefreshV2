import { ActionBar } from '../ActionBar'
import { RefreshController, RefreshLayout } from '@abner/refresh_v2'

/**
 * AUTHOR:AbnerMing
 * DATE:2025/3/20
 * INTRODUCE:任意组件
 * */

@Entry
@ComponentV2
struct LayoutViewPage {
  @Local controller: RefreshController = new RefreshController() //刷新控制器

  @Builder
  itemLayout() {
    //可以是任何的组件
    Column() {
      Text("我是测试数据")
    }.width("100%")
    .height("100%")
    .backgroundColor(Color.Pink)
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Column() {
      ActionBar({ title: "任意组件" })
      RefreshLayout({
        itemLayout: this.itemLayout,
        controller: this.controller,
        onRefresh: () => {
          setTimeout(() => {
            //模拟耗时
            this.controller.finishRefresh()
          }, 3000)
        },
        onLoadMore: () => {
          setTimeout(() => {
            //模拟耗时
            this.controller.finishLoadMore()
          }, 3000)
        }
      })
    }
  }
}