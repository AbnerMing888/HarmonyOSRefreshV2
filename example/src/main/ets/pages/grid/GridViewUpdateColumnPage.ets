import { ActionBar } from '../ActionBar'
import { GridView, RefreshController } from '@abner/refresh_v2'

/**
 * AUTHOR:AbnerMing
 * DATE:2025/9/24
 * INTRODUCE:动态更新列数
 * 有两种方式，一种是通过columnSize，另一种是通过columnsTemplate
 * */

@Entry
@ComponentV2
struct GridViewUpdateColumnPage {
  controller: RefreshController = new RefreshController() //刷新控制器
  @Local array: Array<number> = []
  @Local columnSize: number = 2
  @Local columnsTemplate: string = "1fr 1fr"

  aboutToAppear() {
    for (let i = 0; i < 50; i++) {
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
    Text("测试数据" + index)
      .width("95%")
      .height(50)
      .textAlign(TextAlign.Center)
      .border({ width: 1, color: Color.Pink })
      .margin({ top: 10 })
  }

  build() {
    Column() {
      ActionBar({ title: "动态更新列数" })

      Row() {
        Button("方式一")
          .onClick(() => {
            this.columnSize = 3
          })
        Button("方式二")
          .onClick(() => {
            this.columnsTemplate = "1fr 1fr 1fr 1fr"
            this.controller.notifyAttribute()
          })
      }

      GridView({
        items: this.array, //数据源 数组
        columnSize: this.columnSize,
        itemLayout: (item, index) => this.itemLayout(item, index),
        controller: this.controller, //控制器，负责关闭下拉和上拉，
        gridAttribute: (g) => {
          g.rowsGap = 10 //设置行间距
          g.columnsTemplate = this.columnsTemplate
        },
        onRefresh: () => {
          //下拉刷新
          setTimeout(() => {
            //模拟耗时
            this.controller.finishRefresh()
          }, 3000)
        },
        onLoadMore: () => {
          //上拉加载
          setTimeout(() => {
            //模拟耗时
            for (let i = 100; i < 110; i++) {
              this.array.push(i)
            }
            this.controller.finishLoadMore()
          }, 3000)
        }
      })
    }
  }
}
