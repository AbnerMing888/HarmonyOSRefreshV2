import { ActionBar } from '../ActionBar'
import { GridView, RefreshController } from '@abner/refresh_v2'

/**
 * AUTHOR:AbnerMing
 * DATE:2025/3/20
 * INTRODUCE:普通的列表GridView页面
 * */

@Entry
@ComponentV2
struct GridViewPage {
  @Local array: Array<number> = []
  controller: RefreshController = new RefreshController()

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

  @Local isTwo: boolean = true

  build() {
    Column() {
      ActionBar({ title: "普通的列表GridView" })
        .onClick(() => {
          this.isTwo = !this.isTwo
          this.controller.notifyAttribute()
        })
      GridView({
        items: this.array, //数据源 数组
        controller: this.controller,
        itemLayout: (item, index) => this.itemLayout(item, index),
        gridAttribute: (attr) => {
          attr.edgeEffect = EdgeEffect.Spring //设置阻尼效果
        }
      })
    }
  }
}