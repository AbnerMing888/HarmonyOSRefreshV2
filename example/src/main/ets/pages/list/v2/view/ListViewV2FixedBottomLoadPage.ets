import { TitleBar } from '@abner/bar'
import { ListView, RefreshController } from '@abner/refresh_v2'
import { RouterPath } from '@abner/router'
import { ListItemV2View } from '../../../../view/ListItemV2View'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/9/3
 * INTRODUCE:固定底部上拉加载无数据
 * */
@RouterPath("example_ListViewV2FixedBottomLoadPage")
@ComponentV2
export struct ListViewV2FixedBottomLoadPage {
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
      TitleBar({ title: "(V2)固定底部上拉加载无数据" })
      ListView({
        items: this.array,
        itemLayout: (item, index) => this.itemLayout(item, index),
        controller: this.controller, //控制器，负责关闭下拉和上拉
        slideDisplayLoadData:true,
        onRefresh: () => {
          //下拉刷新
          setTimeout(() => {
            this.controller.isNothingFixedBottom = false //关闭
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
            this.controller.finishLoadMoreFixedBottom(true) //开启
          }, 3000)
        }
      })
    }
  }
}