import { TitleBar } from '@abner/bar'
import { GridLayout } from '@abner/refresh_v2'
import { RouterPath } from '@abner/router'
import { ListItemV2View } from '../../../../view/ListItemV2View'

/**
 * AUTHOR:AbnerMing
 * DATE:2023/10/14
 * INTRODUCE:普通的列表GridLayoutPage页面
 * */
@RouterPath("example_GridLayoutV2Page")
@ComponentV2
export struct GridLayoutV2Page {
  @Local array: Array<number> = []

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
    ListItemV2View({ index: index })
  }

  build() {
    Column() {
      TitleBar({ title: "(V2)普通数据模式(GridLayout)" })
      GridLayout({
        items: this.array, //数据源 数组
        itemLayout: (item, index) => this.itemLayout(item, index),
        gridAttribute: (attr) => {
          attr.edgeEffect = EdgeEffect.Spring //设置阻尼效果
        }
      })
    }
  }
}