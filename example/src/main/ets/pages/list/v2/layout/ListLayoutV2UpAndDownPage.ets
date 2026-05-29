import { TitleBar } from "@abner/bar"
import { ListLayout, RefreshController } from "@abner/refresh_v2"
import { RouterPath } from "@abner/router"
import { ListItemV2View } from "../../../../view/ListItemV2View"

/**
 * AUTHOR:AbnerMing
 * DATE:2026/4/22
 * INTRODUCE:下拉刷新和上拉加载ListView:普通模式
 * */
@RouterPath("example_ListLayoutV2UpAndDownPage")
@ComponentV2
export struct ListLayoutV2UpAndDownPage {
  controller: RefreshController = new RefreshController() //刷新控制器
  @Local array: number[] = []

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
      TitleBar({ title: "(V2)刷新&加载ListLayout（普通数据）" })
      ListLayout({
        items: this.array,
        itemLayout: this.itemLayout,
        controller: this.controller,
        onRefresh: () => {
          //下拉刷新
          setTimeout(() => {
            //模拟耗时
            this.controller.finishRefresh()
          }, 3000)
        },
        onLoadMore: () => {
          //下拉刷新
          setTimeout(() => {
            //模拟耗时
            for (let i = 0; i < 20; i++) {
              this.array.push(i)
            }
            this.controller.finishLoadMore()
          }, 3000)
        }
      })
    }.width("100%")
    .height("100%")
  }
}