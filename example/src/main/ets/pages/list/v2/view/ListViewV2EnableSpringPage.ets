import { TitleBar } from '@abner/bar'
import { ListView, RefreshController } from '@abner/refresh_v2'
import { RouterPath } from '@abner/router'
import { ListItemV2View } from '../../../../view/ListItemV2View'

/**
 * AUTHOR:AbnerMing
 * DATE:2025/5/20
 * INTRODUCE:禁止刷新和加载后，也支持阻尼效果
 * */

@RouterPath("example_ListViewV2EnableSpringPage")
@ComponentV2
export struct ListViewV2EnableSpringPage {
  controller: RefreshController = new RefreshController() //刷新控制器
  @Local array: Array<number> = []

  aboutToAppear() {
    for (let i = 0; i < 20; i++) {
      this.array.push(i)
    }
  }

  /**
   * Author:AbnerMing
   * Describe:条目布局
   * @param item  数据对象
   * @param index  数据索引
   */
  @Builder
  itemLayout(_: Object, index: number): void {
    ListItemV2View({ index: index })
  }

  build() {
    Column() {
      TitleBar({ title: "刷新加载禁止后支持阻尼" })
      ListView({
        items: this.array,
        itemLayout: (item, index) => this.itemLayout(item, index),
        controller: this.controller, //控制器，负责关闭下拉和上拉
        enableRefresh: false,
        enableLoadMore: false,
        isEnableRefreshSpring: true,
        isEnableLoadMoreSpring: true,
        onRefresh: () => {
          //下拉刷新
          setTimeout(() => {
            this.controller.finishRefresh()
          }, 3000)
        },
        onLoadMore: () => {
          //上拉加载
          setTimeout(() => {
            //模拟耗时
            for (let i = 0; i < 20; i++) {
              this.array.push(i)
            }
            this.controller.finishLoadMore()
          }, 3000)
        }
      })
    }
  }
}